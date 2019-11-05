package java.lang;

public final class Integer extends Number {
    public static final int MIN_VALUE = 0x80000000;
    public static final int MAX_VALUE = 0x7fffffff;
    public static final Class<Integer> TYPE = (Class<Integer>) Class.getPrimitiveClass("int");

    private final int value;

    private static class IntegerCache {
        static final int low = -128;
        static final int high = 127;
        static final Integer[] cache;

        static {
            cache = new Integer[(high - low) + 1];
            int j = low;
            for(int k = 0; k < cache.length; k++)
                cache[k] = new Integer(j++);
        }

        private IntegerCache() { }
    }

    public static Integer valueOf(final int i) {
        assert IntegerCache.high >= 127;
        if (i >= IntegerCache.low && i <= IntegerCache.high)
            return IntegerCache.cache[i + (-IntegerCache.low)];
        return new Integer(i);
    }

    public static String toString(final int i) {
        return Number.toString(i);
    }

    private static final int[] sizeTable = { 9, 99, 999, 9999, 99999, 999999, 9999999, 99999999, 999999999, Integer.MAX_VALUE };

    private static int stringSize(int x) {
        for (int i = 0; ; i++)
            if (x <= sizeTable[i])
                return i + 1;
    }

    public Integer(int value) {
        this.value = value;
    }

    public String toString() {
        return Number.toString(this.value);
    }

    public int intValue() {
        return this.value;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Integer) {
            return this.value == ((Integer)obj).intValue();
        }
        return false;
    }
    
    @Override
    public int hashCode() {
        return this.value;
    }
}