abstract class Command
{
    public boolean action(Game r)
    {
	return true;
    }

    public boolean action()
    {
	return true;
    }
}


class GoCommand extends Command
{
    private Direction dir;

    public GoCommand(Direction d)
    {
	dir = d;
    }

    public boolean action(Game r)
    {
	return true;
    }

    public boolean action()
    {
	System.out.print("Go ");
	System.out.println(dir);
	return true;
    }
}

class TakeCommand extends Command
{
    private Things what;

    public TakeCommand(Things t)
    {                
	what = t;
    }

    public boolean action(Game r)
    {
	return true;
    }
    public boolean action()
    {
	System.out.println("Take: " + what.show());
	return true;
    }
}

class DropCommand extends Command
{
    private Things what;

    public DropCommand(Things t)
    {
	what = t;
    }

    public boolean action(Game r)
    {
	return true;
    }

    public boolean action()
    {
	System.out.println("Drop: " + what.show());
	return true;
    }
}
class QuitCommand extends Command
{
    public boolean action(Game r)
    {
	return true;
    }

    public boolean action()
    {
	System.out.println("Good bye!");
	System.exit(0);
	return true;
    }


}

class GreetCommand extends Command
{
    private People who;
    public GreetCommand(People p) {
	who = p;
    }
    public boolean action(Game r)
    {
	return true;
    }

    public boolean action()
    {
	System.out.println("Hej! " + who); // säger hej till person who
	return true;
    }
}


class SayCommand extends Command
{
    private String sentence;
    private People person;

    public SayCommand(String s, People p)
    {
	sentence = s;
	person = p;
    }

    public boolean action(Game r)
    {
	return true;
    }

    public boolean action()
    {
	System.out.println("To " + person + ": " + sentence);
	return true;
    }
}

class AmbigousCommand extends Command
{
    private String question;
    public AmbigousCommand(String q)
    {
	question = q;
    }

    public boolean action(Game r)
    {
	return true;
    }

    public boolean action()
    {
	System.out.println(question + "?");
	return true;
    }
}
