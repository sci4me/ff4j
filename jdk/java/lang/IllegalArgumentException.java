package java.lang;

public class IllegalArgumentException extends RuntimeException {
    public IllegalArgumentException() {
        super();
    }

    public IllegalArgumentException(final String s) {
        super(s);
    }

    public IllegalArgumentException(final String message, final Throwable cause) {
        super(message, cause);
    }

    public IllegalArgumentException(final Throwable cause) {
        super(cause);
    }
}
