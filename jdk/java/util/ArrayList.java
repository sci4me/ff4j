package java.util;

public class ArrayList<E> implements List<E> {
    private E[] array;

    public ArrayList() {
    }

    native public boolean add(E e);
    native public void clear();
    native public boolean remove(E e);

    /*
    @Override
    public boolean add(final E e) {
        return false;
    }

    @Override
    public void clear() {

    }

    @Override
    public boolean remove(final E e) {
        return false;
    }
    */

    @Override
    public void add(final int index, final E element) {

    }

    @Override
    public E remove(final int index) {
        return null;
    }

    public E get(int index) {
        return array[index];
    }

    public E set(int index, E element) {
        E ret = array[index];
        array[index] = element;
        return ret;
    }

    public List<E> subList(int fromIndex, int toIndex) {
        List<E> newList = new ArrayList<E>();
        for (int i = fromIndex; i < toIndex; ++i) {
            newList.add(get(i));
        }
        return newList;
    }

    public int size() {
        return array.length;
    }
}