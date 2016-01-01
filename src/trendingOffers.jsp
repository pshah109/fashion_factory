<%@ page import="java.util.ArrayList"%>
<%@ page import="product.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <title>Fashion Factory </title>
  <link rel="icon" type="image/png" href="css/images/favicon-16x16.png" sizes="16x16" />
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
  <script type="text/javascript" src="js/searchProduct.js"></script>
</head>



<jsp:include page="trendingOffersAction" flush="true" />


     <%String productListValue="";
     productListValue=(String)request.getAttribute("productListValue");%>

<body onload="init()">
  <!-- Shell -->
  <div class="shell">
    <!-- Header -->
      <%@include file="global/header.jsp"%>

    <div id="main">
      <div class="cl">&nbsp;</div>
      <!-- Content -->
      <div id="content">
        <div class="products">
          <div class="cl">&nbsp;</div>
          <br>
          <h3> Trending Offers </h3>
          <br>
            <br>
          <%if(productListValue=="true"){%>
          <%ArrayList<productBean> productdata = new ArrayList();%>
          	  <%productdata = (ArrayList<productBean>)request.getAttribute("productdata");%>
          <ul>
		     <%for(int i=0;i<productdata.size();i++){
			productBean productInfo = (productBean)productdata.get(i);%>
			 <li class="last"  style="margin: 0 5px 40px 0" >
              <a href="viewProduct.jsp?productID=<%=productInfo.getProductID()%>">
                <img src="css/images/img_<%=productInfo.getProductID()%>.jpg" width = '251' height = '390' alt="" />
              </a>
              <div class="product-info">
                <h3><%=productInfo.getProductCategory()%></h3>
                <div class="product-desc">
                  <h4><%=productInfo.getProductName()%></h4>
                  <p style="font-size:12px"><%=productInfo.getProductBrand()%></p>
                  Discount upto: <%=productInfo.getDiscountPercent()%>%
                  <strong class="price">Price:$<%=productInfo.getOfferPrice()%></strong>
                </div>
              </div>
            </li>
					<%}%>
          </ul>
          <%} else if(productListValue=="false" || productListValue==null){%>
          <h2>No offer found . Please check back later. </h2>
          <%}%>
          <div class="cl">&nbsp;</div>
        </div>
        <!-- End Products -->
      </div>
      <!-- End Content -->
      <!-- Sidebar -->
      <%@include file="global/sidebar.jsp"%>
    </div>
    <!-- End Main -->
    <%@include file="global/footer.jsp"%>
  </div>
  <!-- End Shell -->
</body>

</html>
