<%@ page import="java.util.ArrayList"%>
<%@ page import="product.*"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <script type="text/javascript" src="js/productSortFilter.js" > </script>
  <title>Fashion Factory </title>
  <link rel="icon" type="image/png" href="css/images/favicon-16x16.png" sizes="16x16" />
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
  <script type="text/javascript" src="js/searchProduct.js"></script>
</head>

<%String category=request.getParameter("category");%>
  <%String subcategory=request.getParameter("subcategory");%>

  <%String redirectURLValue="";
  redirectURLValue=(String)request.getAttribute("redirectURLValue");
  %>

  <%if(redirectURLValue==null){%>
<jsp:include page="productList" flush="true" >
 <jsp:param name="category" value="<%=category%>"/>
 <jsp:param name="subcategory" value="<%=subcategory%>"/>
 <jsp:param name="sortByPrice" value="false"/>
 <jsp:param name="filterByBrand" value="false"/>
</jsp:include>
<%}%>

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
          <h3> Product Category --> <%=category%> --> <%=subcategory%> </h3>
          <%if(productListValue=="true"){%>

          <br>
            <form name="sortSelect">
            <h4 style="text-transform:none"> Sort by Price:
            <select name="sortByPrice" onchange="sortSelectAction()">
                                        <option value="false">Select</option>
                                        <option value="desc">High to Low</option>
                                        <option value="asc">Low to High</option>
                                      </select> </h4>
            <input type="hidden" name="category" value="<%=category%>">
            <input type="hidden" name="subcategory" value="<%=subcategory%>">
            <input type="hidden" name="filterByBrand" value="false">
            </form>
            <br>


              <%List distinctBrand=(List)request.getAttribute("distinctBrand");%>
              <form name="filterBrand">
              <h4 style="text-transform:none">Filter By Brand:
                <select name="filterByBrand" onchange="filterSelectAction()">
                  <option value="false">Select</option>
              <%for(int j=0;j<distinctBrand.size();j++){%>
                <option value="<%=distinctBrand.get(j)%>"> <%=distinctBrand.get(j)%> </option>
              <%}%>
            </select> </h4>
            <input type="hidden" name="category" value="<%=category%>">
            <input type="hidden" name="subcategory" value="<%=subcategory%>">
            <input type="hidden" name="sortByPrice" value="false">
          </form>
          <br>

          <%ArrayList<productBean> productdata = new ArrayList();%>
          	  <%productdata = (ArrayList<productBean>)request.getAttribute("productdata");%>
          <ul>
		     <%for(int i=0;i<productdata.size();i++){
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
          <br>
          <h2>No products found in this category. Please check back later. </h2>
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
