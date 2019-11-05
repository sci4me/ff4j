package java.lang;

public class RuntimeException extends Exception {
    public RuntimeException() {
        super();
    }

    public RuntimeException(final String message) {
        super(message);
    }

    public RuntimeException(final String message, final Throwable cause) {
        super(message, cause);
    }

    public RuntimeException(final Throwable cause) {
        super(cause);
    }
}