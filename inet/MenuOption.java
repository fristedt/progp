public enum MenuOption {
    BALANCE(1),
    WITHDRAWAL(2),
    DEPOSIT(3),
    CHANGE_LANGUAGE(4),
    EXIT(5);

    private int value;

    private MenuOption(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static MenuOption fromInt(int n) {
        for (MenuOption menuOption : values()) {
            if (n == menuOption.getValue())
                return menuOption;
        }
        return null;
    }
}
