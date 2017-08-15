package com.saj.controller;

import java.util.List;
import java.util.Locale;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saj.dto.FieldErrors;
import com.saj.dto.ProductDetail;
import com.saj.exception.AddProductFailedException;
import com.saj.form.ProductForm;
import com.saj.validator.ProductValidator;

@Controller
public class AddProductController {
	@Autowired
	protected ProductValidator productValidator;

	@Autowired
	protected MessageSource messageSource;

	
	@RequestMapping("/show-add-product.htm")
	public String showProductForm() {
		//throw new AddProductFailedException("unable to add product");
		return "add-product";
	}

	@RequestMapping(value = "/add-product.json", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> addProduct(Model model, @RequestBody ProductForm productForm, BindingResult errors) {
		FieldErrors fErrors = null;
		ProductDetail productDetail = null;
		List<FieldError> sErrors = null;

		if (productValidator.supports(productForm.getClass())) {
			productValidator.validate(productForm, errors);
			if (errors.hasErrors()) {
				fErrors = new FieldErrors();
				sErrors = errors.getFieldErrors();
				for (FieldError error : sErrors) {
					fErrors.addError(error.getField(),
							messageSource.getMessage(error.getCode(), null, Locale.getDefault()));
				}
				return new ResponseEntity(fErrors, HttpStatus.BAD_REQUEST);
			}
		}

		productDetail = new ProductDetail();
		productDetail.setProductId(new Random(3939).nextInt());
		productDetail.setProductName(productForm.getProdName());
		productDetail.setDescription(productForm.getDescr());
		productDetail.setProductType(productForm.getpType());
		productDetail.setPrice(productForm.getPrice());

		return new ResponseEntity(productDetail, HttpStatus.OK);
	}

}
