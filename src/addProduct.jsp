<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<head>
  <title>Add Product</title>
  <link rel="icon" type="image/png" href="css/images/favicon-16x16.png" sizes="16x16" />
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
  <script type="text/javascript" src="js/searchProduct.js"></script>
</head>

<body onload="init()">
  <!-- Shell -->
  <div class="shell">
 <%@include file="global/header.jsp" %>  <!-- include from gloabl -->

 <div id="main">
      <div class="cl">&nbsp;</div>
      <!-- Content -->
      <div id="content" >
        <br>
        <% String addProductValue="";
        addProductValue = (String)request.getAttribute("addProductValue"); %>

        <% String dupProdValue="";
        dupProdValue = (String)request.getAttribute("dupProdValue"); %>

        <%if(dupProdValue=="true"){%>
          <h2> Cannot add product with same productID. Please use another productID </h2>
          <br>
            <%dupProdValue="false";
           request.setAttribute("dupProdValue",dupProdValue);%>
        <%}%>

        <%if(addProductValue=="true"){%>
          <h2> Product Added sucessfully.</h2>
            <%addProductValue="false";
           request.setAttribute("addProductValue",addProductValue);%>
        <%}%>

    <h2 style="padding-bottom:10px;"> Add Product Form <span style="color:green; float:right"></span></h2>

    <%String addProductID = "0";
    addProductID=(String)session.getAttribute("addProductID");%>

    <%String uploadImageValue = "false";
    uploadImageValue=(String)session.getAttribute("uploadImageValue");%>

    <table>
    <%if(uploadImageValue=="true"){%>
      <br>
      <h2> File uploaded sucessfully. Please add more details about the product.</h2>
      <br>
    <%} else {%>
      <br>
      <h2> Please upload the image first - in <b>jpg</b> format ONLY </h2>
    <form action="UploadServlet" method="post" enctype="multipart/form-data">
        <tr>
            <td> Product ID: </td>
            <td>
                <input type="number" name="productID" min="1" max="9999" required/> </td>
        </tr>
        <tr>
            <td> Upload Image : </td>
            <td>
                <input type="file" name="file" size="100" /> </td>
        </tr>
        <tr>
            <td> </td>
            <td>
                <input type="submit" value="Upload Image" class="search-submit" /> </td>
        </tr>
    <br>
    </form>
    <%}%>



				<form method="post" action="addProduct">

          <%if(uploadImageValue=="true"){%>
                            <tr>
                                <td> Product ID: </td>
                                <td>
                                    <input type="number" name="productID" value="<%=addProductID%>" readonly/> </td>
                            </tr>

							                     <tr>
                                <td> Product Category: </td>
                                <td>
                                    <select name="productCategory">
                                        <option value="Men">Menswear</option>
                                        <option value="Women">Womenswear</option>
                                        <option value="Kid">Kidswear</option>
                                </td>
                            </tr>

							<tr>
                                <td> Product Subcategory: </td>
                                <td>
                                    <select name="productSubCategory">
                                        <option value="Top">Tops</option>
                                        <option value="Bottom">Bottoms</option>
                                        <option value="Accessory">Accessories</option>
								                </td>
                            </tr>

							<tr>
                                <td> Product Name: </td>
                                <td>
                                    <input type="text" name="productName"  required/> </td>
                            </tr>

							<tr>
                                <td> Product Price: </td>
                                <td>
                                    $<input type="number" name="productPrice" size=4 min="1" max="9999"/> </td>
                            </tr>

							<tr>
                                <td> Product On Sale: </td>
                                <td>
                                    <input type="radio" name="productOnSale" value="Yes" /> Yes
                                    <input type="radio" name="productOnSale" value="No" checked /> No</td>
                            </tr>
							<tr>
                                <td> Discount: </td>
                                <td>
                                    <input type="text" name="discountPercent" style="width:20px" value="0"/> % </td>
                            </tr>

							<tr>
                                <td> Product Brand: </td>
                                <td>
                                    <input type="text" name="productBrand" required /> </td>
                            </tr>

                            <%Date today = new Date();
                            long todaymili = today.getTime();
                            DateFormat formatdate = new SimpleDateFormat("MM/dd/yyyy");
                            String productAddDate = formatdate.format(today);%>

							<tr>
                                <td> Product Add Date: </td>
                                <td>
                                    <input type="text" name="productAddDate" value="<%=productAddDate%>" readonly/> </td>
                            </tr>

							<tr>
                                <td> Product Quantity S: </td>
                                <td>
                                    <input type="number" name="productQuantityS" value = "0" max="999" min="0" required /> </td>
                            </tr>

							<tr>
                                <td> Product Quantity M: </td>
                                <td>
                                    <input type="number" name="productQuantityM" value = "0" max="999" min="0"   required/> </td>
                            </tr>

							<tr>
                                <td> Product Quantity L: </td>
                                <td>
                                    <input type="number" name="productQuantityL" value = "0" max="999" min="0"   required/> </td>
                            </tr>

							<tr>
                                <td> Product Quantity XL: </td>
                                <td>
                                    <input type="number" name="productQuantityXL" value = "0" max="999" min="0"  required /> </td>
                            </tr>


							<tr>
                                <td> Product Description: </td>
                                <td>
                                    <textarea name="productDescription" rows="4" cols="20" required> </textarea>
                                </td>
                            </tr>

							<tr>
                                <td> Product Material: </td>
                                <td>
                                    <input type="text" name="productMaterial" required /> </td>
                            </tr>

							          <tr>
                                <td>  </td>
                                <td>
                                    <input type="submit" class="search-submit" name="Submit" value= "Submit" /> </td>
                            </tr>


				</form>
      <%}%>
</table>
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
