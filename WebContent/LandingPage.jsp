<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="LandingPage.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<title>Laxmi Chit Fund | Login</title>

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

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
}

.header {
	overflow: hidden;
	background-color: #f1f1f1;
	padding: 16px 10px;
}

.header a {
	float: left;
	color: black;
	text-align: center;
	padding: 6px;
	text-decoration: none;
	font-size: 18px;
	line-height: 25px;
	border-radius: 4px;
}

.header a.logo {
	font-size: 25px;
	font-weight: bold;
}

.header a:hover {
	background-color: #ddd;
	color: black;
}

.header a.active {
	background-color: dodgerblue;
	color: white;
}

.header-right {
	float: right;
}

@media screen and (max-width: 500px) {
	.header a {
		float: none;
		display: block;
		text-align: left;
	}
	.header-right {
		float: none;
		vertical-align: middle;
	}
}
</style>

</head>
<body>
	<div class="header">
		<a href="LandingPage.jsp"> <img src="ImageRes/wipro.png"
			alt="Bank Logo" height="64"">
		</a>

		<div class="header-right">
			<a href="AdminLogin.jsp">Admin</a>
		</div>

	</div>

	<!-- <a href="AdminLogin.jsp" class="status-button">Admin Login</a> -->
	<!-- <button type="submit" class="status-button" value="AdminLogins"
		name="AdminLogins">
		<b>Admin Login</b>
	</button> -->
	<div class="container" style="position: absolute;">

		<ul class="nav nav-pills nav-justified">
			<li class="active"><a data-toggle="pill" href="#customer">Customer</a></li>
			<li><a data-toggle="pill" href="#manager">Bank Manager</a></li>
		</ul>

		<div class="tab-content">
			<div id="customer" class="tab-pane fade in active"
				style="width: 300px; postion: absolute;">

				<form class="login-form" name="CustomerLogins"
					action="CustomerController" method="post"
					onsubmit="return myValidation()">
					<div class="form-group">
						<label for="exampleInputEmail1" class="text-uppercase">Login
							ID</label> <input type="text" name="userID" class="form-control"
							placeholder="Enter your Customized ID">

					</div>
					<div class="form-group">
						<label for="exampleInputPassword1" class="text-uppercase">Password</label>
						<input type="password" name="pass" class="form-control"
							placeholder="Enter your Profile Password">
					</div>


					<div class="form-check">

						<button type="submit" class="btn btn-login text-center"
							value="CustomerLogin" name="bankingButton">
							<b>Login</b>
						</button>
					</div>
				</form>

				<a href="CustomerRegister.jsp">First time user? Register</a>
				 <span>|</span>
				<a href="CustomerStatus.jsp">Check Login ID</a>


			</div>
			<div id="manager" class="tab-pane fade"
				style="width: 300px; postion: absolute;">

				<form class="login-form" name="ManagerLogin"
					action="ManagerController" method="post"
					onsubmit="return myValidation()">
					<div class="form-group">
						<label for="exampleInputEmail1" class="text-uppercase">User
							ID</label> <input type="text" name="userID" class="form-control"
							placeholder="Enter your Manager User ID">

					</div>
					<div class="form-group">
						<label for="exampleInputPassword1" class="text-uppercase">Password</label>
						<input type="password" name="pass" class="form-control"
							placeholder="Enter your Password">
					</div>

					<div class="form-check">
						<button type="submit" class="btn btn-login text-center"
							value="ManagerLogin" name="bankingButton">
							<b>Login</b>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>