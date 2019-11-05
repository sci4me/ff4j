package java.lang;

public abstract class Enum<E extends Enum<E>> {
    private final String name;

    public final String name() {
        return this.name;
    }

    private final int ordinal;

    public final int ordinal() {
        return this.ordinal;
    }

    protected Enum(final String name, final int ordinal) {
        this.name = name;
        this.ordinal = ordinal;
    }

    public String toString() {
        return this.name;
    }

    public final boolean equals(Object other) {
        return this == other;
    }

    private static native <T extends Enum<T>> T _valueOf(final Class<T> enumType, final String name);

    public static <T extends Enum<T>> T valueOf(final Class<T> enumType, final String name) {
        T result = _valueOf(enumType, name);
        if (result != null) return result;
        if (name == null) throw new NullPointerException("Name is null");
        throw new IllegalArgumentException("No enum constant " + enumType.getName() + "." + name);
    }
}