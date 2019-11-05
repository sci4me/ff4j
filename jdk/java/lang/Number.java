package java.lang;

public abstract class Number {
    public static native String toString(final long value);
    public static native String toString(final double value);
    public static native String toString(final int value);
    public static native String toString(final float value);
}