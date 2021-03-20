<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Admin | Super User</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.css"> -->
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.js"></script> -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>


<script type="text/javascript">
    var managerData = '';
    var iddata = '';
    var dropData = null;
    var obj = {
        "bankingButton": "GetManagerDetail"
    };
    var idVal = 0;
    var tempTableData = '';
    var tablesData = null;
    var tableHead = '<table id="manager" class="table table-bordered" style="text-align:left">'
        + '<thead>'
        + '<tr>'
        + '<th>Manager ID</th>'
        + '<th>Manager Name</th>'
        + '<th>Branch Name</th>'
        + '<th>Branch Location</th>'
        + '<th>Branch Code</th>'
        + '</tr>'
        + '</thead>' + '<tbody">';
    var tableFooter = '</tbody>' + '</table>';
    var delButton = '<button type="button" id="delBut" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove-sign"></span> Remove</button>';
    var upButton = ' <button type="button" id="upBut" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-edit"></span> Edit</button>';
    var userData = '{"mid":"","mname":"","bname":"","blocation":"","bcode":""}'
    var branchDataInfo = '';
    var mapBranchJSONData = {};
    var unquerowData = '';
    var updateStatusCntrl = 0;
    var deleteStatusCntrl = 0;
    var branchValue = '';
    function confmethod() {
        $('#yesdelid').click(function () {
            if (deleteStatusCntrl != 1) {
                $('#mpumsg').hide();
                ajaxUpdateDelete(JSON.parse(userData).mid, 0);
                deleteStatusCntrl = 1;
            }
        })
        $('#nodelid').click(function () {
            $('#myModal').modal('hide');
        });
        $('#yesupid').click(function () {
            if (updateStatusCntrl != 1) {
                var jsonData = {
                    "ifscCode": $('[name="ifsc"]').val(),
                    "userId": JSON.parse(userData).mid
                }
                console.log('Method Call');
                ajaxUpdateDelete(JSON.stringify(jsonData), 1);
                console.log('Method After Call');
                updateStatusCntrl = 1;
            }
        });
        $('#noupid').click(function () {
            $('#myModal').modal('hide');
        });
    }
    function ajaxUpdateDelete(updateDeleteVal, udstatus) {
        var paramData = {
            "bankingButton": "GetConfirmDeleteUpdate",
            "updateDeleteVal": updateDeleteVal,
            "udstatus": udstatus
        }
        $.ajax({
            url: 'AdminController',
            method: 'POST',
            data: paramData,
            success: function (confirmData, textStatus, jqXHR) {
                var statData = parseInt(confirmData);
                if (udstatus == 1) {
                    if (statData == 3) {
                        var jsonDataMap = mapBranchJSONData[$('[name="ifsc"]').val()];
                        unquerowData.children[4].outerHTML = '<td>' + jsonDataMap.IFSCCODE + '</td>';
                        unquerowData.children[3].outerHTML = '<td>' + jsonDataMap.CITY + '</td>';
                        unquerowData.children[2].outerHTML = '<td>' + jsonDataMap.BRANCHNAME + '<br><div id="butgrp' + JSON.parse(userData).mid + '">' + upButton + ' ' + delButton + '</div></td>';
                        $("td div").hide();
                        var branchDatas = updatePanel(branchValue);
                        createTableTr();
                        buttonControl(branchDatas);
                        alert(JSON.parse(userData).mname + ' Updated Successfully');
                        $('#myModal').modal('hide');
                        return;
                    } else {
                        alert('Unsuccessful, as the manager already exist of that branch');
                        $('#myModal').modal('hide');
                        return;
                    }
                } else if (udstatus == 0) {
                    if (statData == 3) {
                        unquerowData.remove();
                        alert(JSON.parse(userData).mname + ' Deleted Successfully');
                        $('#myModal').modal('hide');
                        return;
                    } else {
                        alert('Deleted Unsuccessfull');
                        $('#myModal').modal('hide');
                        return;
                    }
                }
            },
            error: function (jqXHR, exception) {
                console.log("not entered");
            },
            complete: function (jqXHR, textStatus) {
                console.log('Complete');
            }
        });
    }
    function selectInfo(paramData) {
        var delInfo = '<div class="container">' + '<div class="row">'
            + '<div class="col-lg-2">Manager Id</div>'
            + '<div class="col-lg-3"><b>' + paramData.mid + '</b></div>'
            + '</div><br>' + '<div class="row">'
            + '<div class="col-lg-2">Manager Name</div>'
            + '<div class="col-lg-3"><b>' + paramData.mname + '</b></div>'
            + '</div>'
        '</div><br>';
        return delInfo;
    }
    function updatePanel(dropData) {
        var textbox = '<br><input type="text" name="ifsc" style="width: 250px; height:38px; position: absolute; left: 100px;"><br><br>'
        var optiondataheader = '<ul id="dropValue" class="list-group" style="width: 250px; position: absolute; left: 100px;">';
        var optiondatafooter = '</ul>';
        var designDropdown = textbox + optiondataheader;
        $.each(dropData, function (index, data) {
            designDropdown += '<li class="list-group-item">' + data.IFSCCODE + '</li>';
        });
        designDropdown += optiondataheader;
        return designDropdown;
    }
    function dropDownCreation() {
        $('ul li').click(function () {
            $(this).css({
                'cursor': 'pointer',
                'background-color': 'lightgreen'
            });
            $('[name="ifsc"]').val(this.textContent);
            $('#mpumsg').show();
        });
        $('ul li').mouseover(function () {
            $(this).css({
                'cursor': 'pointer',
                'background-color': '#d3d3d3'
            });
        });
        $('ul li').mouseout(function () {
            $(this).css({
                'color': 'black',
                'background-color': 'white'
            });
        });
    }
    function buttonControl(btnData) {
        $('button')
            .click(
                function () {
                    var buttID = (this).getAttribute('id');
                    if (buttID == 'upBut') {
                        idVal = parseInt(iddata.substring(
                            'butgrp'.length, iddata.length));
                        $('#myModal').modal('show');
                        $('.modal-title').text('Update Status');
                        $('#dropData').css({
                            'height': '350px'
                        });
                        $('#dropData').html(btnData);
                        dropDownCreation();
                        $('[name="ifsc"]')
                            .on(
                                "keyup",
                                function () {
                                    var value = $(this).val()
                                        .toLowerCase();
                                    $("#dropValue li")
                                        .filter(
                                            function () {
                                                $(this)
                                                    .toggle(
                                                        $(
                                                            this)
                                                            .text()
                                                            .toLowerCase()
                                                            .indexOf(
                                                                value) > -1)
                                            });

                                });
                        updateStatusCntrl = 0;
                        confmethod();
                        //Fetch from database
                        $('#mpumsg').hide();
                        $('#mpdmsg').hide();
                    } else if (buttID == 'delBut') {
                        idVal = parseInt(iddata.substring(
                            'butgrp'.length, iddata.length));
                        $('#myModal').modal('show');
                        $('.modal-title').text('Delete Status');
                        $('#mpumsg').hide();
                        $('#mpdmsg').show();
                        deleteStatusCntrl = 0;
                        confmethod();
                        $('#dropData').html(
                            selectInfo(JSON.parse(userData)));
                        $('#dropData').css({
                            'height': '100px'
                        })

                    }
                });
    }
    function createTableTr() {
        var x = '';
        var count = 0;
        $('tbody tr').mouseover(function () {
            $(this).css({
                'cursor': 'pointer',
                'background-color': '#d3d3d3'
            });
        });
        $('tbody tr').mouseout(function () {
            $(this).css({
                'color': 'black',
                'background-color': 'white'
            });
        });
        $("tbody tr").click(
            function () {
                if (x != '') {
                    $('#' + x).hide();
                }
                if (!(x == $(this).find("td")[2].children[1]
                    .getAttribute('id'))) {
                    x = $(this).find("td")[2].children[1]
                        .getAttribute('id');
                    $('#' + x).show();
                } else if (x == $(this).find("td")[2].children[1]
                    .getAttribute('id')) {
                    if (count == 0) {
                        count = 1;
                    } else {
                        $('#' + x).show();
                        count = 0;
                    }
                }
                var jsonUserData = JSON.parse(userData);
                jsonUserData.mid = $(this).find("td")[0].textContent;
                jsonUserData.mname = $(this).find("td")[1].textContent;
                jsonUserData.bname = $(this).find("td")[2].textContent;
                jsonUserData.blocation = $(this).find("td")[3].textContent;
                jsonUserData.bcode = $(this).find("td")[4].textContent
                    .split(' ')[0];
                iddata = $(this).find("td")[2].children[1]
                    .getAttribute('id');
                userData = JSON.stringify(jsonUserData);
                console.log(iddata);
                unquerowData = this;
                console.log(jsonUserData);
            });
    }

    $(document)
        .ready(
            function () {
                var maxrange = 0;
                var clickedId = 0;
                $('.pagination').hide();
                $
                    .ajax({
                        url: 'AdminController',
                        method: 'POST',
                        data: obj,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            tempTableData = tableHead;
                            tdata = data.BRANCHMANAGER;
                            var branchData = data.BRANCH;
                            branchValue = data.BRANCH;
                            var htmlDropData = updatePanel(branchData);
                            branchDataInfo = '{'
                            tablesData = tdata;
                            $.each(
                                tdata,
                                function (tempData,
                                    valuedata) {
                                    tempTableData += '<tr>';
                                    tempTableData += '<td>'
                                        + valuedata.USER_ID
                                        + '</td>';
                                    tempTableData += '<td>'
                                        + valuedata.NAME
                                        + '</td>';
                                    tempTableData += '<td>'
                                        + valuedata.BRANCHNAME
                                    tempTableData += '<br><div id="butgrp' + valuedata.USER_ID + '">'
                                        + upButton
                                        + ' '
                                        + delButton
                                        + '</div></td>';
                                    tempTableData += '<td>'
                                        + valuedata.CITY
                                        + '</td>';
                                    tempTableData += '<td>'
                                        + valuedata.IFSCCODE;
                                    + '</td>';
                                    tempTableData += '</tr>';
                                });
                            $.each(branchData, function (branchIndex, branchInfo) {
                                branchDataInfo += '"' + branchInfo.IFSCCODE.toString() + '":' + JSON.stringify(branchInfo) + ',';
                            });
                            branchDataInfo = branchDataInfo.substring(0, branchDataInfo.length - 1) + '}';
                            mapBranchJSONData = JSON.parse(branchDataInfo);
                            console.log(mapBranchJSONData);

                            tempTableData += tableFooter;
                            $('#borderLine').html(tempTableData);
                            $("td div").hide();
                            createTableTr();
                            $('.pagination').show();
                            buttonControl(htmlDropData);
                        },
                        error: function (jqXHR, exception) {
                            console.log("not entered");
                        },
                        complete: function (jqXHR, textStatus) {
                            console.log('Complete');
                        }
                    });

                $('[name=addManager]').click(function () {
                    $('#myInputModel').modal('show');
                    $('#myInputModel .modal-title').text('Add Manager Detail');
                    $('#inputData').css({
                        "height": "590px"
                    });
                    $('[name="branchlocation"]').attr('disabled', true);
                    $('[name="branchname"]').attr('disabled', true);

                });
                $('#modelCancel').click(function () {
                    $('#myModal').modal('hide');
                });
                $('#modelAddCancel').click(function () {
                    $('#myInputModel').modal('hide');
                });
                var tmpcontrol = null;
                $("#myInput").on("keyup", function () {
                    var value = $(this).val()
                        .toLowerCase();
                    $("#borderLine tbody tr")
                        .filter(
                            function () {
                                $(this)
                                    .toggle(
                                        $(
                                            this)
                                            .text()
                                            .toLowerCase()
                                            .indexOf(
                                                value) > -1)
                            });
                });
                $('#modelCancel').click(function () {
                    $('#myModal').modal('hide');
                });
                $('[name="ifsccode"]').keyup(function (event) {
                    console.log(event.target.value);
                    var jsonvalData = mapBranchJSONData[event.target.value];
                    if (jsonvalData != undefined) {
                        console.log(jsonvalData);
                        $('[name="branchlocation"]').val(jsonvalData.CITY);
                        $('[name="branchname"]').val(jsonvalData.BRANCHNAME);
                    } else {
                        $('[name="branchlocation"]').val('No Data Found');
                        $('[name="branchname"]').val('No Data Found');
                    }
                });

                $('#AddManagerButt').click(function () {
                    var managerFieldData = {
                        "MANAGER_NAME":$('[name="managername"]').val(),
                        "IFSCCODE":$('[name="ifsccode"]').val(),
                        "BRANCH_LOCATION":$('[name="branchlocation"]').val(),
                        "BRANCH_NAME":$('[name="branchname"]').val(),
                        "AADHAR":$('[name="aadhar"]').val(),
                        "PAN":$('[name="pan"]').val(),
                        "MAIL_ID":$('[name="mailID"]').val(),
                        "MOBILE_NO":$('[name="mobileno"]').val(),
                        "GENDER":$('[name="gender"]').val()
                    }

                    var paramData = {
                        "bankingButton": "AddManagerData",
                        "managerData": JSON.stringify(managerFieldData)
                    }
                    $.ajax({
                        url: 'AdminController',
                        method: 'POST',
                        data: paramData,
                        success: function (confirmData, textStatus, jqXHR) {
                            if(confirmData != '2' && confirmData != '1' && confirmData != '0' && confirmData != '-1') {
                                var tempTableData = '';
                                tempTableData += '<tr>';
                                tempTableData += '<td>' + confirmData + '</td>';
                                tempTableData += '<td>' + $('[name="managername"]').val() + '</td>';
                                tempTableData += '<td>' + $('[name="branchname"]').val();
                                tempTableData += '<br><div id="butgrp' + confirmData + '">' + upButton + ' ' + delButton + '</div></td>';
                                tempTableData += '<td>' + $('[name="branchlocation"]').val() + '</td>';
                                tempTableData += '<td>' + $('[name="ifsccode"]').val() + '</td>';
                                tempTableData += '</tr>';
                                $('#manager tbody').append(tempTableData);
                                $("td div").hide();
                                var branchDatas = updatePanel(branchValue);
                                createTableTr();
                                buttonControl(branchDatas);
                                alert( $('[name="managername"]').val() + ' Manager added successfully');
                                $('[name="managername"]').val('');
                                $('[name="branchname"]').val('');
                                $('[name="branchlocation"]').val('');
                                $('[name="ifsccode"]').val('');
                                $('[name="aadhar"]').val('');
                                $('[name="pan"]').val('');
                                $('[name="mailID"]').val('');
                                $('[name="mobileno"]').val('');
                                $('#myInputModel').modal('hide');
                            } else if(confirmData == '-1'){
                            	alert( ' Please delete the manager in particular branch ' );
                            	$('#myInputModel').modal('hide');
                            }
                        },
                        error: function (jqXHR, exception) {
                            console.log("not entered");
                        },
                        complete: function (jqXHR, textStatus) {
                            console.log('Complete');
                        }
                    });
                });
            });
</script>
<style>
    #borderLine.groove {
        border-style: groove;
    }

    .pagination {
        display: inline-block;
    }

    .pagination a {
        color: black;
        float: left;
        padding: 8px 16px;
        text-decoration: none;
        transition: background-color .3s;
        border: 1px solid #ddd;
    }

    .pagination a.active {
        background-color: #4CAF50;
        color: white;
        border: 1px solid #4CAF50;
    }

    #manager {
        font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
        border-collapse: collapse;
        width: 100%;
    }

    #manager td,
    #customers th {
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
        background-color: #4CAF50;
        color: white;
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

<style>
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


</style>


<body>
<form action="Logout">
		<div class="header">

			<a href="AdminControl.jsp"> <img src="ImageRes/wipro.png"
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
    <div class="container">
        <div class="row">
            <div class="col-lg-2"></div>
            <div class="col-lg-8">
                <br>
                <div class="row">
                    <div class="col-lg-12">
                        <input class="form-control" id="myInput" type="text" placeholder="Search here by ....Manager ID | Branch Name | Branch Code | Manager name | Branch location">
                    </div>
                </div>
                <br>
                <!-- <div id="tempTable" class="groove1"> </div> -->
                <div id="borderLine" class="groove" style="height: 400px; width:800px"></div>
            </div>
            <div class="col-lg-2"></div>
        </div>
    </div>
    <div class="container">
        <input name="addManager" class="btn btn-secondary" data-toggle="tooltip" data-placement="top" type="image"
            title="Add Manager" src="ImageRes/AddImage.png" alt="Add"
            style="width: 75px; height: 60px; position: absolute; right: 50px; bottom: 50px;">
    </div>
    <div class="container">
        <!-- The Modal -->
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header" style="height: 40px;">
                        <h4 class="modal-title"></h4>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div id="dropData"></div>
                        <div id="mpdmsg">
                            <label>Are You sure to Delete Manager From Branch</label>
                            <button id="yesdelid" class="btn btn-default">Yes</button>
                            <button id="nodelid" class="btn btn-default">No</button>
                        </div>
                        <div id="mpumsg">
                            <label>Are You sure to Update Manager Branch Info</label>
                            <button id="yesupid" class="btn btn-default">Yes</button>
                            <button id="noupid" class="btn btn-default">No</button>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" style="height: 65px;">
                        <button type="button" class="btn btn-default" id="modelCancel">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="container">
        <!-- The Modal -->
        <div class="modal" id="myInputModel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header" style="height: 60px;">
                        <h4 class="modal-title"></h4>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div id="inputData">
                            <br>
                            <br>
                            <br>
                            <div class="container">
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>MANAGER NAME</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="managername" required />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>IFSCCODE</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="ifsccode" required />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>BRANCH LOCATION</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="branchlocation" />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>BRANCH NAME</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="branchname" />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>AADHAR</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="aadhar" required />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>PAN</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="pan" required />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>MAIL ID</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="mailID" />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>Mobile No</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <input class="form-control" type="text" name="mobileno" />
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-2"><b>
                                            <h5>GENDER</h5>
                                        </b></div>
                                    <div class="col-lg-3">
                                        <select name="gender" class="form-control">
                                            <option value="MAlE">MALE</option>
                                            <option value="FEMALE">FEMALE</option>
                                            <option value="TRANS">TRANSGENDER</option>
                                        </select>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-lg-4"></div>
                                    <div class="col-lg-3">
                                        <button type="button" id="AddManagerButt" class="btn btn-success">Add
                                            Manager</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" style="height: 65px;">
                        <button type="button" class="btn btn-default" id="modelAddCancel">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>

</html>