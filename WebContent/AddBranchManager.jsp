<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="AdminPortal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login</title>
<script type="text/javascript">
	function myValidation() {

		return true;
	}
</script>
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
	<form action=Logout>
		<input type="button" value="Logout">
	</form>
	<form name="AddBranchManager" action="AdminController" method="post">
		<center>
			<table width="50%">
				<br>
				<br>
				<br>
				<br>
				<br>
				<tr>
					<td>Name</td>
					<td><input type="text" name="name" value="Vinayak" /></td>
				</tr>
				<tr>
					<td>Mobile Number</td>
					<td><input type="text" name="mobile" /></td>
				</tr>
				<tr>
					<td>Gender</td>
					<td><input type="text" name="gender" /></td>
				</tr>
				<tr>
					<td>Email ID</td>
					<td><input type="text" name="emailID" /></td>
				</tr>
				<tr>
					<td>Street Address</td>
					<td><input type="text" name="streetAdd" /></td>
				</tr>
				<tr>
					<td>City</td>
					<td><input type="text" name="city" /></td>
				</tr>
				<tr>
					<td>State</td>
					<td><input type="text" name="state" /></td>
				</tr>
				<tr>
					<td>Aadhaar</td>
					<td><input type="text" name="aadhaar" /></td>
				</tr>
				<tr>
					<td>PAN</td>
					<td><input type="text" name="PAN" /></td>
				</tr>

				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="AddManager" name="bankingButton" /></td>
				</tr>
			</table>
		</center>
	</form>
</body>
</html>