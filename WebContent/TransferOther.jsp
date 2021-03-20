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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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


	<div class="header">
		<div style="text-align: right">
			<form action="Logout">


				<div class="header">

					<a href="CustomerPortal.jsp"> <img src="ImageRes/wipro.png"
						alt="Bank Logo" height="64" /></a>
					<button type="submit" class="btn btn-info btn-lg"
						style="float: right" value="LogOut" name="bankingButton">
						<span class="glyphicon glyphicon-log-out"></span> Log out
					</button>
				</div>


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

	<div class="container">
		<%
			String user_ID = request.getParameter("id");
			if (user_ID == null) {
		%>
		<div style="text-align: center">
			<form action="CustomerController" method="post">
				<div class="form-group">
					<label for="accNum"><b><i>Account Number</i></b></label> <br>
					<%=request.getParameter("accountNum")%>
				</div>
				<div class="form-group">
					<label for="balance"><b><i>Balance</i></b></label> <br>
					<%=request.getParameter("balance")%>
				</div>
				<div class="form-group">
					<button type="" class="btn btn-primary" value="selectBenificiary1"
						name="bankingButton">Select Beneficiary</button>
				</div>
			</form>
		</div>
		<%
			} else {
		%>
		<div style="text-align: center">
			<form action="CustomerController" method="post">
				<div class="form-group">
					<label for="name"><b><i>Account Holder Name</i></b></label> <br>
					<%=request.getParameter("benfitName")%>
				</div>
				<div class="form-group">
					<label for="accNum"><b><i>Account Number</i></b></label> <br>
					<%
						String str = request.getParameter("acct");
					%>
					<input type="hidden" value=<%=str%> name="accNum">
					<%=request.getParameter("acct")%>
				</div>
				<div class="form-group">
					<label for="ifsc"><b><i>IFSC Code</i></b></label> <br>
					<%=request.getParameter("ifsc")%>
				</div>
				<div class="form-group">
					<label for="amount"><b><i>Amount</i></b></label> <br> <input
						type="text" class="form-control" id="amount" name="amount"
						placeholder="Amount in Rupees">
				</div>
				<div class="form-group">
					<label for="amount"><b><i>Transaction Password</i></b></label> <br>
					<input type="password" class="form-control" id="tpassword"
						name="tpassword" placeholder="Customer Transaction Password">
				</div>
				<div class="form-group">
					<button type="Submit" class="btn btn-primary"
						value="checkDebitother" name="bankingButton">Submit</button>
				</div>
			</form>
		</div>

		<%
			}
		%>

	</div>
</body>
</html>


