package java.lang;

// TODO: implement Serializable, Comparable<Boolean>

public final class Boolean {
    @SuppressWarnings("unchecked")
    public static final Class<Boolean> TYPE = (Class<Boolean>) Class.getPrimitiveClass("boolean");

    public static final Boolean TRUE = new Boolean(true);
    public static final Boolean FALSE = new Boolean(false);
    
    private final boolean value;

    public static Boolean valueOf(boolean value) {
        return value ? TRUE : FALSE;
    }

    public Boolean(boolean value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return this.value ? "true" : "false";
    }

    public boolean booleanValue() {
        return this.value;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Boolean) {
            return this.value == ((Boolean)obj).booleanValue();
        }
        return false;
    }
    
    @Override
    public int hashCode() {
        if(this.value) {
            return 1231;
        } else {
            return 1237;
        }
    }
}