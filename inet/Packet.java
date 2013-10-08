public class Packet {
    private long packet;

    public static Packet parseString(String string) {
        long n = Long.parseLong(string);
        return new Packet(n);
    }

    public Packet (long n) {
        packet = n;
    }

    public Packet (Opcode opcode, int value) {
        packet = (value << 4) | (opcode.getCode() & 0xf);
    }

    public long getPacket() {
        return packet;
    }

    public Opcode getOpcode() {
        return Opcode.fromInt((int) (packet & 0xf));
    }

    public int getValue() {
        return (int) (packet >> 4);
    }

    public String toString() {
        return Long.toString(packet);
    }
}
