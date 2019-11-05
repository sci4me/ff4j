package java.lang;

public class Float extends Number {
    public static final Class<Float> TYPE = (Class<Float>) Class.getPrimitiveClass("float");

    private final float value;

    public static Float valueOf(final float value) {
        return new Float(value);
    }

    public Float(final float value) {
        this.value = value;
    }

    public String toString() {
        return Number.toString(this.value);
    }

    public float floatValue() {
        return this.value;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Float) {
            return this.value == ((Float)obj).floatValue();
        }
        return false;
    }
}