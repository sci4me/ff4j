package java.lang;

public final class System {
    native public static void load(final String nativeName);

    public static native void arraycopy(final Object src, final int srcPos, final Object dest, final int destPos, final int length);
}