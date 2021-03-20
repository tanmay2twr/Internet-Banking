<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
<form name="deleteManager"  action="AdminController" method="post" ">
<center><table width="50%">
<tr><td>Branch Manager ID</td><td><input type="text" name="userID"/></td></tr>

<tr><td colspan="2" align="center"><input type="submit" value="ManagerDelete" name="bankingButton"/> </td></tr>
</table></center>
</form>
</body>
</html>