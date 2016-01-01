<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <title>Fashion Factory</title>
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
        <!-- Content Slider -->

        <jsp:include page="trendingProductsAction" flush="true" />
             <%String productListValue="";
             productListValue=(String)request.getAttribute("productListValue");%>
        <div id="slider" class="box">
          <div id="slider-holder">
            <ul>
              <li>
                <a href="index.jsp">
                  <img src="css/images/slide1.jpg" alt="" />
                </a>
              </li>
            </ul>
          </div>
          <div id="slider-nav">
            <a href="#" class="active">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> </div>
        </div>
        <!-- End Content Slider -->
        <!-- Products -->
        <div class="products">
        <div class="cl">&nbsp;</div>
        <br>
          <br>
        <%if(productListValue=="true"){%>
        <%ArrayList<productBean> productdata = new ArrayList();%>
            <%productdata = (ArrayList<productBean>)request.getAttribute("productdata");%>
        <ul>
       <%for(int i=0;i<3;i++){
    productBean productInfo = (productBean)productdata.get(i);%>
    <li class="last"  style="margin: 0 5px 40px 0" >
           <a href="viewProduct.jsp?productID=<%=productInfo.getProductID()%>">
             <img src="css/images/img_<%=productInfo.getProductID()%>.jpg" width = '231' height = '300' alt="" />
           </a>
           <div class="product-info">
             <h3><%=productInfo.getProductCategory()%></h3>
             <div class="product-desc">
               <p><%=productInfo.getProductName()%></p>
               <h4><%=productInfo.getProductBrand()%></h4>
               <%if(productInfo.getDiscountPercent()>0){%>
               Discount upto: <%=productInfo.getDiscountPercent()%>%
               <strong class="price">Price:$<%=productInfo.getOfferPrice()%></strong>
               <%} else{%>
                 <strong class="price">Price:$<%=productInfo.getProductPrice()%></strong>
               <%}%>
              </div>
            </div>
          </li>
          <%}%>
        </ul>
        <%} else if(productListValue=="false" || productListValue==null){%>
        <h2>No product found . Please check back later. </h2>
        <%}%>
        <div class="cl">&nbsp;</div>
      </div>
      <!-- End Products -->
        <!-- End Products -->
      </div>
      <!-- End Content -->
      <!-- Sidebar -->
  <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->
      <!-- End Sidebar -->
      <div class="cl">&nbsp;</div>
    </div>
    <!-- End Main -->
    <!-- Side Full -->
    <div class="side-full">
      <!-- Text Cols -->
      <div class="cols">
        <div class="cl">&nbsp;</div>
        <div class="col">
          <h3 class="ico ico1">About Us</h3>
          <p>Website is designed by Team 11 for Project of CSP-595 in Fall 2015.</p>
        </div>
        <div class="col">
          <h3 class="ico ico2">Contact Us</h3>
          <p>Contact Us on +1-(312)-1234 or mail us on contact@fashionfactory.com</p>
        </div>
        <div class="col">
          <h3 class="ico ico4">Return Policy</h3>
          <p>You may return most new unopened items sold and fulfilled by Fashion Factory within 30 days of delivery for refund. Plese login into account and click on return order.</p>
        </div>
        <div class="col col-last">
          <h3 class="ico ico4">Cancellation Policy</h3>
          <p>You may cancel your order before 3 days of delivery. Please login into account and click on cancel order.</p>
        </div>
        <div class="cl">&nbsp;</div>
      </div>
      <!-- End Text Cols -->
    </div>
    <!-- End Side Full -->
    <!-- Footer -->
    <div id="footer">
      <p class="left"> <a href="#">Follow Us On</a>
        <span>|</span> <a href="#">Facebook</a>
        <span>|</span> <a href="#">Twitter</a>
        <span>|</span> <a href="#">Pinterest</a> </p>
      <p class="right"> &copy; 2015 Fashion Factory. Design by Team 11 - CSP 595 </p>
    </div>
    <!-- End Footer -->
  </div>
  <!-- End Shell -->
</body>

</html>
