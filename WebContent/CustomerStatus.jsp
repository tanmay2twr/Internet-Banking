<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
div.alert1 {
	width: 500px;
	margin: auto;
	border: 3px;
}
</style>
<meta charset="ISO-8859-1">
<title>Customer Status</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
	<div class="header">
		<a href="LandingPage.jsp"> <img src="ImageRes/wipro.png"
			alt="Bank Logo" height="64" />
		</a>
	</div>
	<br />
	<form action="CustomerController" method="post">

		<div class="container-fluid">
			<b><h1>
					<label style="color: #1e90ff;">Customer Status</label>
				</h1></b>
			<hr />
			<div class="row">
				<div class="col-sm-2">
					<label>Registration id</label>
				</div>
				<div class="col-sm-3">
					<input class="form-control" type="text" name="rid"
						placeholder="Enter Registration ID" />
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-2">
					<button type="submit" align="center" class="btn btn-success"
						value="CustomerStatus" name="bankingButton">Submit</button>
				</div>
			</div>
		</div>
	</form>
	<%
		String result = request.getParameter("result");
		if (result != null && result.equals("pending")) {
	%>

	<div class="alert alert-warning alert-dismissable alert1"
		" role="alert" align="center">
		<button type="button" class="close" data-dismiss="alert"
			aria-hidden="true">&times;</button>
		Status is pending. Please wait!
	</div>

	<%
		} else if (result != null && result.equals("rejected")) {
	%>

	<div class="alert alert-danger alert-dismissable alert1" role="alert"
		align="center">
		<button type="button" class="close" data-dismiss="alert"
			aria-hidden="true">&times;</button>
		Request Rejected Kindly Contact Branch Manager
	</div>

	<%
		} else if (result != null && result.equals("approvedenabled")) {
	%>
	
	<div class="alert alert-success alert-dismissable alert1" role="alert"
		align="center">
		<button type="button" class="close" data-dismiss="alert"
			aria-hidden="true">&times;</button>
		Request Approved and Customized Username
				and Password is already Set. Go to this Page to <a href="LandingPage.jsp" class="alert-link">login</a>
	</div>
	
	
	<%
		} else if (result != null && result.equals("approvedfreeze")) {
	%>
	
	
	<div class="alert alert-dark alert-dismissable alert1" role="alert"
		align="center">
		<button type="button" class="close" data-dismiss="alert"
			aria-hidden="true">&times;</button>
		Request Approved and Account is freezed
	</div>
	

	<%
		} else if(result!= null && result.equals("notfound")){
	%>
	
	<div class="alert alert-info alert-dismissable alert1" role="alert"
		align="center">
		<button type="button" class="close" data-dismiss="alert"
			aria-hidden="true">&times;</button>
		Request not Found, will contact @NASA to find your Request on MARS.
	</div>
	
	<%
		}
	%>
</body>
</html>