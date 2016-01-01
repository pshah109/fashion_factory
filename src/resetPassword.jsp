<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <script type="text/javascript" src="js/registerCust.js" > </script>
  <title>Reset Password</title>
  <link rel="icon" type="image/png" href="css/images/favicon-16x16.png" sizes="16x16" />
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
  <script type="text/javascript" src="js/searchProduct.js"></script>
</head>
<body onload="init()">
  <!-- Shell -->
  <div class="shell">
    <%@include file="global/header.jsp"%>     <!-- include from gloabl -->
      <div id="main">
        <div class="cl">&nbsp;</div>
        <div id="content">
          <br>
            <% String randomToken="";
            randomToken = (String)request.getParameter("token"); %>

            <jsp:include page="checkResetPasswordToken">
              <jsp:param name="token" value="<%=randomToken%>"/>
				        </jsp:include>

                <% String tokenValue="";
                tokenValue = (String)request.getAttribute("tokenValue"); %>

                <%if(tokenValue=="false"){%>
                  <h2>Invalid reset URL. Please click on URL again in email or Request another email for password Reset</h2>
                <%}%>

          <br>
          <br>
          <%if(tokenValue=="true"){%>
          <% String userName="";
          userName = (String)request.getAttribute("resetEmail"); %>
          <form method="post" name="registerCust" action="updatePass">
          <table>
            Please enter new Password to reset for Email <%=userName%>
            <tr  align="center">
              <td align="center">
                Password:
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="userPassword" required>
              </td>
            </tr>
            <tr  align="center">
              <td align="center">
                Password Again:
                <input type="password" name="userPasswordR" required>
              </td>
            </tr>
            <tr>
              <td align="center">
                  <input type='hidden' name='userName' value="<%=userName%>" />
                <input type='submit' class="search-submit" value='Reset Password' onclick="return validate()" />
              </td>
            </tr>
          </table>
        </form>
        <%}%>

        <% String updatePassValue="";
        updatePassValue = (String)request.getAttribute("updatePassValue"); %>

        <%if(updatePassValue=="false"){%>
        <h2>No user exist with email adddress. Please try agian or enter correct email Address </h2>
        <%} else if(updatePassValue=="true"){%>
        <h2>Your password is updated sucessfully.Please login with new password. </h2>
        <%}else if (updatePassValue==null) {%>

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
