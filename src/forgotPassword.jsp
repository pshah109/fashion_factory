<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Reset Password</title>
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
          <br>
            <% String resetPassValue="";
            resetPassValue = (String)request.getAttribute("resetPassValue"); %>
            <%if(resetPassValue=="true"){%>
              <h2> Email is send to reset the password.</h2>
            <%}%>
          <br>
          <br>
          <%if(resetPassValue==null || resetPassValue=="false" ){%>
          <form method="post" action="forgotPass" onsubmit="return disableButton(this);">
          <table>
            Please enter Email Address for which you want to reset the password
            <tr>
              <td align="center">
                Email ID:
                <input type="email" name="username" required>
              </td>
            </tr>
            <tr>
              <td align="center">
                <input type='submit' value='Reset Password'  class="search-submit"  name="submitButton" />
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
