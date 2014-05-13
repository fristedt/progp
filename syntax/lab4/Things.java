public enum Things {
    HASKELLBOOK("Haskell book"),
	PROLOGBOOK("Prolog book"),
	UNKNOWNBOOK("some book"),
	PEN("pen"),
	PROGPLABNOTES("ProgP lab notes"),
	NUMMELABNOTES("Numme lab notes"),
	UNKNOWNLABNOTES("some lab notes");

    private String description;

    Things(String desc)	{
	this.description = desc;
    }

    public String show() {
	return description;
    }
}

