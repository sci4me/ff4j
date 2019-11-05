package java.lang.annotation;

public interface Annotation {
    boolean equals(final Object obj);

    int hashCode();

    String toString();

    Class<? extends Annotation> annotationType();
}