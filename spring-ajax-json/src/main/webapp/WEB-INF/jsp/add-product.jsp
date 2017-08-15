<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Add Product</title>
		<style type="text/css">
			.errorClass {color: red;}
		</style>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
		<script type="text/javascript">
			function clearErrors() {
				$("p.errorClass").empty();
				$("p.errorClass").removeClass("errorClass");
			}
			function readData() {
				var data = {};

				$("inputs[type='text']").each(function(idx, obj){
					var id = $(obj).attr("id");
					data[id]=$(obj).val();
				});
				return JSON.stringify(data);
			}
			
			$(document).ready(function(){
				$("#addBtn").click(function(){
					var data;
					var url;
					var requestMethod;

					clearErrors();
					data = readData();
					url = $("#productForm").attr("action");
					requestMethod = $("#productForm").attr("method");

					$.ajax({
						dataType: "application/json",
						contentType: "application/json",
						url : url,
						data : data,
						method: requestMethod,
						success: function(data) {
							var prod = JSON.parse(data);
							$("#products").html(prod.productName);
						},
						error: function(jqXHR, textStatus, errorThrown) {
							alert("error : " +  textStatus);
							var allErrors = JSON.parse(jqXHR.responseText);
							for(var i=0;i<allErrors.errors.length;i++) {
								$("#"+allErrors.errors[i].fieldName+"_error").html(allErrors.errors[i].message);
								$("#"+allErrors.errors[i].fieldName+"_error").addClass("errorClass");
							}
						}
					});
					
				});
			});
		</script>
	</head>
	<body>
		<h2>Add Product</h2>
		<form action="${pageContext.request.contextPath}/add-product.json" method="post" id="productForm">
			<table>
				<tr>
					<td>Product Name: </td>
					<td>
						<input type="text" name="prodName" id="prodName"/>
						<p id="prodName_error"></p>
					</td>
				</tr>
				<tr>
					<td>Description: </td>
					<td>
						<input type="text" name="descr" id="descr"/>
						<p id="descr_error"></p>
					</td>
				</tr>
				<tr>
					<td>Type: </td>
					<td>
						<input type="text" name="pType" id="pType"/>
						<p id="pType_error"></p>
					</td>
				</tr>
				<tr>
					<td>Price: </td>
					<td>
						<input type="text" name="price" id="price"/>
						<p id="price_error"></p>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" id="addBtn" value="add"/>
					</td>
				</tr>
			</table>
		</form>
		<div id="products">
		</div>
		<!-- <script type="text/javascript">
			function clearErrors() {
				var pTags;

				pTags = document.querySelectorAll("p");
				for(var i=0;i<pTags.length;i++) {
					if(pTags[i].id.indexOf("_error") > 0) {
						pTags[i].innerHTML = "";
					}
				}
			}

			
			function addProduct() {
				var url = null;
				var http = null;
				var data = {};
				var allErrors = null;
				var reqMethod = null;
				var inputs = null;
				
				clearErrors();
				url = document.forms['productForm'].action;
				reqMethod = document.forms['productForm'].method;
				inputs = document.querySelectorAll("input[type='text']")
				for(var i=0;i<inputs.length;i++) {
					data[inputs[i].name] = inputs[i].value;
				}
				data = JSON.stringify(data);

				http = new XMLHttpRequest();
				http.onreadystatechange = function() {
					if(http.readyState == 4) {
						if(http.status == 200) {
							var prod = JSON.parse(http.responseText);
							document.getElementById("products").innerHTML = prod.productName;
						}else {
							allErrors = JSON.parse(http.responseText);
							for(var i=0;i<allErrors.errors.length;i++) {
								document.getElementById(allErrors.errors[i].fieldName+"_error").innerHTML = allErrors.errors[i].message;
							}
						}
					}
				};
				http.open(reqMethod, url, true);
				http.setRequestHeader("Content-Type", "application/json");
				http.send(data);				
			}
		</script> -->
	</body>
</html>












