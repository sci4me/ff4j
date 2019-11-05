package java.lang;

public final class Long extends Number {
    @SuppressWarnings("unchecked")
    public static final Class<Long> TYPE = (Class<Long>) Class.getPrimitiveClass("long");

    private final long value;

    public static Long valueOf(final long value) {
        return new Long(value);
    }

    public Long(final long value) {
        this.value = value;
    }

    public String toString() {
        return Number.toString(value);
    }

    public long longValue() {
        return this.value;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Long) {
            return this.value == ((Long)obj).longValue();
        }
        return false;
    }

    // TODO: hashCode
}