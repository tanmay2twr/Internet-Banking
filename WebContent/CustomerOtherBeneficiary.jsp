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
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	function extractAllData() {
		var obj = {
			"bankingButton" : "selectBenificiary"
		}
		$
				.ajax({
					url : 'CustomerController',
					method : 'POST',
					data : obj,
					success : function(data, textStatus, jqXHR) {
						console.log(data);
						var table_body = '<table border="1" class="table table-bordered">';
						table_body += '<thead><tr><th>Name</th><th>Account Number</th><th>IFSC Code</th><th>Select</th></tr></thead>';

						$
								.each(
										data,
										function(jsonIndex, jsonData) {
											table_body += '<tr>';
											
											console.log(tempData)
											var tempData = []
											tempData[0] = jsonData.User_ID;
											tempData[1] = jsonData.Beneficiary_Account;
											tempData[2] = jsonData.Beneficiary_name;
											tempData[3] = jsonData.IFSC_Code
											var yui = "'" + tempData.toString()
													+ "'";
											table_body += '<td>'
													+ jsonData.Beneficiary_name
													+ '<td>'
													+ jsonData.Beneficiary_Account
													+ '<td>'
													+ jsonData.IFSC_Code
													+ '<td>'
													+ '<button class="botaoadd" onclick="redirectPage('
													+ yui
													+ ')">Choose </button>';
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
	function redirectPage(data) {
		console.log(data.split(','))
		var dataArray = data.split(',');
		window.location.assign('http://localhost:8080/Wipro_Internet_Banking/TransferOther.jsp?id=' + dataArray[0] + '&ifsc=' + dataArray[3] + '&acct=' + dataArray[1] + '&benfitName=' + dataArray[2]);
	}
</script>
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

	<center>
		<div class="container-fluid">
			<b><h1>
					<label style="color: maroon;">Your beneficiaries</label>
				</h1></b>
			<div class="container">
				<div id="printAll"></div>
			</div>
		</div>
	</center>
</body>
</html>