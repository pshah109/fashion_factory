<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.*"%>
<%@ page import="product.*"%>
<%@ page import="order.*"%>


<head >
  <title>Order Summary</title>
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
      <!-- Content -->
      <div id="content">
	  <br>

	 <% ArrayList<orderInfo> Orders = new ArrayList<orderInfo>() ;%>
     <%Orders = (ArrayList<orderInfo>)session.getAttribute("Orders");%>


	<%orderInfo orderData = (orderInfo)Orders.get(0);%>
	<%
		String DATE_FORMAT = "MM/dd/yyyy";
				SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
				String deliverydate = sdf.format(orderData.getDeliveryDate());
				String purchasedate = sdf.format(orderData.getPurchaseDate());
%>

	<br>
  <br>
	<h1>Your Order : <%=orderData.getOrderNumber()%> has been placed succesfully </h1>
    <br>
    <h2> You can track your order <a href="trackOrder.jsp">here</a> </h2>
    <br>
	  <h2>The order will be delivered to : <br> <br>
	<%=orderData.getShippingAddress()%> by <%=deliverydate%> <br><br>
  <h2 style="text-transformation:none"> Thank you for shopping with us!! </h2>
  <br>
    <br>
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
