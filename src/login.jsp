<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Login-Fashion Factory</title>
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
          <% String loginValue="";
          loginValue = (String)request.getAttribute("loginValue"); %>

          <%if(loginValue=="false"){%>
            <h2> Wrong Email ID or password. Please provide correct credentials to login.</h2>
            <h2>Forgot Password ? Please <a href=forgotPassword.jsp>Click Here</a> to reset the password.<h2>
          <%}%>
          <br>
          <br>
          <%if(loginValue==null || loginValue=="false"){%>
          <form method="post" action="authUser">
          <table>
            <tr>
              <td align="center">
                Email ID:&nbsp;&nbsp;
                &nbsp;&nbsp;<input type="text" name="username" required>
              </td>
            </tr>
            <tr>
              <td align="center">
                Password:&nbsp;&nbsp;
                <input type="password" name="userpass" required>
              </td>
            </tr>
            <tr>
              <td align="center">
                <input type='submit'class="search-submit" value='Login' />
              </td>
            </tr>
          </table>
        </form>
        <br>
        <h3 align="center">Forgot Password ? Please <a href=forgotPassword.jsp>Click Here</a> to reset the password.<h3>
        <%}%>
          <br>
          <br>
          <h3 align="center">Not yet Registered? Please Click on below link to register</h3>
          <h2 align="center"><a href="registerCustomer.jsp">Register Now!!</a></h2>
        </div>

    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

      </div> <!-- end Main-->

  <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
  </div>
  <!-- End Shell -->
</body>

</html>
