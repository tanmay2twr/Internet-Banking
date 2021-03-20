<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment page</title>
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
</head>

<body>

	 <div class="header">
		<a href="CustomerPortal.jsp"> <img src="ImageRes/wipro.png"
			alt="Bank Logo" height="64" /></a>

		<div style="text-align: right">
			<form action="Logout">
				<button type="submit" class="btn btn-info btn-lg"
					style="float: right" value="LogOut" name="bankingButton">
					<span class="glyphicon glyphicon-log-out"></span> Log out
				</button>
			</form>
		</div>

	</div>
	 <%
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		if (session.getAttribute("userID") == null) {
			response.sendRedirect("LandingPage.jsp");
		}
	%>

	<%
		int result = Integer.parseInt(request.getParameter("result"));
		if (result == 2) {
	%>
	<center>
		<font color=yellow><b>Insufficient Balance</b></font>
	</center>
	<%
		} else if (result == 3) {
	%>
	<center>
		<font color=red><b>Transaction failed, Something went Wrong</b></font>
	</center>
	<%
		} else if (result == 4) {
	%>
	<center>
		<font color=red><b>Incorrect Transaction Password </b></font>
	</center>
	<%
		} else {
	%>
	<center>
		<font color=green><b>Transaction with TransactionID=<%=result%>,
				was Successfull
		</b></font>
	</center>
	<%
		}
	%>
</body>
</html>