package java.lang;

public final class Double extends Number {
    @SuppressWarnings("unchecked")
    public static final Class<Double> TYPE = (Class<Double>) Class.getPrimitiveClass("double");

    private final double value;

    public static Double valueOf(final double value) {
        return new Double(value);
    }

    public Double(final double value) {
        this.value = value;
    }

    public String toString() {
        return Number.toString(this.value);
    }

    public double doubleValue() {
        return this.value;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Double) {
            return this.value == ((Double)obj).doubleValue();
        }
        return false;
    }

    // TODO: hashCode
}