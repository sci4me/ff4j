package java.lang;

public class Error extends Throwable {
    public Error() {
        super();
    }

    public Error(final String message) {
        super(message);
    }

    public Error(final String message, final Throwable cause) {
        super(message, cause);
    }

    public Error(final Throwable cause) {
        super(cause);
    }
}
