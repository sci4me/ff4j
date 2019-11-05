package java.lang;

public class Exception extends Throwable {
    public Exception() {
        super();
    }

    public Exception(final String message) {
        super(message);
    }

    public Exception(final String message, final Throwable cause) {
        super(message, cause);
    }

    public Exception(final Throwable cause) {
        super(cause);
    }
}