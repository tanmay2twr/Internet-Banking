<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="Admin.css">
<meta charset="ISO-8859-1">
<title>Admin Login</title>

<script type="text/javascript">
	function myValidation() {
		//Password Validation
		var password = document.AdminLogins.pass.value;
		if (password == null || password == "") {
			alert("Invalid password");
			return false;
		}
		//UserNameValidation
		var name = document.AdminLogins.userID.value;
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
				<div class="col-md-4 login-sec">
					<h4 class="text-center">Admin Login</h4>
					<br> <br>

					<form class="login-form" name="AdminLogins"
						action="AdminController" method="post"
						onsubmit="return myValidation()">
						<div class="form-group">
							<label for="exampleInputEmail1">Admin ID</label> <input
								type="text" name="userID" class="form-control"
								placeholder="Enter SuperUser Mode">

						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Password</label> <input
								type="password" name="pass" class="form-control"
								placeholder="Password">
						</div>


						<div class="form-check">
							<button type="submit" class="btn btn-login text-center"
								value="AdminLogin" name="bankingButton">
								<b>sudo su </b>
							</button>
						</div>
					</form>
				</div>
				<div class="col-md-8 banner-sec">
					<img class="d-block img-fluid " src="ImageRes/admin.jpg"
						alt="First slide">

				</div>
			</div>

		</div>

	</section>

</body>
</html>