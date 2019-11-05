package java.lang;

public class Object {
	public native String toString();

    public native Class<?> getClass();

    public boolean equals(final Object obj) {
        return this == obj;
    }
    
    public native int hashCode();
}