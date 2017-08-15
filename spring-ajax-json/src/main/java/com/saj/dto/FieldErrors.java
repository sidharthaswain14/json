package com.saj.dto;

import java.util.ArrayList;
import java.util.List;

public class FieldErrors {
	protected List<FieldError> errors;

	public FieldErrors() {
		errors = new ArrayList<FieldError>();
	}

	public void addError(String fieldName, String message) {
		errors.add(new FieldError(fieldName, message));
	}

	public List<FieldError> getErrors() {
		return errors;
	}

	public void setErrors(List<FieldError> errors) {
		this.errors = errors;
	}

}
