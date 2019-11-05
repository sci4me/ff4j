package java.lang;

public class Math {
    public static native double pow(final double a, final double b);

    public static long min(final long a, final long b) {
        if (a < b)
            return a;
        return b;
    }

    public static double abs(final double a) {
        if (a < 0)
            return -a;
        return a;
    }
}
