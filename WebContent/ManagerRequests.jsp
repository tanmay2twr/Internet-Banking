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
<title>Manager</title>
<script type="text/javascript">
	var tableFooter = '</tbody></table>';
	var importDAta = '<th>APPROVED</th><th>REJECT</th>';
	var status = 0;
	var requestData = 0
	function buttonCreation() {

		$('button').click(function() {
			var buttName = (this).getAttribute('name');
			requestData = parseInt((this).getAttribute('id'));
			$('#dropData').css({
				"height" : "50px"
			})
			if (buttName == 'approved') {
				console.log(buttName + (this).getAttribute('id'))
				$('.modal-title').text('PENDING STATUS');
				$('#mgApprove').show();
				$('#mgReject').hide();
				status = 1;
				$("#myConfirmationModel").modal('show');
			} else if (buttName == 'rejected') {
				$('.modal-title').text('REJECTED STATUS');
				$("#myConfirmationModel").modal('show');
				$('#mgApprove').hide();
				$('#mgReject').show();
				status = 0;
				console.log(buttName + (this).getAttribute('id').toString())
			}
		});
	}
	function createTable(column) {
		var tableHead = '<table id="manager" class="table table-bordered" style="text-align:left;background-color:white">'
				+ '<thead>'
				+ '<tr>'
				+ '<th>USERID</th>'
				+ '<th>REQUEST ID</th>'
				+ '<th>REQUEST DATE</th>'
				+ '<th>DATE OPENED</th>'
				+ '<th>BALANCE</th>'
				+ '<th>ACCOUNTNUM</th>' + column + '</tr>' + '</thead><tbody">';
		return tableHead;
	}
	function extractAllData(status) {
		var obj = {
			"bankingButton" : "ManagerRequests",
			"status" : status
		}
		var tempTableData = '';
		$
				.ajax({
					url : 'ManagerController',
					method : 'POST',
					data : obj,
					success : function(data, textStatus, jqXHR) {
						if (data.length == 0) {
							tempTableData += '<tr><td align="center" colspan="8"><b><h4>No Data Found</h4></b></td></tr>';
						}
						$
								.each(
										data,
										function(tempData, valuedata) {
											tempTableData += '<tr>';
											tempTableData += '<td>'
													+ valuedata.USERID
													+ '</td>';
											tempTableData += '<td>'
													+ valuedata.REQUESTID
													+ '</td>';
											tempTableData += '<td>'
													+ valuedata.REQUESTDATE
													+ '</td>';
											tempTableData += '<td>'
													+ valuedata.DATEOPENED
													+ '</td>';
											tempTableData += '<td>'
													+ valuedata.BALANCE
													+ '</td>';
											tempTableData += '<td>'
													+ valuedata.ACCOUNTNUM
													+ '</td>';
											if (status == 'pending') {
												tempTableData += '<td><button type="button" id="' + valuedata.REQUESTID + '" name="approved" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-ok">Approve</span></button></td>';
												tempTableData += '<td><button type="button" id="' + valuedata.REQUESTID + '" name="rejected" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span>Reject</button></td>';
											}
											tempTableData += '</tr>';
										});
						var tableData = '';
						if (status == 'pending') {
							tableData = createTable(importDAta) + tempTableData
									+ tableFooter;
						} else {
							tableData = createTable('') + tempTableData
									+ tableFooter;
						}
						$('#tableCreation').html(tableData);
						buttonCreation()
					},
					error : function(jqXHR, exception) {

					},
					complete : function(jqXHR, textStatus) {

					}
				});
	}
	function onloadScale() {
		$('#accordSelect').css({
			"background-color" : "#fdde81",
			"height" : "482px"
		});
		extractAllData('pending');
	}
	function updateData(reqData, status) {
		var obj = {
			"bankingButton" : "UpdateRequests",
			"status" : status,
			"reqData" : reqData
		}
		$.ajax({
			url : 'ManagerController',
			method : 'POST',
			data : obj,
			success : function(data, textStatus, jqXHR) {
				if (parseInt(data) == 1 && status == 1) {
					alert(' Customer Request is approved Successfull ');
				} else if (parseInt(data) == 1 && status == 0)
					alert(' Customer Request is reject Successfull ');
			},
			error : function(jqXHR, exception) {
			},
			complete : function(jqXHR, textStatus) {
			}
		});
	}
	$(document).ready(function() {
		$('[name="pending"]').mouseover(function() {
			$(this).css({
				'cursor' : 'pointer',
			});
		});
		$('[name="pending"]').mouseout(function() {
			$(this).css({
				'color' : 'black',
			});
		});
		$('[name="rejected"]').mouseover(function() {
			$(this).css({
				'cursor' : 'pointer',
			});
		});
		$('[name="rejected"]').mouseout(function() {
			$(this).css({
				'color' : 'black',

			});
		});
		$('[name="activated"]').mouseover(function() {
			$(this).css({
				'cursor' : 'pointer',

			});
		});
		$('[name="activated"]').mouseout(function() {
			$(this).css({
				'color' : 'black',

			});
		});
		$('[name="pending"]').click(function() {
			onloadScale();
		});
		$('[name="activated"]').click(function() {
			extractAllData('approved');
			$('#accordSelect').css({
				"background-color" : "#9de1af"
			});
		});
		$('[name="rejected"]').click(function() {
			extractAllData('rejected');
			$('#accordSelect').css({
				"background-color" : "#f5aaa3"
			});
		});
		$('#yesappid').click(function() {
			updateData(requestData, status);
			$("#myConfirmationModel").modal('hide');
			extractAllData('pending');
		})
		$('#noappid').click(function() {
			alert('No Modification Done for Approved');
			$("#myConfirmationModel").modal('hide');
		});
		$('#yesreid').click(function() {
			updateData(requestData, status);
			$("#myConfirmationModel").modal('hide');
			extractAllData('pending');
		});
		$('#noreid').click(function() {
			alert('No Modification Done for Reject');
			$("#myConfirmationModel").modal('hide');
		});
		$('#modelCancel').click(function() {
			$("#myConfirmationModel").modal('hide');
		})
	});
</script>
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
	margin: 15px;
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
	background-color: dodgerblue;
	color: white;
}
</style>
</head>

<body onload="onloadScale()">
	<%
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		if (session.getAttribute("userID") == null) {
			response.sendRedirect("LandingPage.jsp");
		}
	%>
	<form action="Logout">
		<div class="header">
			<a href="ManagerPortal.jsp"> <img src="ImageRes/wipro.png"
				alt="Bank Logo" height="64" /></a> 
			<button type="submit" class="btn btn-info btn-lg"
				style="float: right" value="LogOut" name="bankingButton">
				<span class="glyphicon glyphicon-log-out"></span> Log out
			</button>
			<button type="submit" class="btn"
				style="float: right" value="Profile" name="bankingButton">
				<span class="glyphicon glyphicon-user"></span> Profile
			</button>
		</div>
	</form>

	<div class="grid-container">
		<div class="grid-item" style="background-color: #FBBC05">
			<a name="pending">Pending Request </a>
		</div>
		<div class="grid-item" style="background-color: #34A853">
			<a name="activated">Activated Request </a>
		</div>
		<div class="grid-item" style="background-color: #EA4335">
			<a name="rejected">Rejected Request </a>
		</div>
	</div>

	<div id="accordSelect">
		<br> <br>
		<div class="container">
			<div class="row">
				<div id="tableCreation"></div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="modal" id="myConfirmationModel">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header" style="height: 40px;">
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<div id="dropData">
							<div id="mgApprove">
								<label>Are You sure to Approve the Request</label>
								<button id="yesappid" class="btn btn-default">Yes</button>
								<button id="noappid" class="btn btn-default">No</button>
							</div>
							<div id="mgReject">
								<label>Are You sure to Reject the Request</label>
								<button id="yesreid" class="btn btn-default">Yes</button>
								<button id="noreid" class="btn btn-default">No</button>
							</div>
						</div>
					</div>
					<div class="modal-footer" style="height: 65px;">
						<button type="button" class="btn btn-default" id="modelCancel">Close</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>

</html>