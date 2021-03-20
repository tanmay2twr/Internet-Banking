<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Portal</title>
<style type="text/css">
a {
	text-decoration: none;
	color: white;
}
</style>
</head>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<style>
#borderLine.groove {
	border-style: groove;
}

.pagination {
	display: inline-block;
}

.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
}

.pagination a.active {
	background-color: #4CAF50;
	color: white;
	border: 1px solid #4CAF50;
}

#manager {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#manager td, #customers th {
	border: 1px solid #ddd;
	padding: 8px;
}

#manager tr:nth-child(even) {
	background-color: #f2f2f2;
}

#manager tr:hover {
	background-color: #ddd;
}

#manager th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #4CAF50;
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
	margin-left: 355px;
	margin-right: 355px;
	margin-top: 55px;
	margin-bottom: 55px;
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
<body>
	<form action="Logout">
		<div class="header">

			<a href="ManagerPortal.jsp"> <img src="ImageRes/wipro.png"
				alt="Bank Logo" height="64" /></a>
			<button type="submit" class="btn btn-info btn-lg"
				style="float: right" value="LogOut" name="bankingButton">
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
		<h1>
			<b> Laxmi Chit Fund Bank | Branch Manager Portal</b>
		</h1>
	</center>


	<div class="container-fluid">
		<div class="row">
			<div class="col-sm grid-item" style="background-color:;">
				<a href="ManagerMyData.jsp"> <img src="ImageRes/account.png"
					height=156 />My Data
				</a>
			</div>
			<div class="col-sm grid-item" style="background-color:;">
				<a href="ManagerRequests.jsp"> <img src="ImageRes/addbene.png"
					height=128 />View Requests
				</a>
			</div>
		</div>

	</div>

	
</body>
</html>