import java.io.*;   
import java.net.*;  
import java.util.Scanner;
import java.util.ArrayList;

/**
   @author Snilledata
*/
public class ATMClient {
    private static int connectionPort = 8989;
    private static Scanner scanner = new Scanner(System.in);
    private static PrintWriter out = null;
    private static BufferedReader in = null;
    private static String prompt = "> ";
    private static String lang = "en";
    public static final String CLIENT_STRINGS_FILENAME = "client_strings.txt";
    private static ArrayList<Integer> usedCodes;
    
    public static void main(String[] args) throws IOException {
        usedCodes = new ArrayList<Integer>();
        Socket ATMSocket = null;
        String adress = "";

        try {
            adress = args[0];
        } catch (ArrayIndexOutOfBoundsException e) {
            System.err.println("Missing argument ip-adress");
            System.exit(1);
        }
        try {
            ATMSocket = new Socket(adress, connectionPort); 
            out = new PrintWriter(ATMSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader
                                    (ATMSocket.getInputStream()));
        } catch (UnknownHostException e) {
            System.err.println("Unknown host: " +adress);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Couldn't open connection to " + adress);
            System.exit(1);
        }

        listen();

        out.close();
        in.close();
        ATMSocket.close();
    }

    /* Main loop. */
    private static void listen() throws IOException {
        String line;
        while ((line = in.readLine()) != null) {
            Packet call = Packet.parseString(line);
            switch (call.getOpcode()) {
                case OUTPUT:
                    /* Output the value to stdout.  */
                    System.out.println(call.getValue());
                    break;

                case OUTPUT_STRING:
                    /* Output the string with the value as index.  */
                    printString(call.getValue());
                    break;

                case INPUT:
                    /* Let user input an int and send it back to the server.  */
                    Packet input = input();
                    out.println(input);
                    break;

                case CHANGE_LANGUAGE:
                    changeLanguage();
                    break;

                case STRINGS:
                    /* Recieve an updated list of strings.  */
                    recieveStrings();
                    break;
            }
        }
    }

    /* Goes through the file containing strings and returns */
    /* the string with the correct language and index. */
    private static void printString(int stringIndex) {
        File file = new File(CLIENT_STRINGS_FILENAME);
        try {
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                        new FileInputStream(file), "UTF-8"));
            String line;
            String split[];
            while ((line = in.readLine()) != null) {
                split = line.split(":");
                if (!split[0].equals(lang)) 
                    continue;

                int index = Integer.valueOf(split[1]);
                if (index != stringIndex)
                    continue;

                System.out.println(split[2]);
                return;
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        System.out.println("Could not find string.");
    }

    /* Handles client input. Return a packet to send back to server. */
    private static Packet input() {
        System.out.print(prompt);
        int input = scanner.nextInt();
        Packet packet = new Packet(Opcode.RESPONSE, input);

        return packet;
    }  

    /* Handles the changing of language. */
    private static void changeLanguage() {
        File file = new File(CLIENT_STRINGS_FILENAME);
        ArrayList<String> languages = new ArrayList<String>();
        try {
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                        new FileInputStream(file), "UTF-8"));
            String line;
            String split[];
            while ((line = in.readLine()) != null) {
                split = line.split(":");
                /* If the language is not already in the list of languages, */
                /*    add it to the list. */
                if (!languages.contains(split[0])) {
                    languages.add(split[0]);
                }
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        printString(Strings.AVALIABLE_LANGUAGES);
        for (String language : languages) {
            System.out.println(language);
        }
        
        printString(Strings.LANGUAGE_PROMPT);
        String input = scanner.next();
        if (!languages.contains(input)) {
            printString(Strings.NOT_A_LANGUAGE);
            return;
        }
        lang = input;
    }

    /* Used to recieve file containing strings to print. */
    private static void recieveStrings() {
        try {
            PrintWriter writer = new PrintWriter(CLIENT_STRINGS_FILENAME, "UTF-8");
            String line;
            while (!(line = in.readLine()).equals("done")) {
                writer.println(line);
            }
            writer.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }
}
