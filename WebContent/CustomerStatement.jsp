<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Bank Statement</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	function extractAllData() {
		var obj = {
			"bankingButton" : "Statement"
		}
		$
				.ajax({
					url : 'CustomerController',
					method : 'POST',
					data : obj,
					success : function(data, textStatus, jqXHR) {
						console.log(data);
						var table_body = '<table border="1" class="table table-bordered">';
						table_body += '<thead><tr><th>Transaction ID</th><th>Transaction Mode</th><th>Date</th><th>Credit</th><th>Debit</th></tr></thead>';
						console.log(data.length);
						$.each(data, function(jsonIndex, jsonData) {
							if(jsonData.credit =='0')
								jsonData.credit = " ";
							if(jsonData.debit =='0')
								jsonData.debit = " ";
							
							table_body += '<tr>';

							table_body += '<td>' + jsonData.transactionID
									+ '<td>' + jsonData.transactionMode
									+ '<td>' + jsonData.chronicle.split(' ')[0]
									+ '<td>' + jsonData.credit + '<td>'
									+ jsonData.debit;
							table_body += '</tr>';
							console.log(jsonData);
						});
						table_body += '</table>';
						$('#printAll').html(table_body);
					},
					error : function(jqXHR, exception) {
						console.log("not entered");
					},
					complete : function(jqXHR, textStatus) {
						console.log('Complete');
					}
				});
	}
</script>
<style>
.button {
	margin: 20px;
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
</head>
<body onload="extractAllData()">
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



	<center>
		<div class="container-fluid">
			<b><h1>
					<label style="color: blue;">Statement</label>
				</h1></b>
			<div class="container">
				<div id="printAll"></div>
			</div>
		</div>
	</center>

	<form>
		<input class="button" input type="button" value="Print my Statement"
			onClick="window.print()" margin="24px">
	</form>
</body>
</html>