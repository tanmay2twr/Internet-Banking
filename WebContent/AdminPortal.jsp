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
		<center>
			<h1>
				<b> Axis Bank Admin Portal</b>
			</h1>
		</center>
		<input type="submit" value="Logout">
		<table width="100%" cellpadding="10" cellspacing="5">
			<tr>
				<th bgcolor="green"><a href="AdminMyData.jsp" target="self">MyData</a></th>
				<th bgcolor="green"><a href="AddBranchManager.jsp"
					target="self">Add Branch Manager</a></th>
				<th bgcolor="green"><a href="Modify_Branch_Manager.jsp"
					target="self">Modify Branch Manager Details</a></th>
				<th bgcolor="green"><a href="Delete_Branch_Manager.jsp"
					target="self">Delete Branch Manager</a></th>
				<th bgcolor="green"><a href="View/Search.jsp" target="self">Search</a></th>


			</tr>
		</table>
	</form>
</body>
</html>