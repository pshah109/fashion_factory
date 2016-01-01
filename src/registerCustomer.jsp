<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <script type="text/javascript" src="js/registerCust.js" > </script>
  <title>Register-Fashion Factory</title>
  <link rel="icon" type="image/png" href="css/images/favicon-16x16.png" sizes="16x16" />
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
  <script type="text/javascript" src="js/searchProduct.js"></script>
  <script type="text/javascript" src="js/disableButton.js"></script>
</head>
<body onload="init()">
  <!-- Shell -->
  <div class="shell">
    <%@include file="global/header.jsp"%>     <!-- include from gloabl -->
      <div id="main">
        <div class="cl">&nbsp;</div>
        <div id="content">

          <% String userExists="";
          userExists = (String)request.getAttribute("userExists"); %>

          <%if(userExists=="false"){%>
          <br>
          <br>
          <br>
          <h2>You are registered sucessfully. Please use your email address as your User ID for <a href="login.jsp">login</a>.</h2>
          <%} else if(userExists=="true"){%>
          <br>
          <h2>Email ID is already registered. Please enter new Email ID.</h2>
          <%}%>

          <%if(userExists==null || userExists=="true"){%>
            <form method="post" name="registerCust" action="registerCustSer" onsubmit="return disableButton(this);">
          <table>
            <tr align="left">
                <td style="width:50px">First Name:</td> <td> Last Name:</td></tr>
              <tr align="left"> <td> <input type="text" name="firstName" required></td>
              <td> <input type="text" name="lastName" required></td>
            </tr>
            <tr>
              <td style="width:50px">Email Address: (UserID)</td> <td></td></tr></tr>
              <tr align="left"> <td> <input type="email" name="userEmail"  autocomplete="off" required></td>
              <td></td>
            </tr>
            <tr >
              <td style="width:50px">Password:</td> <td></td></tr></tr>
              <tr align="left"> <td> <input type="password" name="userPassword" required></td>
              <td></td>
            </tr>
            <tr >
              <td style="width:50px">Password Again:</td> <td></td></tr></tr>
              <tr align="left"> <td> <input type="password" name="userPasswordR" required></td>
              <td></td>
            </tr>
            <tr >
              <td style="width:50px">Register As:</td> <td></td></tr></tr>
              <tr align="left"> <td> <select name='userRole'>
                <option value='Customer' selected>Customer</option>
                <option value='Seller'>Seller</option></select>
              </td>
              <td></td>
            </tr>
            <tr>
             <td align="left">
               <input type="submit" class="search-submit" value="Register" onclick="return validate()" name="submitButton" />
             </td>
           </tr>
          </table>
        </form>
        <%}%>
          <br>
          <br>
        </div>

    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

      </div> <!-- end Main-->

  <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
  </div>
  <!-- End Shell -->
</body>

</html>
