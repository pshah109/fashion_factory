<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <%@ page import="java.util.ArrayList"%>
  <%@ page import="order.*"%>
  <%@ page import="java.text.*"%>
<head>
  <title>Track Order</title>
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
            <br>
              <%
              String trackOrderValue = (String)request.getAttribute("trackOrderValue");
              if(trackOrderValue=="false"){%>
              <h2> Wrong Order Number or No Order information found for provided input number</h2>
              <br>
                <br>
              <%}%>

              <%if(trackOrderValue=="true"){
                ArrayList<orderInfo> orderdata = new ArrayList();
        				orderdata = (ArrayList<orderInfo>)request.getAttribute("orderdata");
                int totalOrderValue=0;%>

                  <h2> Your Order Information: </h2>
                  <br>

                    <%for(int i=0; i<orderdata.size();i++) {
            				orderInfo totalOrderInfo = (orderInfo)orderdata.get(i);%>
                    <%totalOrderValue+=totalOrderInfo.getProductPrice();%>
                   <%}
                   String orderStatus = (String)request.getAttribute("orderStatus");%>

                    <%orderInfo uniqueOrderInfo = (orderInfo)orderdata.get(0);
                    String DATE_FORMAT = "MM/dd/yyyy";
      				      SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
      				      String deliverydate = sdf.format(uniqueOrderInfo.getDeliveryDate());%>

                  <p>Order Number : <%=uniqueOrderInfo.getOrderNumber()%></p>
                  <br>
                  <p>Shipping Address : <%=uniqueOrderInfo.getShippingAddress()%></p>
                  <br>
                  <p>User ID : <%=uniqueOrderInfo.getUserID()%></p>
                  <br>
                  <p>Total Amount Paid : $<%=totalOrderValue%></p>
                  <br>
                  <p> Delivery Date: <%=deliverydate%></p>
                  <br>
                  <p> Order Status: <%=orderStatus%></p>
                  <br>

                    <table frame='box' rules='rows'>
            				<tr><td></td><td>Product Name</td><td>Size</td><td>Price</td><td>Quantity</td>
                    </td><td></tr>
                <%for(int i=0; i<orderdata.size();i++) {
        				orderInfo orderBean = (orderInfo)orderdata.get(i);%>

                  <tr>
                    <td>
                      <a href="viewProduct.jsp?productID=<%=orderBean.getProductID()%>">
                    <img src="css/images/img_<%=orderBean.getProductID()%>.jpg" width = '75' height = '75'>
                  </a>
                  </td>
                  <td><%=orderBean.getProductModel()%> </td>
                  <td><%=orderBean.getProductSize()%> </td>
  								<td>$<%=orderBean.getProductPrice()%> </td>
                  <td><%=orderBean.getProductQuantity()%> </td>
                  <td> </td>
                  </tr>
              <%}%>
                </table>
                <br>
                  <br>
                    <h2> Track another order </h2>
                    <br>
              <%}%>

            <h2>You can track your order status here </h2>
            <br>
              <br>
            <form action="trackOrder">
            <table>
              <tr>
                <td align="center">
                  Please input your unique Order Number here (starts with A#):
                  <input type="text" name="orderNumber" required>
                </td>
              </tr>
              <tr>
                <td align="center">
                  <input type='submit'class="search-submit" value='Track Order' />
                </td>
              </tr>
            </table>
          </form>
          <br>
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
