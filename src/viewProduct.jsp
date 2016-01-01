<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="product.*"%>
<%@ page import="review.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<% productBean productInfo = null;%>
<html>
<head>
  <title>View Product</title>
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
          <%-- Get productID from URL and pass it to Servlet --%>
          <%int productID=Integer.parseInt(request.getParameter("productID"));%>

          <jsp:include page="getProductInfo" flush="true">
            <jsp:param name="productID" value="<%=productID%>"/>
          </jsp:include>

          <%
          String wishlistLoginValue="";
          wishlistLoginValue=(String)request.getAttribute("wishlistLoginValue");

          String addToWishlistValue="";
          addToWishlistValue=(String)request.getAttribute("addToWishlistValue");

          String dupWishlistProd="";
          dupWishlistProd=(String)request.getAttribute("dupWishlistProd");

          if(wishlistLoginValue=="false"){ %>
            <br>
            <br>
             <h2>Cannot add product to Wishlist. Please login to continue.</h2>
          <%}%>



          <%
          String singleProductInfoValue="";
          singleProductInfoValue=(String)request.getAttribute("singleProductInfoValue");

          if(singleProductInfoValue=="false"){ %>
            <br>
            <br>
             <h2>No product found with this ID. Please search again.</h2>
          <%}

          if(singleProductInfoValue=="true"){
          %>
          <%try{
            Integer cartProductPrice=0;
          productInfo = (productBean)request.getAttribute("singleProductInfo");%>
          <br>
          <table cellspacing="10">
              <tr>
            <td width = '231' height = '300'>
              <a href="viewProduct.jsp?productID=<%=productInfo.getProductID()%>">
              <img src="css/images/img_<%=productInfo.getProductID()%>.jpg" width = '231' height = '300' />
            </a>
              </td>
            <td valign="top">
              <table>
                <tr>
                  <td style="padding-left:10px" >
                  <h1 style="text-transform:none"><%= productInfo.getProductName()%> By <%= productInfo.getProductBrand()%></h1>
                  <br>
                    </td>
                </tr>
                <tr>
                  <td style="padding-left:10px" >
                    <%if(productInfo.getDiscountPercent()>0){%>
                  <h1 style="text-transform:none">Price: $<strike><%=productInfo.getProductPrice()%></strike> &nbsp
                  Offer Price: $<%=productInfo.getOfferPrice()%></h1>
                  <%cartProductPrice=productInfo.getOfferPrice();%>
                  <br>
                  <h2 style="text-transform:none">Get Flat Discount: <%=productInfo.getDiscountPercent()%>%</h2>
                  <%}else{%>
                      <h1 style="text-transform:none">Price: $<%=productInfo.getProductPrice()%></h1>
                      <%cartProductPrice=productInfo.getProductPrice();%>
                  <%}%>
                  <br>
                    </td>
                </tr>
                <tr>
                  <td>
                    Description:<h2 style="text-transform:none"> <%= productInfo.getProductDescription()%> </h2>
                    <br>
                    Product Material:<h2 style="text-transform:none"><%= productInfo.getProductMaterial()%> </h2>
                  </td>
                </tr>
                <form action="addToCart" method="post">
                <tr>
                  <td>
                    <br>
                    <h3 style="text-transform:none">Available Option:</h3>
                    <br>
                    Product Size:<%if((productInfo.getProductQuantityS()>4) || (productInfo.getProductQuantityM()>4) || (productInfo.getProductQuantityL()>4) || (productInfo.getProductQuantityXL()>4)) {%>
                    <select name="productSize">
                      <%if(productInfo.getProductQuantityS()>4){%>
                            <option value="Small">Small</option>
                          <%}%>
                          <%if(productInfo.getProductQuantityM()>4){%>
                                <option value="Medium">Medium</option>
                              <%}%>
                              <%if(productInfo.getProductQuantityL()>4){%>
                                    <option value="Large">Large</option>
                                  <%}%>
                                  <%if(productInfo.getProductQuantityXL()>4){%>
                                        <option value="XLarge">Xlarge</option>

                                      <%}%>
									  </select>
									  <%} else {%>
									  Not Available
									  <%}%>



                  </td>
                </tr>
                <tr>
                  <td>
                    Product Quantity:<%if((productInfo.getProductQuantityS()>4) || (productInfo.getProductQuantityM()>4) || (productInfo.getProductQuantityL()>4) || (productInfo.getProductQuantityXL()>4)) {%>
                    <select name="productQuantity">
                                  <option value="1">1</option>
                                  <option value="2">2</option>
                                  <option value="3">3</option>
                                  <option value="4">4</option>
                                  <option value="5">5</option>
                    </select>
					 <%} else {%>
									  Not Available
									  <%}%>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table>
                      <tr>
                        <td>
                          <% if ( userRole.equals("Seller") || userRole.equals("StoreManager") ){ %>
                      <h3> Login as Customer </h3>
                          <%} else  {
                        if((productInfo.getProductQuantityS()>4) || (productInfo.getProductQuantityM()>4) || (productInfo.getProductQuantityL()>4) || (productInfo.getProductQuantityXL()>4)) {%>
                  <h3><input type="submit" class="search-submit" value="Add to Cart"></h3>
                  <input type='hidden' name='productID' value="<%=productID%>" />
                  <input type='hidden' name='productName' value="<%= productInfo.getProductName()%>" />
                  <input type='hidden' name='productPrice' value="<%= cartProductPrice%>" />
                    <%} else {%>
                      <h3> Out of Stock!!! </h3>
                      <%}%>
                      <%}%>
                </td>
                  </form>
                <td>
                  <% if ( userRole.equals("Seller") || userRole.equals("StoreManager") ){ %>
                    <h2> </h2>
                  <%} else {
                  if(addToWishlistValue=="true" && wishlistLoginValue=="true"){%>
                    <h3>Product added to Wishlist</h3>
                    <%}else if(dupWishlistProd=="true"){%>
                      <h3> Product already in Wishlist </h3>
                    <%}else {%>
                  <form action="addToWishlist">
                  <input type="submit" class="search-submit" value="Add To Wishlist">
                  <input type='hidden' name='productName' value="<%= productInfo.getProductName()%>" />
                  <input type='hidden' name='productID' value="<%=productID%>" />
                  <input type='hidden' name='productPrice' value="<%=productInfo.getProductPrice()%>" />
                  <input type='hidden' name='productBrand' value="<%=productInfo.getProductBrand()%>" />
                </form>
                <%}%>
                <%}%>
                </td>
              </tr>
                </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          </table>
          <%}catch(Exception e){
          e.printStackTrace();
          }%>
          <table>
            <tr>
              <td width = '110' >
                <form action="writeReview.jsp">
                <input type="submit" class="search-submit" value="Write Review">
                <input type="hidden" name="productID" value="<%=productID%>">
                </form>
              </td>

              <td>
                <form action="viewReviews.jsp">
                <input type="submit" class="search-submit" value="Read All Reviews">
                <input type="hidden" name="productID" value="<%=productID%>">
                <input type="hidden" name="accessType" value="All">
              </form>
              </td>
            </tr>
          </table>
          <jsp:include page="getReviews">
            <jsp:param name="productID" value="<%=productID%>"/>
            <jsp:param name="accessType" value="Latest"/>
				 </jsp:include>
         <%
         ArrayList<reviewInfoBean> viewReview = new ArrayList();
         String viewReviewValue = (String)request.getAttribute("viewReviewValue");
         viewReview = (ArrayList<reviewInfoBean>)request.getAttribute("viewReviews");
          %>

         <%if(viewReviewValue=="false"){%>
																		<h4> No review found for <%= productInfo.getProductName()%>  </h4>
                                    <br>
                                    <h4>Be the first to write a review for the product now!!! </h4>
																		<%} else if (viewReviewValue=="true") {%>
                                          <fieldset>
                                            <legend style="padding:5px"><h2>Latest Review For Product: </h2> </legend>
                                                  <table>
																										<tr>
																										<td width = '110' height = '26'><h2> User Name: </h2></td>
																										<td width = '110' height = '26'><h2> Review Rating: </h2></td>
																										<td width = '110' height = '26'><h2> Review Date: </h2></td>
																										<td><h2> Review Text: </h2></td>
																										</tr>
																										<%
																										for (int i=0;i<viewReview.size();i++){
																										reviewInfoBean review = (reviewInfoBean)viewReview.get(i);
                                                    Date reviewDateFetch= review.getReviewDate();
			                                              DateFormat formatdate = new SimpleDateFormat("MM/dd/yyyy");
			                                              String reviewDate = formatdate.format(reviewDateFetch);
																										%>
																																  <tr>
																																  <td align="center"> <%=review.getFirstName()%> </td>
																																  <td align="center"> <%=review.getReviewRating()%> </td>
																																  <td align="center"> <%=reviewDate%> </td>
																																  <td> <%=review.getReviewText()%> </td>
																																  </tr>
																		 <%}%>
																  </table>
                                </fieldset>
																	<%}%>

                                  <%}%> <!--if of singleProductInfoValue -->

        </div>

    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

      </div> <!-- end Main-->

  <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
  </div>
  <!-- End Shell -->
</body>

</html>
