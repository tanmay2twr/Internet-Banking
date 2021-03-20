<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to Laxmi Chit Fund Bank</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
a {
	text-decoration: none;
	color: white;
}
</style>

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

<style>
.grid-container {
	display: grid;
	grid-template-columns: auto auto auto;
	background-color: #ccf2ff;
	padding-left: 20px;
	padding-right: 20px;
	padding-top: 2px;
	padding-bottom: 2px;
}

.grid-item {
	border: 1px solid rgba(0, 0, 0, 0.8);
	padding: 10px;
	margin: 15px;
	font-size: 32px;
	text-align: center;
}

a:link, a:visited, a:hover {
	text-decoration: none;
	color: #000;
}

.header-right {
	float: right;
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




	<form action="Logout">
		<div class="header">

			<a href="CustomerPortal.jsp"> <img src="ImageRes/wipro.png"
				alt="Bank Logo" height="64" /></a>
			<button type="submit" class="btn btn-info btn-lg"
				style="float: right" value="LogOut" name="bankingButton">
				<span class="glyphicon glyphicon-log-out"></span> Log out
			</button>
		</div>

		<div class="container-fluid">
			<div class="row">
				<div class="col-sm grid-item" style="background-color:;">
					<a href="CustomerMyData.jsp"> <img src="ImageRes/account.png"
						height=156 /> My Account Details
					</a>
				</div>
				<div class="col-sm grid-item" style="background-color:;">
					<a href="CustomerAddBeneficiary.jsp"> <img
						src="ImageRes/addbene.png" height=128 />Add Beneficiary
					</a>
				</div>
			</div>

			<div class="row">
				<div class="col-sm grid-item" style="background-color:;">
					<a href="CustTransactionPortal.jsp"> <img
						src="ImageRes/ruppee.png" height=156 />Transfer Funds
					</a>
				</div>
				<div class="col-sm grid-item" style="background-color:;">
					<a href="CustomerStatement.jsp"><img
						src="ImageRes/statement.png" height=128 />Account Statement </a>
				</div>

			</div>
		</div>

	</form>
</body>
</html>