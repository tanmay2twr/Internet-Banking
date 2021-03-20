<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="LandingPage.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script text="text/javascript">
	function myValidation() {

		var name = document.addbeneficiary.name.value;
		var letters = /^[A-Za-z]+$/; ///^[A-Za-z\s]+$/; 
		if (name == null || name == "" || !name.match(letters)) {
			alert("Invalid Name");
			return false;
		}
		var acc = document.addbeneficiary.AccNum.value;
		var acc1 = document.addbeneficiary.ConAccNum.value;
		if (acc != acc1) {
			alert("Account Number does not match");
			return false;
		}
		return true;
	}
</script>
<meta charset="ISO-8859-1">
<title>Add Beneficiary</title>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 2px;
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

.container {
	margin: auto;
	width: 26%;
	position: absolute;
	border: 3px solid #dcedeb;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-right: -50%;
	transform: translate(-50%, -40%);
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

	<%
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		if (session.getAttribute("userID") == null) {
			response.sendRedirect("LandingPage.jsp");
		}
	%>

	<div class="header">
		<a href="CustomerPortal.jsp"> <img src="ImageRes/wipro.png"
			alt="Bank Logo" height="64" /></a>
		<!-- <a href="#"
			class="btn btn-info btn-lg" style="float: right"> <span
			class="glyphicon glyphicon-log-out"></span> Log out
		</a> -->
	</div>
	<!-- <form action="Logout">
		<input type="submit" value="Logout">
	</form> -->
	
	<div class="container">
	<form name="addbeneficiary" action="CustomerController" method="post"
		onsubmit="return myValidation()">

		<div class="form-group" style="width: 300px; postion: absolute;">
			<label for="textbox1">Account Holder Name:</label> <input type="text"
				name="name" class="form-control" id="textbox1"
				placeholder="Full Name">
		</div>

		<div class="form-group" style="width: 300px; postion: absolute;">
			<label for="textbox2">Enter Account Number:</label> <input
				type="text" class="form-control" id="textbox2" name="AccNum"
				placeholder="Account Number">
		</div>
		<div class="form-group" style="width: 300px; postion: absolute;">
			<label for="textbox3">Confirm Account Number:</label> <input
				type="text" class="form-control" id="textbox3" name="ConAccNum"
				placeholder="Account Number">
		</div>

		<div class="form-group" style="width: 300px; postion: absolute;">
			<label for="textbox4">Enter IFSC:</label> <input type="text"
				name="ifsc" class="form-control" id="textbox4" placeholder="IFSC">
		</div>
		<div class="form-group" style="width: 300px; postion: absolute;">
			<label for="dropdwon">Bank</label> <select class="form-control"
				name="bank">
				<option>Axis Bank</option>
				<option>Others</option>
			</select>
		</div>
		<center>
			<button type="submit" class="btn btn-primary" value="AddBenificiary"
				name="bankingButton">Submit</button>
		</center>
	</form>
	</div>
	<%
		if (request.getParameter("result") != null) {
			int result = Integer.parseInt(request.getParameter("result"));
			if (result == 1) {
	%>
	<center>
		<br>
		<br>
		<br> <font color=green><b>Beneficiary Added</b></font>
	</center>
	<%
		} else if (result == -1) {
	%>
	<center>
		<br>
		<br>
		<br> <font color=red><b>Beneficiary Allready Exists</b></font>
	</center>
	<%
		} else if (result == 3) {
	%>
	<center>
		<br>
		<br>
		<br> <font color=red><b>You cannot add your own
				account</b></font>
	</center>
	<%
		} else if (result == 4) {
	%>
	<center>
		<br>
		<br>
		<br> <font color=red><b>You are trying to add an
				account of your own bank</b></font>
	</center>
	<%
		} else {
	%>
	<center>
		<br>
		<br>
		<br> <font color=red><b>Please Enter Correct
				Information</b></font>
	</center>
	<%
		}
		}
	%>
</body>
</html>