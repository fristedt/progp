import java.io.*;
import java.net.*;
import java.util.concurrent.*;
import java.util.*;

/**
   @author Viebrapadata
*/
public class ATMServerThread extends Thread {
    private Socket socket = null;
    private BufferedReader in;
    private PrintWriter out; 
    private ArrayList<Integer> usedCodes;

    public ATMServerThread(Socket socket) {
        super("ATMServerThread");
        this.socket = socket;
        usedCodes = new ArrayList<Integer>();
    }

    public void run(){
        try {
            out = new PrintWriter(socket.getOutputStream(), true);
            in = new BufferedReader
                (new InputStreamReader(socket.getInputStream()));

            /* Update the list of strings and start main loop.  */
            pushStrings();
            listen();

            out.close();
            in.close();
            socket.close();
        }catch (IOException e){
            e.printStackTrace();
        }
    
    }

    private void listen() throws IOException {
        /* Ask for login information. */
        out.println(new Packet(Opcode.OUTPUT_STRING, Strings.CARD_NUMBER));
        out.println(new Packet(Opcode.INPUT, 0));
        int cardNumber = Packet.parseString(in.readLine()).getValue();

        out.println(new Packet(Opcode.OUTPUT_STRING, Strings.PASSWORD));
        out.println(new Packet(Opcode.INPUT, 0));
        int password = Packet.parseString(in.readLine()).getValue();

        /* Super secret hashing algorithm. */
        int userHash = cardNumber + password;
        if (!ATMServer.users.containsKey(userHash)) {
            out.println(new Packet(Opcode.OUTPUT_STRING, Strings.INCORRECT_LOGIN));
            return;
        }

        /* Tell client to print welcome message. */
        out.println(new Packet(Opcode.OUTPUT_STRING, Strings.WELCOME));

        /* Ask client what to do. */
        out.println(new Packet(Opcode.INPUT, 0));

        /* Loop with logic regarding main menu. */
        String line;
        while ((line = in.readLine()) != null) {
            Packet response = Packet.parseString(line);
            MenuOption menuOption = MenuOption.fromInt(response.getValue());
            switch (menuOption) {
                case BALANCE:
                    /* Print balance. */
                    out.println(new Packet(Opcode.OUTPUT_STRING, Strings.BALANCE));
                    out.println(new Packet(Opcode.OUTPUT, ATMServer.users.get(userHash)));
                    break;
                case WITHDRAWAL:
                    /* Let user input one time code. */
                    out.println(new Packet(Opcode.OUTPUT_STRING, Strings.ENTER_CODE));
                    out.println(new Packet(Opcode.INPUT, 0));
                    int code = Packet.parseString(in.readLine()).getValue();
                    /* Reject withdrawal if user inputs wrong code. A correct code is odd. A correct code is only usable once.*/
                    if (usedCodes.contains(code) || (code % 2 == 0)) {
                        out.println(new Packet(Opcode.OUTPUT_STRING, Strings.WRONG_CODE));
                        break;
                    }
                    /* Let user input amount of money to withdraw. */
                    out.println(new Packet(Opcode.OUTPUT_STRING, Strings.WITHDRAWAL));
                    out.println(new Packet(Opcode.INPUT, 0));
                    int withdrawal = Packet.parseString(in.readLine()).getValue();
                    int deposit = ATMServer.users.get(userHash); 
                    /* Reject withdrawal if user doesn't have the money. */
                    if (deposit < withdrawal) {
                        out.println(new Packet(Opcode.OUTPUT_STRING, Strings.WITHDRAWAL_DENIAL));
                        break;
                    }
                    
                    /* Add the used code to the list of used codes and make the withdrawal. */
                    usedCodes.add(code);
                    ATMServer.users.put(userHash, deposit-withdrawal);
                    ATMServer.writeUsers();
                    break;
                case DEPOSIT:
                    /* Let user input amount of money to deposit. */
                    out.println(new Packet(Opcode.OUTPUT_STRING, Strings.DEPOSIT));
                    out.println(new Packet(Opcode.INPUT, 0));
                    int money = Packet.parseString(in.readLine()).getValue();
                    ATMServer.users.put(userHash, money + ATMServer.users.get(userHash));
                    ATMServer.writeUsers();
                    break;
                case CHANGE_LANGUAGE:
                    /* Let user change language.  */
                    out.println(new Packet(Opcode.CHANGE_LANGUAGE, 0));
                    break;
                case EXIT:
                    out.println(new Packet(Opcode.OUTPUT_STRING, Strings.GOOD_BYE));
                    return;
            }
            out.println(new Packet(Opcode.OUTPUT_STRING, Strings.WELCOME));
            /* Ask client what to do. */
            out.println(new Packet(Opcode.INPUT, 0));
        }
    }

    /* Used to send the file containing the different strings to the client. */
    public void pushStrings() {
        File file = new File(ATMServer.SERVER_STRINGS_FILENAME);
        try {
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                        new FileInputStream(file), "UTF-8"));
            out.println(new Packet(Opcode.STRINGS, 0)); 
            String line;
            while ((line = in.readLine()) != null) {
                out.println(line);
            }
            /* The most elegant piece of string termination ever. */
            out.println("done");
            in.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }
}
