package java.lang;

public class StringIndexOutOfBoundsException extends IndexOutOfBoundsException {
    public StringIndexOutOfBoundsException() {
        super();
    }

    public StringIndexOutOfBoundsException(final String s) {
        super(s);
    }

    public StringIndexOutOfBoundsException(final int index) {
        super("String index out of range: " + index);
    }
}