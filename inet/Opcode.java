public enum Opcode {
    OUTPUT(0),
    INPUT(1),
    OUTPUT_STRING(3),
    CHANGE_LANGUAGE(4),
    STRINGS(5),
    RESPONSE(6);

    private int code;

    private Opcode(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static Opcode fromInt(int n) {
        for (Opcode opcode : values()) {
            if (n == opcode.getCode())
                return opcode;
        }
        return null;
    }
}
