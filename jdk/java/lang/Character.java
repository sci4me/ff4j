 
package java.lang;

public final class Character {
    @SuppressWarnings("unchecked")
    public static final Class<Character>  TYPE = (Class<Character>) Class.getPrimitiveClass("char");

    private final char value;

    public static Character valueOf(char value) {
        return new Character(value);
    }

    public Character(char value) {
        this.value = value;
    }

    public String toString() {
        return new String(new char[] {this.value});
    }

    public char charValue() {
        return this.value;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Character) {
            return this.value == ((Character)obj).charValue();
        }
        return false;
    }
    
    @Override
    public int hashCode() {
        return (int) this.value;
    }
}