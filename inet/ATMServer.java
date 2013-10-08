import java.net.*;
import java.io.*;
import java.util.concurrent.*;
import java.util.*;

/**
   @author Viebrapadata
*/
public class ATMServer {

    /* Takes cardNumber+password as hash. */
    public static ConcurrentHashMap<Integer, Integer> users;
    private static int connectionPort = 8989;
    private static ArrayList<ATMServerThread> serverThreads;
    public static final String SERVER_STRINGS_FILENAME = "server_strings.txt";
    public static long lastUpdate = 0;
    private static File userFile;

    public static void main(String[] args) throws IOException {
        /* Copy all the users in the file users.txt into the HashMap users. */
        /* Also add their balances. */
        userFile = new File("users.txt");
        getUsers();
        
        ServerSocket serverSocket = null;

        /* Start the thread responsible for checking when it's time to update the */
        /* file containing the different strings. */
        new FileTransferThread().start();
       
        boolean listening = true;
        serverThreads = new ArrayList<ATMServerThread>();
        try {
            serverSocket = new ServerSocket(connectionPort); 
        } catch (IOException e) {
            System.err.println("Could not listen on port: " + connectionPort);
            System.exit(1);
        }
	
        System.out.println("Bank started listening on port: " + connectionPort);
        while (listening) {
            /* When a client has connected, assign a new thread to the client and add */
            /* the thread to the list of threads. */
            ATMServerThread serverThread = new ATMServerThread(serverSocket.accept());
            serverThread.start();
            serverThreads.add(serverThread);
        }

        serverSocket.close();
    }

    /* Retrieves user hashes and balances from file. */
    private static void getUsers() {
        users = new ConcurrentHashMap<Integer, Integer>();
        try {
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                        new FileInputStream(userFile), "UTF-8"));
            String line;
            String split[];
            while ((line = in.readLine()) != null) {
                split = line.split(":");
                users.put(Integer.valueOf(split[0]), Integer.valueOf(split[1]));
            }
            in.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    /* Writes user hashes and balances to file. */
    public static void writeUsers() {
        File tmpFile = new File("tmp.txt");
        try {
            FileWriter fileWriter = new FileWriter(tmpFile);
            for (Map.Entry<Integer, Integer> entry : users.entrySet()) {
                fileWriter.write(entry.getKey() + ":" + entry.getValue() + "\n");
            }
            fileWriter.close();
            tmpFile.renameTo(userFile);
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    /* Tell all active threads to push strings to their respective clients. */
    public static void pushStrings() {
        for (ATMServerThread serverThread : serverThreads) {
            serverThread.pushStrings();
        }
    }
}
