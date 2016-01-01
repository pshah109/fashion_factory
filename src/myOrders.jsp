<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="java.util.ArrayList"%>
<%@ page import="order.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>

<head>
  <title>My Orders</title>
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

	<jsp:include page="fetchOrders" flush="true" >
				<jsp:param name="useremail" value="<%=userEmail%>"/>
				</jsp:include>

				<%
				ArrayList<orderInfo> orderdata = new ArrayList();
				orderdata = (ArrayList<orderInfo>)request.getAttribute("orderdata");%>


				<%if(orderdata.size() == 0){%>
				<h3>There are no Orders for this Userid<h3>
				<%	}else{%>
        <br>
      <h1>Your Orders</h1>
        <br>
          <br>
          <%
			String cancelOrderValue = "";
			cancelOrderValue= (String)request.getAttribute("cancelOrderValue");
			String model= (String)request.getAttribute("model");
			String size= (String)request.getAttribute("size");
			String ordernum= (String)request.getAttribute("ordernum");
			if(cancelOrderValue=="true")
			{%>
          <br>
          <br>
          <h3>
          Your Order Number <%=ordernum%> for <%=model%> with size <%=size%> has been cancelled !!!!
          </h3>
          <br>
          <br>


			<%}else if (cancelOrderValue=="false"){%>
        <br>
        <br>
        	<h3>
        Your Order Number <%=ordernum%> for <%=model%> with size <%=size%> has been shipped for delivery.
      </h3>
			<br>
      <br>
			<h3>We will not be able to process your request for cancellation!!</h3>
      <br>
      <br>
			<%}%>
        <%
        String returnOrderValue = "";
        returnOrderValue= (String)request.getAttribute("returnOrderValue");
        String Rmodel= (String)request.getAttribute("Rmodel");
        String Rsize= (String)request.getAttribute("Rsize");
        String Rordernum= (String)request.getAttribute("Rordernum");
        if(returnOrderValue=="true")
        {%>
          <br>
          <br>
          <h3>
          Return for Order Number <%=Rordernum%> for <%=Rmodel%> with size <%=Rsize%> has been intiated !!!!
          </h3>
          <br>
          <h2> We will shortly pick up the product from your address.</h2>
          <br>
          <%}%>
          <h2> Click on Order Number to Track Order </h2>
            <br>
            <br>
				<table frame='box' rules='rows'>
				<tr><td></td><td>Order Num</td><td>Product Name</td><td>Size</td><td>Price</td>
        <td>Quantity</td><td>Delivery Date</td>
        </td><td></tr>
				<%
				for(int i=0;i<orderdata.size();i++)
								{
						orderInfo orderBean = (orderInfo)orderdata.get(i) ;

							String DATE_FORMAT = "MM/dd/yyyy";
				      SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
				      String deliverydate = sdf.format(orderBean.getDeliveryDate());
              String orderNumber = orderBean.getOrderNumber();
              String passON = orderNumber.substring(2);%>

              <%
              Date today = new Date();
              Date del=orderBean.getDeliveryDate();
              long diff = today.getTime()-del.getTime();
              long diffDays = diff/(24 * 60 * 60 * 1000);
              %>
              
              <%if(diffDays>0 && diffDays<30){%>
                <form action='returnOrder'>
              <%} else if(diffDays>=30) {%>
                <form>
              <%} else {%>
                <form action='cancelOrder'>
                <%}%>
                  <input type='hidden' name='useremail' value='<%=userEmail%>'>
  								<input type='hidden' name='product' value='<%=orderBean.getProductModel()%>'>
  								<input type='hidden' name='ordernum' value='<%=orderBean.getOrderNumber()%>'>
  								<input type='hidden' name='delivery' value='<%=deliverydate%>'>
  								<input type='hidden' name='size' value='<%=orderBean.getProductSize()%>'>
  								<input type='hidden' name='quantity' value='<%=orderBean.getProductQuantity()%>'>
  								<input type='hidden' name='productId' value='<%=orderBean.getProductID()%>'>
								<tr><td><img src="css/images/img_<%=orderBean.getProductID()%>.jpg" width = '75' height = '75'></td>
								<td><a href="trackOrder?orderNumber=<%=passON%>"><%=orderNumber%> </a></td>
								<td><%=orderBean.getProductModel()%>   </td>
                <td><%=orderBean.getProductSize()%>   </td>
								<td>$<%=orderBean.getProductPrice()%>   </td>
								<td align='center'><%=orderBean.getProductQuantity()%>   </td>
								<td><%=deliverydate%>  </td>
                <%
                Date today1 = new Date();
                Date del1=orderBean.getDeliveryDate();
                long diff1 = today1.getTime()-del1.getTime();
                long diffDays1 = diff/(24 * 60 * 60 * 1000);
                %>
                <%if(diffDays1>0 && diffDays1<30){%>
                  <td><input type='submit' class="search-submit"  value='Return Order'></td>
                <%} else if(diffDays1>=30) {%>
                  <td><input type="text" class="search-submit"  value='Order Completed' readonly></td>
                <%} else {%>
                  <td><input type='submit' class="search-submit"  value='Cancel Order'></td>
                  <%}%>
              </tr>
								</form>
						<%}%>


							</table>



				<%	}%>
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
