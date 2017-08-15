package com.saj.exception;

public class AddProductFailedException extends RuntimeException {

	public AddProductFailedException() {
		super();
	}

	public AddProductFailedException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public AddProductFailedException(String message, Throwable cause) {
		super(message, cause);
	}

	public AddProductFailedException(String message) {
		super(message);
	}

	public AddProductFailedException(Throwable cause) {
		super(cause);
	}

}
