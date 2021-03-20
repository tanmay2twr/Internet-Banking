<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="Admin.css">
<meta charset="ISO-8859-1">
<title>Customer Login</title>

<script type="text/javascript">
	function myValidation() {
		//Password Validation
		var password = document.CustomerLogins.pass.value;
		if (password == null || password == "") {
			alert("Invalid password");
			return false;
		}
		//UserNameValidation
		var name = document.CustomerLogins.userID.value;
		//var letters = /^[A-Za-z]+$/;   ///^[A-Za-z\s]+$/; 
		if (name == null || name == "") {//|| !name.match(letters)){
			alert("Invalid UserName");
			return false;
		}

	}
</script>


</head>
<body class="banner-sec">

	<section class="login-block">
		<div class="container">
			<div class="row">

				<button type="submit" class="status-button" value="AdminLogins"
					name="AdminLogins">
					<b>Admin Login</b>
				</button>
				<div class="col-md-4 login-sec">
					<h4 class="text-center">Customer Login</h4>
					<br> <br>

					<form class="login-form" name="CustomerLogins"
						action="CustomerController" method="post"
						onsubmit="return myValidation()">
						<div class="form-group">
							<label for="exampleInputEmail1" class="text-uppercase">Username</label>
							<input type="text" name="userID" class="form-control"
								placeholder="">

						</div>
						<div class="form-group">
							<label for="exampleInputPassword1" class="text-uppercase">Password</label>
							<input type="password" name="pass" class="form-control">
						</div>


						<div class="form-check">

							<br>
							<button type="submit" class="btn btn-login text-center"
								value="CustomerLogin" name="bankingButton">
								<b>Login</b>
							</button>
							<!-- <button type="submit" class="status-button"
								value="CustomerRegister" name="bankingButton">
								<b>Register</b>
							</button> -->

						</div>

					</form>

				</div>
				<div class="col-md-8 banner-sec">
					<img class="d-block img-fluid" src="ImageRes/manager.jpg"
						alt="Image of Customer">
				</div>
			</div>

		</div>
	</section>

</body>
</html>