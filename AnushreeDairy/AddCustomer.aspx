<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCustomer.aspx.cs" Inherits="AnushreeDairy.AddCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var map;
        var endMarker;

        function initialize() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (success) {
                    navigator.geolocation.getCurrentPosition(function (position) {

                        var lat = position.coords.latitude;
                        var lng = position.coords.longitude;

                        directionsDisplay = new google.maps.DirectionsRenderer();
                        var spot = new google.maps.LatLng(lat, lng);
                        var mapOptions = {
                            zoom: 17,
                            center: spot
                        }
                        map = new google.maps.Map(document.getElementById("map"), mapOptions);
                        //var marker = new google.maps.Marker({ position: spot, map: map, draggable: true });
                        directionsDisplay.setMap(map);

                        // if any previous marker exists, let's first remove it from the map
                        if (endMarker) {
                            endMarker.setMap(null);
                        }
                        // create the marker
                        endMarker = new google.maps.Marker({
                            position: spot,
                            map: map,
                            draggable: true,
                        });
                        copyMarkerpositionToInput();
                        // add an event "onDrag"
                        google.maps.event.addListener(endMarker, 'dragend', function () {
                            copyMarkerpositionToInput();
                        });
                    });
                },
                    function (failure) {
                        document.getElementById("drop").style.display = "block";
                        directionsDisplay = new google.maps.DirectionsRenderer();
                        var paris = new google.maps.LatLng(18.52073289770824, 73.85648647119137);
                        var mapOptions = {
                            zoom: 12,
                            center: paris
                        }
                        map = new google.maps.Map(document.getElementById("map"), mapOptions);
                        directionsDisplay.setMap(map);
                    });
            }
        }

        function dropPin() {
            // if any previous marker exists, let's first remove it from the map
            if (endMarker) {
                endMarker.setMap(null);
            }
            // create the marker
            endMarker = new google.maps.Marker({
                position: map.getCenter(),
                map: map,
                draggable: true,
            });
            copyMarkerpositionToInput();
            // add an event "onDrag"
            google.maps.event.addListener(endMarker, 'dragend', function () {
                copyMarkerpositionToInput();
            });
        }

        function copyMarkerpositionToInput() {
            // get the position of the marker, and set it as the value of input
            document.getElementById("lat").value = endMarker.getPosition().lat()
            document.getElementById("lng").value = endMarker.getPosition().lng();
        }

        // google.maps.event.addDomListener(window, 'load', initialize);

        function validateForm() {
            if (document.getElementById('<%=txtFirstName.ClientID%>').value == "") {
                document.getElementById("lblFirstName").style.display = "block";
                document.getElementById('<%=txtFirstName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtFirstName.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtFirstName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtLastName.ClientID%>').value == "") {
                document.getElementById("lblLastName").style.display = "block";
                document.getElementById('<%=txtLastName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtLastName.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtLastName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtUserName.ClientID%>').value == "") {
                document.getElementById("lblUserName").style.display = "block";
                document.getElementById('<%=txtUserName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtUserName.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtUserName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtPassword.ClientID%>').value == "") {
                document.getElementById("lblPassword").style.display = "block";
                document.getElementById('<%=txtPassword.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtPassword.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtPassword.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtConfirmPassword.ClientID%>').value == "") {
                document.getElementById("lblConfirmPassword").style.display = "block";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtPassword.ClientID%>').value != document.getElementById('<%=txtConfirmPassword.ClientID%>').value) {
                document.getElementById("lblPassTryAgain").style.display = "block";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtMobile.ClientID%>').value == "") {
                document.getElementById("lblMobile").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtMobile.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtMobile.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtEmail.ClientID%>').value == "") {
                document.getElementById("lblEmail").style.display = "block";
                document.getElementById('<%=txtEmail.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtEmail.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtEmail.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtBuilding.ClientID%>').value == "") {
                document.getElementById("lblBuilding").style.display = "block";
                document.getElementById('<%=txtBuilding.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtBuilding.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtBuilding.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtStreet.ClientID%>').value == "") {
                document.getElementById("lblStreet").style.display = "block";
                document.getElementById('<%=txtStreet.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtStreet.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=txtStreet.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlArea.ClientID%>').value == "0") {
                document.getElementById("lblArea").style.display = "block";
                document.getElementById('<%=ddlArea.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlArea.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=ddlArea.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlCity.ClientID%>').value == "0") {
                document.getElementById("lblCity").style.display = "block";
                document.getElementById('<%=ddlCity.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlCity.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=ddlCity.ClientID%>').focus();
                return false;
            }

        }

        function hideFirstNamelbl() {
            document.getElementById("lblFirstName").style.display = "none"
            document.getElementById('<%=txtFirstName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtFirstName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideLastNamelbl() {
            document.getElementById("lblLastName").style.display = "none"
            document.getElementById('<%=txtLastName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtLastName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideUserNamelbl() {
            document.getElementById("lblUserName").style.display = "none"
            document.getElementById('<%=txtUserName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtUserName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hidePasswordlbl() {
            document.getElementById("lblPassword").style.display = "none"
            document.getElementById("lblPassTryAgain").style.display = "none"
            document.getElementById('<%=txtPassword.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtPassword.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideConfirmPasswordlbl() {
            document.getElementById("lblConfirmPassword").style.display = "none"
            document.getElementById("lblPassTryAgain").style.display = "none"
            document.getElementById('<%=txtConfirmPassword.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtConfirmPassword.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideMobilelbl() {
            document.getElementById("lblMobile").style.display = "none"
            document.getElementById('<%=txtMobile.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtMobile.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideEmaillbl() {
            document.getElementById("lblEmail").style.display = "none"
            document.getElementById('<%=txtEmail.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtEmail.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideBuildinglbl() {
            document.getElementById("lblBuilding").style.display = "none"
            document.getElementById('<%=txtBuilding.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtBuilding.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideStreetlbl() {
            document.getElementById("lblStreet").style.display = "none"
            document.getElementById('<%=txtStreet.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtStreet.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideArealbl() {
            document.getElementById("lblArea").style.display = "none"
            document.getElementById('<%=ddlArea.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlArea.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideCitylbl() {
            document.getElementById("lblCity").style.display = "none"
            document.getElementById('<%=ddlCity.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlCity.ClientID%>').style.borderColor = "#e7e7e7";
        }
    </script>

    <style>
        .error {
            color: #ef5350;
            font-size: 12px;
            display: none;
            margin-bottom: 0;
            font-weight:normal;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="margin-top:40px">
        <div class="col-lg-3"></div>
        <div class="col-lg-6">
            <div class="card">
                <div class="card-body">
                    <div class="form-validation">
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="txtFirstName">Name<span class="text-danger">*</span></label>
                            <div class="col-lg-8">
                                <input type="text" runat="server" class="form-control" id="txtFirstName" placeholder="Enter a first name.." onkeypress="hideFirstNamelbl()"/>
                                <label id="lblFirstName" class="error">Please enter first name</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="txtFirstName"></label>
                            <div class="col-lg-8">
                                <input type="text" runat="server" class="form-control" id="txtLastName" placeholder="Enter a last name.."  onkeypress="hideLastNamelbl()"/>
                                <label id="lblLastName" class="error">Please enter last name</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="txtUserName">Username <span class="text-danger">*</span></label>
                            <div class="col-lg-8">
                                <input type="text" runat="server" class="form-control" id="txtUserName" placeholder="Enter a User name.."  onkeypress="hideUserNamelbl()"/>
                                <label id="lblUserName" class="error">Please enter user name</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="txtPassword">Password <span class="text-danger">*</span></label>
                            <div class="col-lg-8">
                                <input type="password" runat="server" class="form-control" id="txtPassword" placeholder="Choose a safe one.." onkeypress="hidePasswordlbl()"/>
                                <label id="lblPassword" class="error">Please enter password</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="txtConfirmPassword">Confirm Password <span class="text-danger">*</span></label>
                            <div class="col-lg-8">
                                <input type="password" runat="server" class="form-control" id="txtConfirmPassword" placeholder="..and confirm it!"  onkeypress="hideConfirmPasswordlbl()"/>
                                <label id="lblConfirmPassword" class="error">Please confirm password</label>
                                <label id="lblPassTryAgain" class="error">Password and Confirm Password do not match, Please try again.</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="txtMobile">Mobile No. <span class="text-danger">*</span></label>
                            <div class="col-lg-8">
                                <input type="text" runat="server" class="form-control" id="txtMobile" placeholder="Enter a mobile number.." onkeypress="hideMobilelbl()"/>
                                <label id="lblMobile" class="error">Please enter mobile number</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="txtEmail">Email Id</label>
                            <div class="col-lg-8">
                                <input type="text" runat="server" class="form-control" id="txtEmail" placeholder="Enter a email id.." onkeypress="hideEmaillbl()"/>
                                <label id="lblEmail" class="error">Please enter email id</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-lg-4 col-form-label" for="val-suggestions">Address<span class="text-danger">*</span></label>
                            <div class="col-lg-3">
                                <input type="text" runat="server" class="form-control" id="txtFlat" placeholder="Flat no.." />
                            </div>
                            <div class="col-lg-5">
                                <input type="text" runat="server" class="form-control" id="txtBuilding" placeholder="Building name.." onkeypress="hideBuildinglbl()"/>
                                <label id="lblBuilding" class="error">Please enter building name</label>
                            </div>
                        </div>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" for="val-suggestions"></label>
                                    <div class="col-lg-4">
                                        <input type="text" runat="server" class="form-control" id="txtStreet" placeholder="Street.." onkeypress="hideStreetlbl()"/>
                                        <label id="lblStreet" class="error">Please enter street name</label>
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:DropDownList class="form-control" ID="ddlArea" runat="server" OnSelectedIndexChanged="ddlArea_SelectedIndexChanged" AutoPostBack="true" onkeypress="hideArealbl()"></asp:DropDownList>
                                        <label id="lblArea" class="error">Please select area</label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-4 col-form-label" for="val-suggestions"></label>
                                    <div class="col-lg-4">
                                        <asp:DropDownList class="form-control" ID="ddlCity" runat="server" onkeypress="hideCitylbl()">
                                            <asp:ListItem Text="Select City.." Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Pune" Value="1" Selected="True"></asp:ListItem>
                                            <%--<asp:ListItem Text="Mumbai" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Bangalore" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Delhi" Value="4"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                        <label id="lblCity" class="error">Please select city</label>
                                    </div>
                                    <div class="col-lg-4">
                                        <input type="text" runat="server" class="form-control" id="txtPin" placeholder="Pincode.." readonly="true"/>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <div class="form-group row" style="margin-top:20px">
                            <label class="col-lg-4 col-form-label" for="val-suggestions">Select your location on map<span class="text-danger">*</span></label>

                            <div class="col-lg-8">
                                <input id="lat" readonly="true" runat="server" style="border: none;width:1px;height:1px;font-size:1px;color:#fff"/>
                                <input id="lng" readonly="true" runat="server" style="border: none;width:1px;height:1px;font-size:1px;color:#fff"/>
                            </div>
                        </div>
                        <div id="drop" style="display: none">
                            <input type="button" value="Drop Pin" onclick="dropPin()"/>Drop a marker on the center of your map<br />
                        </div>

                        <div id="map" style="height: 400px; margin: 20px 0;"></div>
                        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBk25E4mNfVIEt3tNl3K1HwNZVruVoFBlA&callback=initialize"></script>
                        <div class="form-group row">
                            <div class="col-lg-12 ml-auto">
                                <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return validateForm()"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3"></div>
    </form>
</body>
</html>
