<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="product.*"%>
<head>
  <title>Update Product</title>
  <link rel="icon" type="image/png" href="css/images/favicon-16x16.png" sizes="16x16" />
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
  <script type="text/javascript" src="js/searchProduct.js"></script>
</head>

<body onload="init()">
  <!-- Shell -->
  <div class="shell">
 <%@include file="global/header.jsp" %>  <!-- include from global -->

 <div id="main">
      <div class="cl">&nbsp;</div>
      <!-- Content -->
      <div id="content" >
        <br>

        <%-- Get productID from URL and pass it to Servlet --%>
        <%int productID=Integer.parseInt(request.getParameter("productID"));%>

        <jsp:include page="getSellerProductInfo" flush="true">
          <jsp:param name="productID" value="<%=productID%>"/>
        </jsp:include>

        <%
        String singleProductInfoValue="";
        singleProductInfoValue=(String)request.getAttribute("singleProductInfoValue");
        %>

        <% String updateProductValue="";
        updateProductValue = (String)request.getAttribute("updateProductValue"); %>

        <%if(updateProductValue=="true"){%>
          <h2> Product Updated successfully.</h2>
          <br>
        <%}%>

    <h2 style="padding-bottom:10px;"> Update Product Form <span style="color:green; float:right"></span></h2>

    <%if(singleProductInfoValue=="false"){%>
      <br>
      <br>
       <h2>No product found with this ID. Please search again.</h2>
       <br>
       <br>
               <form  action="updateProduct.jsp">
               <h2><b>To view & update product, please enter the ProductID:</b> </h2>
               <br>
               <input type="number" name="productID" min='1' max='9999' required/>
               <br/> <input type="submit" value="View & Update" class="search-submit"/>
               </form>
    <%} else if (singleProductInfoValue=="true"){
      productBean productInfo = null;
    productInfo = (productBean)request.getAttribute("singleProductInfo");
    %>

				<form action="updateProduct">
				<table>
                            <tr>
                                <td> Product ID: </td>
                                <td><input type="text" name="productID" value = "<%=productInfo.getProductID()%>" readonly/> </td>
                            </tr>
							                     <tr>
                                <td> Product Category: </td>
                                <td>
                                    <select name="productCategory">
                                     <option value="<%=productInfo.getProductCategory()%>"><%=productInfo.getProductCategory()%></option>

                                </td>
                            </tr>

							<tr>
                                <td> Product Subcategory: </td>
                                <td>
                                    <select name="productSubCategory">
                                     <option value="<%=productInfo.getProductSubCategory()%>"><%=productInfo.getProductSubCategory()%></option>
								</td>
                            </tr>
                                <tr>
                                <td> Product Name: </td>
                                <td>
                                    <input type="text" name="productName" value="<%=productInfo.getProductName()%>" required/> </td>
                            </tr>

							<tr>
                                <td> Product Price: </td>
                                <td>
                                    <input type="number" name="productPrice" value="<%=productInfo.getProductPrice()%>" size=4 /> </td>
                            </tr>

                              <%if(userRole.equals("Seller")){%>
							                  <tr>
                                <td> Product On Sale: (View Only) </td>
                                <td>
                                    <% String ProductOnSale= productInfo.getProductOnSale();
                                    if(ProductOnSale.equalsIgnoreCase("No")) { %>
                                        <input type="radio" name="productOnSale" value="No" checked  readonly/> No
                                    <% } else {%>
                                    <input type="radio" name="productOnSale" value="Yes" checked readonly /> Yes
                                    <%}%>
                                    </td>
                                  </tr>
							                  <tr>
                                <td> Discount: (View Only) </td>
                                <td>
                                    <input type="text" name="discountPercent" style="width:20px" value="<%=productInfo.getDiscountPercent()%>" readonly/> % </td>
                                </tr>
                                <%} else if (userRole.equals("StoreManager")){%>
                                  <tr>
                                  <td> Product On Sale: </td>
                                  <td>
                                      <% String ProductOnSale= productInfo.getProductOnSale();
                                      if(ProductOnSale.equalsIgnoreCase("No")) { %>
                                          <input type="radio" name="productOnSale" value="Yes"  /> Yes
                                          <input type="radio" name="productOnSale" value="No" checked /> No</td>
                                      <% } else {%>
                                      <input type="radio" name="productOnSale" value="Yes" checked  /> Yes
                                      <input type="radio" name="productOnSale" value="No"  /> No</td>
                                      <%}%>
                                    </tr>
  							                  <tr>
                                  <td> Discount: </td>
                                  <td>
                                      <input type="text" name="discountPercent" style="width:20px" value="<%=productInfo.getDiscountPercent()%>"/> % </td>
                                  </tr>
                                  <%}%>

							                  <tr>
                                <td> Product Brand: </td>
                                <td>
                                <input type="text" name="productBrand" value="<%=productInfo.getProductBrand()%>" required /> </td>
                                </tr>

							                     <tr>
                                <td> Product Quantity S: </td>
                                <td>
                                  <%if(userRole.equals("Seller")){%>
                                  <input type="number" name="productQuantityS" value = "<%=productInfo.getProductQuantityS()%>" required />
                                  <%} else if (userRole.equals("StoreManager")){%>
                                  <input type="number" name="productQuantityS" value = "<%=productInfo.getProductQuantityS()%>" readonly />
                                  <%}%>
                                </td>
                                </tr>

							<tr>
                                <td> Product Quantity M: </td>
                                <td>
                                  <%if(userRole.equals("Seller")){%>
                                  <input type="number" name="productQuantityM" value = "<%=productInfo.getProductQuantityM()%>" required />
                                  <%} else if (userRole.equals("StoreManager")){%>
                                  <input type="number" name="productQuantityM" value = "<%=productInfo.getProductQuantityM()%>" readonly />
                                  <%}%>
                                </td>
                                </tr>

							<tr>
                                <td> Product Quantity L: </td>
                                <td>
                                  <%if(userRole.equals("Seller")){%>
                                  <input type="number" name="productQuantityL" value = "<%=productInfo.getProductQuantityL()%>" required />
                                  <%} else if (userRole.equals("StoreManager")){%>
                                  <input type="number" name="productQuantityL" value = "<%=productInfo.getProductQuantityL()%>" readonly />
                                  <%}%>
                                </td>
                                </tr>

							<tr>
                                <td> Product Quantity XL: </td>
                                <td>
                                  <%if(userRole.equals("Seller")){%>
                                  <input type="number" name="productQuantityXL" value = "<%=productInfo.getProductQuantityXL()%>" required />
                                  <%} else if (userRole.equals("StoreManager")){%>
                                  <input type="number" name="productQuantityXL" value = "<%=productInfo.getProductQuantityXL()%>" readonly />
                                  <%}%>
                                </td>
                                </tr>

							<tr>
                                <td> Product Description: </td>
                                <td>
                                    <input type="text" name="productDescription" value ="<%=productInfo.getProductDescription()%>" rows="4" cols="20" required> </textarea>
                                </td>
                            </tr>

							<tr>
                                <td> Product Material: </td>
                                <td>
                                    <input type="text" name="productMaterial" value="<%=productInfo.getProductMaterial()%>" required /> </td>
                            </tr>

							<tr>
                                <td>  </td>
                                <td>
                                    <input type="submit" class="search-submit" name="Submit" value= "Update Product" /> </td>
                            </tr>

			    </table>
				</form>

        <%}%>


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
