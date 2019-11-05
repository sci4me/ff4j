package java.lang;

public class Short extends Number {
    @SuppressWarnings("unchecked")
    public static final Class<Short> TYPE = (Class<Short>) Class.getPrimitiveClass("short");

    private final short value;

    public static Short valueOf(final short value) {
        return new Short(value);
    }

    public Short(final short value) {
        this.value = value;
    }

    public String toString() {
        return Number.toString(this.value);
    }

    public short shortValue() {
        return this.value;
    }

    @Override
    public boolean equals(final Object obj) {
        if(obj instanceof Short) {
            return this.value == ((Short)obj).shortValue();
        }
        return false;
    }
    
    @Override
    public int hashCode() {
        return (int) this.value;
    }
}