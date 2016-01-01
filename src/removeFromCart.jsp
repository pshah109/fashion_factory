<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="java.util.ArrayList"%>
<%@ page import="product.*"%>
<%@ page import="shoppingCart.*"%>


<head>
  <title>View Cart</title>
  <link rel="icon" type="image/png" href="css/images/favicon-16x16.png" sizes="16x16" />
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
  <script type="text/javascript" src="js/searchProduct.js"></script>
</head>

<%
    int productID = Integer.parseInt(request.getParameter("productID"));
    String productSize = request.getParameter("productSize");
    cart ekart;
    ekart = (cart) session.getAttribute("cart");
    ekart.deleteFromCart(productID,productSize);
    session.setAttribute("cart", ekart);
    ekart = (cart) session.getAttribute("cart"); %>
<body onload="init()">
  <!-- Shell -->
  <div class="shell">
    <%@include file="global/header.jsp"%>     <!-- include from gloabl -->
    <div id="main">
      <div class="cl">&nbsp;</div>
      <!-- Content -->
      <div id="content">
	  <br>

		  <%  if(ekart==null )
				{%>
			       <h1>Cart is Empty </h1>
				<%}
				else
				{
				ArrayList<productBean> Items= ekart.getCartItems();
						if(Items.isEmpty())
						{%>
						<h1>Cart is Empty </h1>
						<%}
						else
						{%>
                <form action='checkout.jsp'>
						<table style="width:100%" frame='box' rules='rows'>
						<tr><td></td><td>Product Name</td><td>Price</td><td>Size</td><td>Quantity</td><td></td></tr>
						<%
            int totalCartPrice=0;
						for(int i=0;i<Items.size();i++)
							{
							productBean productdata = (productBean)Items.get(i) ;
              totalCartPrice+=productdata.getProductPrice()*productdata.getProductPurchaseQuantity();%> 
							<tr><td><img src="css/images/img_<%=productdata.getProductID()%>.jpg" width = '75' height = '75'>
							<td><%=productdata.getProductName()%></td>
							<td>$<%=productdata.getProductPrice()%></td>
							<td><%=productdata.getProductSize()%></td>
							<td><%=productdata.getProductPurchaseQuantity()%></td>
							<td><a href='removeFromCart.jsp?productID=<%=productdata.getProductID()%>&productSize=<%=productdata.getProductSize()%>'>Remove From Cart</a> </td>
							</tr>
							<%}%>
              <tr>
                <td align="center" colspan='6'> <h2> Total Amount : $<%=totalCartPrice%> </h2></td>
              </tr>
              <tr ><td align='center' colspan='6'>
                <input type="submit" class="search-submit" name="Submit" value= "CheckOut" /></td></tr>
              </form>
						</table>
						<%}
}%>
      </div>
      <!-- End Content -->
  <%@include file="global/sidebar.jsp"%>
    </div>
    <!-- End Main -->
    <%@include file="global/footer.jsp"%>
  <!-- End Shell -->
</body>

</html>
