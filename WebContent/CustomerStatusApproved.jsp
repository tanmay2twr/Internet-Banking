<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Status</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
	<form action="CustomerController" method="post">
		
			<%
            String result = request.getParameter("result");
            int id = 0;
            if (result != null) {
                 id = Integer.parseInt(result);   
            }
        %>
        <div class="container-fluid">
            <b><h1>
                    <label style="color: maroon;">Customer Status Verification</label>
                </h1></b> <br> <br> <br> <br>
            <div class="row">
                <div class="col-sm-2">
                    <label>Registration id</label>
                </div>
                <div class="col-sm-3">
                    <input class="form-control" type="text" name="rid" value=<%=id%> disabled/>
                </div>
            </div>
				<br>
				<div class="row">
					<div class="col-sm-2">
						<label>Account Number</label>
					</div>
					<div class="col-sm-3">
						<input class="form-control" type="text" name="accountnumber"
							placeholder="Enter Account Number" />
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-sm-2">
						<label>PIN</label>
					</div>
					<div class="col-sm-3">
						<input class="form-control" type="text" name="pin"
							placeholder="Enter PIN" />
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-sm-2">
						<label>Username</label>
					</div>
					<div class="col-sm-3">
						<input class="form-control" type="text" name="uname"
							placeholder="Enter Customized Username" />
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-sm-2">
						<label>Password</label>
					</div>
					<div class="col-sm-3">
						<input class="form-control" type="text" name="password"
							placeholder="Enter Password" />
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-sm-2">
						<label>Confirm Password</label>
					</div>
					<div class="col-sm-3">
						<input class="form-control" type="text" name="cpassword"
							placeholder="Enter Password Again" />
					</div>
				</div>
				<br>
				<br>
				<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-2">
						<button type="submit" align="center" class="btn btn-success"
							 value="CustomerStatusApproved" name="bankingButton" >Submit</button>
					</div>
				</div>
			</div>
			</form>
	
</body>
</html>