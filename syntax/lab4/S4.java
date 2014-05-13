import java_cup.runtime.Symbol;
import java.util.*;
import java.io.*;

class S4 
{
    public static void main(String args[])  
    throws Exception {
	BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

	// Let's pretend we have the game infrastructure:
	System.out.println("\n    Welcome to the ProgP Syntax game!\n");
	System.out.println("You are in 'Spel'. There are no available computers.");
	System.out.println("There is an exit to the corridor to the west.");

	// Here starts the command/execute loop of the game.
	while (true) {
	    List<Command> cmds=null;

	    // Ask for a command from the user.
	    System.out.print("> ");
	    String str = reader.readLine();

	    // We only bother to analyze the command if it is non-trivial.
	    if (str == null) {	// From Ctrl-D
		System.exit(0);
	    } else if (str.length() > 0) { // Non-empty command
		try {
		    // Here we start a parser. It needs a lexer, which 
		    // in turn needs a Reader. Normally, this is a file, but
		    // if we want to read from strings, a StringReader is suitable.
		    // Note: If we read from a file (including stdin), the parser
		    // wants to parse everything in the file.
		    StringReader strReader = new StringReader(str);
		    Tolk p = new Tolk(new TolkLexer(strReader));

		    cmds = (List<Command>) p.parse().value; // We get a warning for unchecked cast here. Sorry!

		    // For debugging:
		    //   cmds = (List<Command>) p.debug_parse().value;
		    // You get a print out of what state the parser is in and what 
		    // symbols it sees. Use in combination with 'make parserdump'!
		}
		catch (Exception e) {
		    System.out.println("Is that English?");
		    continue;
		}

		// Execute every command we have found.
		for (Iterator<Command> i = cmds.iterator(); i.hasNext(); ) {
		    Command c = i.next();
		    c.action(); // Just a test function. For a game, we would need to supply more info to this method.
		}
	    }
	}
    }

}
