<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Fund Transfer</title>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

</head>
<style>
a {
	text-decoration: none;
	color: white;
}
.header {
	overflow: hidden;
	background-color: #f1f1f1;
	padding: 16px 10px;
}

* {
	box-sizing: border-box;
}

body {
	margin: 2px;
}


</style>
<body>
<form action="Logout">
		<div class="header">
			<a href="LandingPage.jsp"> <img src="ImageRes/wipro.png"
				alt="Bank Logo" height="64" /></a>
			<button type="submit" class="btn btn-info btn-lg"
				style="float: right">
				<span class="glyphicon glyphicon-log-out"></span> Log out
			</button>
		</div>
	</form>
<%
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		if (session.getAttribute("userID") == null) {
			response.sendRedirect("LandingPage.jsp");
		}
	%>
	
	<center>
		<div class="container-fluid">
			<b><h1>
					<label style="color: maroon;">Fund Transfer</label>
				</h1></b>
			<div class="container">
				<div id="printAll"></div>
			</div>
		</div>
	<br><br>
	<form action="CustomerController" method="post">
		<div class="form-group">
			<label for="withinBank">Within Bank</label> <br>
			<button type="Self Linked Accounts" class="btn btn-primary"
				value="withinBank" name="bankingButton">Self Linked
				Accounts</button>
		</div>
		<div class="form-group">
			<label for="otherBnak">Other Bank</label> <br>
			<button type="IMPS 24*7" class="btn btn-primary" value="otherBankIMPS"
				name="bankingButton">IMPS 24*7</button>
			<button type="NEFT" class="btn btn-primary" value="otherBankNEFT"
				name="bankingButton">NEFT</button>
		</div>
		</center>
	</form>
</body>
</html>