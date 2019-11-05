package java.util;

public interface Collection<E> extends Iterable<E> {
    public boolean add(E e);
    public void clear();
    public boolean contains(E e);
    public Iterator<E> iterator();
    public boolean remove(E e);
    public int size();

    public default <T extends E> boolean retainAll(final Collection<T> c) {
        boolean ret = false;
        Iterator<E> i = iterator();
        while (i.hasNext()) {
            E e = i.next();
            if (!c.contains((T)e)) {
                i.remove();
                ret = true;
            }
        }
        return ret;
    }

    public default boolean containsAll(final Collection<? extends E> c) {
        for (E e : c) {
            if (!this.contains(e)) {
                return false;
            }
        }
        return true;
    }

    public default boolean removeAll(final Collection<? extends E> c) {
        boolean ret = false;
        for (E e : c) {
            ret = ret || this.remove(e);
        }
        return ret;
    }

    public default boolean isEmpty() {
        return size() == 0;
    }

    public default boolean addAll(final Collection<? extends E> c) {
        boolean ret = false;
        for (E e : c) {
            ret = ret || this.add(e);
        }
        return ret;
    }

    public default Object[] toArray() {
        Object[] arr = new Object[size()];
        int i = 0;
        for (E e : this) {
            arr[i++] = e;
        }
        return arr;
    }

    public default <T>T[] toArray(final T[] a) {
        int i = 0;
        for (E e : this) {
            a[i++] = (T)e;
        }
        return a;
    }
}