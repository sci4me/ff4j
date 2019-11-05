package java.lang;

public final class StackTraceElement {
    private String declaringClass;
    private String methodName;
    private String fileName;
    private int lineNumber;

    public StackTraceElement(final String declaringClass, final String methodName, final String fileName, final int lineNumber) {
        this.declaringClass = declaringClass;
        this.methodName = methodName;
        this.fileName = fileName;
        this.lineNumber = lineNumber;
    }

    public String getFileName() {
        return this.fileName;
    }

    public int getLineNumber() {
        return this.lineNumber;
    }

    public String getClassName() {
        return this.declaringClass;
    }

    public String getMethodName() {
        return this.methodName;
    }

    public boolean isNativeMethod() {
        return this.lineNumber == -2;
    }

    public String toString() {
        return getClassName() + "." + this.methodName +
            (isNativeMethod() ? "(Native Method)" :
             (this.fileName != null && this.lineNumber >= 0 ?
              "(" + this.fileName + ":" + this.lineNumber + ")" :
              (this.fileName != null ?  "(" + this.fileName + ")" : "(Unknown Source)")));
    }
}
