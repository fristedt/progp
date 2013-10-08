import java.io.File;
/* Responsible for telling the server when its time to push out a new list */
/* of strings to the client. */
public class FileTransferThread extends Thread {
    private File file = new File(ATMServer.SERVER_STRINGS_FILENAME);
    public void run() {
        while (true) {
            if (!isFileUpdated()) {
                ATMServer.pushStrings();
                ATMServer.lastUpdate = file.lastModified();
            }
            try {
                Thread.sleep(1000);
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        }
    }
    
    private boolean isFileUpdated() {
        return file.lastModified() == ATMServer.lastUpdate;
    }
}
