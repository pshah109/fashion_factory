<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <%@ page import="java.util.ArrayList"%>
  <%@ page import="product.*"%>
<head>
  <title>View Inventory</title>
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

            <jsp:include page="viewInventory" flush="true" />

          <%String productListValue="";
          productListValue=(String)request.getAttribute("productListValue");%>

          <%if(productListValue=="false"){%>
            <br>
            <h2> No Product List found under your id. You can add new products.</h2>
            <br>
          <%}%>

            <%if(productListValue=="true"){%>
            <%
            ArrayList<productBean> productdata = new ArrayList();
            productdata = (ArrayList<productBean>)request.getAttribute("productdata");%>
            <br>
              <br>
                <table frame='box' rules='rows'>
        				<tr><td></td><td>Product Name</td><td>Small</td><td>Medium</td><td>Large</td>
                <td>XLarge</td><td>Total Count</td><td>Ineventory Alert</td><td></td></tr>
                <%
        				for(int i=0;i<productdata.size();i++) {
        						productBean productInfo = (productBean)productdata.get(i) ;%>
    								<tr>
                    <td>
                        <a href="viewProduct.jsp?productID=<%=productInfo.getProductID()%>">
                      <img src="css/images/img_<%=productInfo.getProductID()%>.jpg" width = '75' height = '75'></td>
                    </a>
    								<td><%=productInfo.getProductName()%></td>
    								<td><%=productInfo.getProductQuantityS()%></td>
                    <td><%=productInfo.getProductQuantityM()%></td>
    								<td><%=productInfo.getProductQuantityL()%></td>
    								<td><%=productInfo.getProductQuantityXL()%></td>
                    <td><%=productInfo.getProductTotalQuantity()%></td>
                    <%if((productInfo.getProductQuantityS()<6) || (productInfo.getProductQuantityM()<6) || (productInfo.getProductQuantityL()<6) || (productInfo.getProductQuantityXL()<6)) {%>
                    <td> <font color="red"> Low Inventory </font></td>
                    <%} else {%>
                    <td> </td>
                    <%}%>
                    <%%>
    								<td>
                      <a href='updateProduct.jsp?productID=<%=productInfo.getProductID()%>'>Update Product</a>
                    </td>
                    </tr>
                <%}%>
              </table>
            <%}%>
        </div>

    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

      </div> <!-- end Main-->

  <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
  </div>
  <!-- End Shell -->
</body>

</html>
