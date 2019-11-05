package java.lang;

public final class Class<T> {
	private final String name;

	private Class(final String name) {
		this.name = name;
	}

	public String getName() {
		return this.name;
	}

	@Override
	public String toString() {
		return "class " + this.name;
	}

	public static native Class getPrimitiveClass(final String name);
}