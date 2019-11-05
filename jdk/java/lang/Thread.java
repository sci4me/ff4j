package java.lang;

public class Thread implements Runnable {
	public static final int MIN_PRIORITY = 1;
	public static final int NORM_PRIORITY = 1;
	public static final int MAX_PRIORITY = 1;

	public static native Thread currentThread();
	public static native void yield();
	public static native void sleep(final long millis) throws InterruptedException;
	public static native void sleep(final long millis, final long nanos) throws InterruptedException;

	public boolean interrupted() {
		return Thread.currentThread().isInterrupted(true);
	}

	private char[] name;
	private int priority;
	private boolean daemon;
	private Runnable target;

	public Thread() {

	}

	public Thread(final Runnable target) {

	}

	// TODO: Thread(ThreadGroup, Runnable)

	public Thread(final String name) {

	}

	// TODO: Thread(ThreaGroup, String)

	public Thread(final Runnable target, final String name) {

	}

	// TODO: Thread(ThreadGroup, Runnable, Name)

	public Thread(/*final ThreadGroup group,*/ final Runnable target, final String name, final long stackSize) {
		// TODO
	}

	private void init(/*final ThreadGroup group,*/ final Runnable target, final String name, final long stackSize) {
		final Thread parent = Thread.currentThread();

		this.name = name.toCharArray();
		this.setPriority(parent.getPriority());
		this.daemon = parent.isDaemon();
		this.target = target;
	}

	@Override
	public void run() {
		if(this.target != null) this.target.run();
	}

	public void interrupt() {
		// TODO
	}

	public boolean isInterrupted() {
		return this.isInterrupted(false);
	}

	private native boolean isInterrupted(final boolean clearInterrupted);

	public final native boolean isAlive();

	public final void setPriority(final int priority) {
		if(priority < MIN_PRIORITY || priority > MAX_PRIORITY) throw new IllegalArgumentException();
	}

	public final int getPriority() {
		return this.priority;
	}

	public final void setName(final String name) {
		this.name = name.toCharArray();
	}

	public final String getName() {
		return new String(this.name);
	}

	// TODO: join

	public final void setDaemon(final boolean daemon) throws IllegalThreadStateException {
		if(this.isAlive()) throw new IllegalThreadStateException();
		this.daemon = daemon;
	}

	public final boolean isDaemon() {
		return this.daemon;
	}

	// TODO: toString

	// TODO: getStackTrace

	// TODO: getId

	public enum State {
		NEW,
		RUNNABLE,
		BLOCKED,
		WAITING,
		TIMED_WAITING,
		TERMINATED
	}

	// TODO: getState

	// TODO: uncaught exception handler
}