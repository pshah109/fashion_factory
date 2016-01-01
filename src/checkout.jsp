<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="java.util.ArrayList"%>
<%@ page import="product.*"%>
<%@ page import="shoppingCart.*"%>

<head>
  <title>Checkout</title>
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
      <!-- Content -->
      <div id="content">
	 <% if (checkLogin==null) {

	 %>
          <br>
          <h2>Please <a href="login.jsp">login to Checkout.</a></h2>
          <br>
          <h2>Yet not registered with us ? <a href="registerCustomer.jsp">Register now!!!</a></h2>
	 <% }else{

	 cart ekart;
	 ekart = (cart) session.getAttribute("cart");
	 ArrayList<productBean> Items= ekart.getCartItems();
	 int sum=0;
	 for(int i=0;i<Items.size();i++)
							{
							productBean productData = (productBean)Items.get(i) ;
							sum=sum+(productData.getProductPrice()*productData.getProductPurchaseQuantity());
							}
	 %>


		<form method = 'post' action = 'checkoutProcess' onsubmit="return disableButton(this);">

			  <table><tr>
				<td> User Id</td>
				<td><input type='text' name='userid' value="<%=userEmail%>" readonly ></td>
				</tr>
				<tr>
				<td> First Name</td>
				<td><input type='text' name='firstName' value="<%=checkLogin%>" readonly></td>
				</tr>


				<tr>
				<td> Address:</td>
				<td><input type='text' name='addr' required></td>
				</tr>

					<tr>
				<td> City </td>
				<td><input type='text' name='city' required></td>
				</tr>

					<tr>
				<td> State </td>
				<td><input type='text' name='state' required></td>
				</tr>

				<tr>
				<td> Zip </td>
				<td><input type='number' name='zip' min='00001' max='99999' required></td>
				</tr>

				<tr>
				<td> Country </td>
				<td><input type='text' name='country' required></td>
				</tr>


				<tr>
				<td> Amount Payable </td>
				<td>$<%=sum%></td>
				</tr>

				<tr>
				<td> Credit Card Details:-</td>
				<td><input type='number' maxlength="4" size='6' min="1000" max="9999" required>
        <input type='number' maxlength="4" size='6' min="1000" max="9999"  required>
        <input type='number' maxlength="4" size='6' min="1000" max="9999"  required>
        <input type='number' maxlength="4" size='6' min="1000" max="9999"  required>
        </td>
      </tr>
        <tr> <td>
        Valid Till Month: </td> <td><input type='number'  maxlength='2' size='6' min='1' max='12' >&nbsp&nbsp
        Year: <input type='number'  maxlength='4' size='6' min='2015' max='2099' required>&nbsp&nbsp
        CVV: <input type='password'  maxlength='3' size='6' min='1' max='999' required></td>
				</tr>

				<tr><td align='center' colspan='2'>
          <input type='submit' class="search-submit" value='Make Payment' name="submitButton"></td></tr>
			</table>
			</form>
	<% }%>


      </div>
      <!-- End Content -->
    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->
    </div>
    <!-- End Main -->
  <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
  </div>
  <!-- End Shell -->
</body>

</html>
