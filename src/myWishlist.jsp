<%@ page import="java.util.ArrayList"%>
<%@ page import="product.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>My WishList</title>
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

          <%if(checkLogin==null){%>
          <br>
            <br>
            <h1>Please login to view your WishList.</h1>
          <%}else if (checkLogin!=null){%>

          <jsp:include page="getWishlist">
            <jsp:param name="userEmail" value="<%=userEmail%>"/>
          </jsp:include>

          <%String getWishlistValue="";
          getWishlistValue=(String)request.getAttribute("getWishlistValue");

          String removeFromWishlistValue="";
          removeFromWishlistValue=(String)request.getAttribute("removeFromWishlistValue");

          if(removeFromWishlistValue=="true"){%>
          <br>
            <h2> Product Removed from Wishlist </h2>
          <%}%>

          <%if(getWishlistValue=="false"){%>
            <br>
            <br>
            <h2>No products found in Wishlist. Add your favourite products here</h2>
            <%}else if (getWishlistValue=="true"){%>

              <%ArrayList<productBean> wishlistdata = new ArrayList();%>
              	  <%wishlistdata = (ArrayList<productBean>)request.getAttribute("wishlistdata");%>

                    <table style="width:100%" frame='box' rules='rows'>
                    <tr><td></td><td>Product Name</td><td>Price</td><td></td></tr>
                    <%for(int i=0;i<wishlistdata.size();i++)
        							{
        							productBean wishlistInfo = (productBean)wishlistdata.get(i) ;%>
                      <br>
        							<tr>
                        <td>
                          <a href="viewProduct.jsp?productID=<%=wishlistInfo.getProductID()%>">
                        <img src="css/images/img_<%=wishlistInfo.getProductID()%>.jpg" width = '75' height = '75'/>
                      </a>
                      </td>
        							<td><%=wishlistInfo.getProductName()%> By <%=wishlistInfo.getProductBrand()%></td>
        							<td>$<%=wishlistInfo.getProductPrice()%></td>
        							<td><a href='removeFromWishlist?productID=<%=wishlistInfo.getProductID()%>'>Remove From Wishlist</a></td>
        							</tr>
        							<%}%>
                      </table>




              <%}%>
         <%}%>









        </div>

    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

      </div> <!-- end Main-->

  <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
  </div>
  <!-- End Shell -->
</body>

</html>
