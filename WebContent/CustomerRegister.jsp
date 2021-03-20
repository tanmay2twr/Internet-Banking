<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="Register.css" type="text/css">
<title>Register for Internet Banking</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="header">
		<a href="ManagerPortal.jsp"> <img src="ImageRes/wipro.png"
			alt="Bank Logo" height="64" /></a> 
		<a href="LandingPage.jsp" class="btn btn-info btn-lg"  style="float:right"> <span class="glyphicon glyphicon-log-out"></span> Log out </a>
	</div>
	<div class="container">
		<h2>Register for Internet Banking</h2>

		<hr>
		<form action="CustomerController" method="post"
			class="needs-validation" novalidate>

			<div class="form-group">
				<label for="account">Account No:</label> <input type="text"
					class="form-control" id="account" placeholder="Account Details"
					name="AccNo" required>
				<div class="valid-feedback">Valid.</div>
				<div class="invalid-feedback">Please fill out Account No.</div>
			</div>

			<div class="form-group">
				<label for="pwd">Debit Card Details:</label> <input type="text"
					class="form-control" id="debit"
					placeholder="Enter Your 16 digit Card No." name="DebitNo" required>
				<div class="valid-feedback">Valid.</div>
				<div class="invalid-feedback">Please fill out Card No. from
					the front of Debit Card</div>
			</div>

			<div class="form-group">
				<label for="pin">Debit Card Pin</label> <input type="password"
					class="form-control" id="pin" placeholder="Enter PIN Code"
					name="PinNo" required>
				<div class="valid-feedback">Valid.</div>
				<div class="invalid-feedback">Enter the 4 digit PIN of Debit
					Card/ATM</div>
			</div>


			<button type="submit" class="btn btn-primary" value="CustomerRegister" name="bankingButton">Register</button>
		
	<script>
		// Disable form submissions if there are invalid fields
		(function() {
			'use strict';
			window.addEventListener('load',
					function() {
						// Get the forms we want to add validation styles to
						var forms = document
								.getElementsByClassName('needs-validation');
						// Loop over them and prevent submission
						var validation = Array.prototype.filter.call(forms,
								function(form) {
									form.addEventListener('submit', function(
											event) {
										if (form.checkValidity() === false) {
											event.preventDefault();
											event.stopPropagation();
										}
										form.classList.add('was-validated');
									}, false);
								});
					}, false);
		})();
	</script>










	<!-- 

	<form action="CustomerController" method="post">
		<label>
			<h4 class="label-txt">Account Number</h4> <input type="text"
			class="input" name="AccNo">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label><br> <label>
			<h4 class="label-txt">Debit Card Number</h4> <input type="text"
			class="input" name="DebitNo">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <br> <label>
			<h4 class="label-txt">Enter PIN</h4> <input type="text" class="input"
			name="PinNo">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <br> <br> -->


	<!-- <button type="submit" value="CustomerRegister" name="bankingButton">submit</button> -->
	<%
		String result = request.getParameter("result");
		String rid = request.getParameter("rid");
		if (result != null && result.equals("repeat")) {
	%>

	<center>
		<font color=red><b>You have already registered for Internet
				Banking </b></font>
	</center>
	<%
		} else if (result != null && result.equals("success")) {
	%>

	<center>
		<font color=green><b>Thanku for registering .Your request
				Id is <%=rid%></b></font>
	</center>
	<%
		} else if (result != null && result.equals("fail")) {
	%>

	<center>
		<font color=red><b>Invalid credentials</b></font>
	</center>
	<%
		}
	%>






	</form>
	</div>

</body>
</html>


