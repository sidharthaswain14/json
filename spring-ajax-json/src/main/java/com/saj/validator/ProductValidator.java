package com.saj.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.saj.form.ProductForm;

@Component
public class ProductValidator implements Validator {

	@Override
	public boolean supports(Class<?> classType) {
		return classType.isAssignableFrom(ProductForm.class);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		ProductForm form = (ProductForm) obj;

		if (isEmpty(form.getProdName())) {
			errors.rejectValue("prodName", "productName.blank");
		}
		if (isEmpty(form.getDescr())) {
			errors.rejectValue("descr", "descr.blank");
		}
		if (isEmpty(form.getpType())) {
			errors.rejectValue("pType", "pType.blank");
		}
		if (form.getPrice() <= 0) {
			errors.rejectValue("price", "price.invalid");
		}
	}

	public boolean isEmpty(String s) {
		if (s == null || s.trim().length() == 0) {
			return true;
		}
		return false;
	}
}
