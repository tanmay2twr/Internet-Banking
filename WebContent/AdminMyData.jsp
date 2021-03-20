<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manager Services</title>
<style type="text/css">
a {
	text-decoration: none;
	color: white;
}
</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script type="text/javascript">
	var mobile = 1;
	var mail = 1;
	var p = null;
	var b = null;
	var s = null;
	function extractDetails() {
		$('[name="loaderData"]').show();
		$('[name="editDesign"]').hide();
		var obj = {
			"bankingButton" : "AdminDetail"
		}
		$.ajax({
			url : 'AdminController',
			method : 'POST',
			data : obj,
			success : function(data, textStatus, jqXHR) {
				setTimeout(function() {
					$('[name="loaderData"]').hide();
					$('[name="persDetail"]').hide();
					$('[name="editDesign"]').show();
					displayComponent(data);
					if (data.streetAdd != null && data.city != null
							&& data.aadhaar != null)
						$('[name="persDetail"]').show();
					console.log(data);
					controlComponent(true);
					$('[name="uid"]').val(data.userID);
					$('[name="name"]').val(data.Name);
					$('[name="mobileno"]').val(data.mobile_No);
					if (data.gender == 'male')
						$('[name="gender"]').prop('selectedIndex', 0);
					else if (data.gender == 'female')
						$('[name="gender"]').prop('selectedIndex', 1);
					if (data.gender == 'trans')
						$('[name="gender"]').prop('selectedIndex', 2);
					$('[name="mailid"]').val(data.mailID);
				}, 800);
			},
			error : function(jqXHR, exception) {
				console.log("not entered");
			},
			complete : function(jqXHR, textStatus) {
				console.log('Complete');
			}
		});
	}
	function updateData() {
		var obj = {
			"bankingButton" : "UpdateAdminDetail",
			"USER_ID" : $('[name="uid"]').val(),
			"MOBILE_NO" : $('[name="mobileno"]').val(),
			"MAIL_ID" : $('[name="mailid"]').val(),
			"STREET_ADD" : $('[name="streetAddid"]').val(),
			"CITY" : $('[name="cityid"]').val(),
			"STATE" : $('[name="stateid"]').val()
		}
		$.ajax({
			url : 'AdminController',
			method : 'POST',
			data : obj,
			success : function(data, textStatus, jqXHR) {
				var result = parseInt(data);
				popConfirmationm(result);
				$('[name="Edit"]').show();
				extractDetails();
			},
			error : function(jqXHR, exception) {
				console.log("not entered");
			},
			complete : function(jqXHR, textStatus) {
				console.log('Complete');
			}
		});
	}
	function controlComponent(boolvalue) {
		if (boolvalue === true)
			$('[name="updateButton"]').hide();
		else
			$('[name="updateButton"]').show();
		$('[name="uid"]').attr('disabled', true);
		$('[name="name"]').attr('disabled', true);
		$('[name="mobileno"]').attr('disabled', boolvalue);
		$('[name="gender"]').attr("disabled", true);
		$('[name="mailid"]').attr('disabled', boolvalue);
		$('[name="streetAddid"]').attr('disabled', boolvalue);
		$('[name="cityid"]').attr('disabled', boolvalue);
		$('[name="aadhaarnoid"]').attr('readonly', true);
		$('[name="stateid"]').attr('disabled', boolvalue);
		$('[name="panid"]').attr('disabled', true);
	}
	function displayComponent(dataVal) {
		$('[name="streetAddid"]').val(dataVal.streetAdd);
		$('[name="cityid"]').val(dataVal.city);
		$('[name="aadhaarnoid"]').val(dataVal.aadhaar);
		$('[name="stateid"]').val(dataVal.state);
		$('[name="panid"]').val(dataVal.PAN);
	}
	function mobmailConVal(event, contName) {
		if (contName === 'mobile'
				&& !(event.target.value.match(/^[0-9]+$/) && event.target.value.length == 10)) {
			$('[name="warnMobile"]').empty();
			$('[name="warnMobile"]').css("color", "red");
			$('[name="warnMobile"]').append(
					"You have entered a invalidate Mobile No");
			mobile = 0;
		} else if (contName === 'mailid'
				&& !event.target.value
						.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)) {
			$('[name="warnMail"]').empty();
			$('[name="warnMail"]').css("color", "red");
			$('[name="warnMail"]').append(
					"You have entered a invalidate Mail ID");
			mail = 0;
		}
		if (contName === 'mobile'
				&& (event.target.value.match(/^[0-9]+$/) && event.target.value.length == 10)) {
			$('[name="warnMobile"]').empty();
			$('[name="warnMobile"]').css("color", "green");
			$('[name="warnMobile"]').append(
					"You have entered a validate Mobile No");
			mobile = 1;

		} else if (contName === 'mailid'
				&& event.target.value
						.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)) {
			$('[name="warnMail"]').empty();
			$('[name="warnMail"]').css("color", "green");
			$('[name="warnMail"]')
					.append("You have entered a validate Mail ID");
			mail = 1;
		}
		if (mobile == 1 && mail == 1)
			$('[name="updateButton"]').attr("disabled", false);
		else
			$('[name="updateButton"]').attr("disabled", true);
	}
	function editTextbox() {
		$('[name="persDetail"]').show();
		controlComponent(false);
		$('[name="Edit"]').hide();
		//
	}
	function popConfirmationm(status) {
		$('#popConfirmation').modal('show');
		$('.modal-title').text('Update Status');
		if (status == 1) {
			$('.modal-body').text('Updated Successfully');
			$('[name="editDesign"]').hide();

		} else
			$('.modal-body').text(
					'Please Check your values or any connection issue');

	}
	function modelClose() {
		$('#popConfirmation').modal('hide');
	}
</script>
<style>
img {
	position: absolute;
	top: 50%;
	left: 50%;
	margin-left: -(X/2) px;
	margin-top: -(Y/2) px;
}
</style>
</head>
<body onload="extractDetails()">
	<div name="loaderData">
		<img src="gif/snakeloader.gif" width="100px" height="100px">
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-8">
				<div name="editDesign">
					<br>
					<form>
						<b><h2 style="color: black; position: absolute; left: 210px">ADMIN
								DETAILS</h2></b><br> <br> <br> <br> <br> <br>
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-3">
									<label>User ID:</label>
								</div>
								<div class="col-sm-5">
									<input class="form-control" type="text" name="uid" />
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-sm-3">
									<label>Name:</label>
								</div>
								<div class="col-sm-5">
									<input class="form-control" type="text" name="name" />
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-sm-3">
									<label>Mobile No:</label>
								</div>
								<div class="col-sm-5">
									<input class="form-control" type="text" name="mobileno"
										onkeyup="mobmailConVal(event,'mobile')" required />
								</div>
								<div class="col-sm-4">
									<label name="warnMobile"></label>
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-sm-3">
									<label>Gender:</label>
								</div>
								<div class="col-sm-5">
									<select name="gender" class="form-control">
										<option value="MAlE">MALE</option>
										<option value="FEMALE">FEMALE</option>
										<option value="TRANS">TRANS</option>
									</select>
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-sm-3">
									<label>Mail ID:</label>
								</div>
								<div class="col-sm-5">
									<input type="text" class="form-control" name="mailid"
										onkeyup="mobmailConVal(event,'mailid')" required />
								</div>
								<div class="col-sm-4">
									<label name="warnMail"></label>
								</div>
							</div>
							<br>
							<div name="persDetail">
								<div class="row">
									<div class="col-sm-3">
										<label name="streetAddl">Street Address:</label>
									</div>
									<div class="col-sm-5">
										<input class="form-control" type="text" name="streetAddid"
											required />
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-sm-3">
										<label name="statel">State:</label>
									</div>
									<div class="col-sm-5">
										<input class="form-control" type="text" name="stateid"
											required />
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-sm-3">
										<label name="cityl">City:</label>
									</div>
									<div class="col-sm-5">
										<input class="form-control" type="text" name="cityid" required />
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-sm-3">
										<label name="aadhaarnol">Aadhar No:</label>
									</div>
									<div class="col-sm-5">
										<input class="form-control" type="text" name="aadhaarnoid" />
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-sm-3">
										<label name="panl">PAN:</label>
									</div>
									<div class="col-sm-5">
										<input class="form-control" type="text" name="panid" />
									</div>
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-sm-5">
									<button type="button" class="btn btn-primary"
										name="updateButton" onclick="updateData()">Update</button>
								</div>
								<div class="col-sm-1"></div>
								<div class="col-sm-4">
									<button type="button" class="btn btn-success" name="Edit"
										onclick="editTextbox()">Update Details</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<!-- The Modal -->
		<div class="modal" id="popConfirmation">
			<div class="modal-dialog">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title"></h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body"></div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
							onclick="modelClose()" id="modelButton">Close</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>