<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Write Review</title>
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
          <%int productID=Integer.parseInt(request.getParameter("productID"));%>

          <jsp:include page="getProductInfo" flush="true">
            <jsp:param name="productID" value="<%=productID%>"/>
          </jsp:include>

          <%try{
          productBean productInfo = null;
          productInfo = (productBean)request.getAttribute("singleProductInfo");%>
          <br>
              <h2 align="center"> Write Review </h2>
          <table>
            <tr>
              <td width = '160' height = '160'>
                <a href="viewProduct.jsp?productID=<%=productInfo.getProductID()%>">
                <img style="margin:30px" src="css/images/img_<%=productInfo.getProductID()%>.jpg" width = '130' height = '150' />
              </a>
              </td>
              <td valign="top">
                <br>
                  <br>
                    <br>
                      Product Catgory:
                      <h3>
                      <%= productInfo.getProductCategory()%>
                      <%= productInfo.getProductSubCategory()%>
                    </h3>
                  <br>
                  <h2 style="text-transform:none"> <%= productInfo.getProductName()%> By <%= productInfo.getProductBrand()%> </h2>
                  <br>
                  <%if(productInfo.getDiscountPercent()>0){%>
                <h1 style="text-transform:none">
                Offer Price: $<%=productInfo.getOfferPrice()%></h1>
                <br>
                <h2 style="text-transform:none">Get Flat Discount: <%=productInfo.getDiscountPercent()%>%</h2>
                <%}else{%>
                    <h1 style="text-transform:none">Price: $<%=productInfo.getProductPrice()%></h1>
                <%}%>
                  <br>
                </td>
              </tr>
          </table>
          <% if (checkLogin==null) { %>
          <br>
          <h2>Please login to Write Review.</h2>
          <%} else if (checkLogin!=null ){
            String submitReviewValue="";
            submitReviewValue = (String)request.getAttribute("submitReviewValue");
          %>

          <%if(submitReviewValue=="true"){%>
            <h2> Review submitted sucessfully.</h2>
            <br>
            <h2> Thanks for the feedback.</h2>
          <%}%>

          <%if(submitReviewValue=="fasle" || submitReviewValue==null ){%>
          <fieldset>
            <legend style="padding:5px"><h2>Write Review For Product: </h2> </legend>
          <table>
            <%Date today = new Date();
            long todaymili = today.getTime();
            DateFormat formatdate = new SimpleDateFormat("MM/dd/yyyy");
            String reviewDate = formatdate.format(today);%>

            <form action="submitReview">
              <tr>
                <td>User ID:</td>
								<td><input type = 'text' name = 'firstName' value="<%=checkLogin%>" readonly /> </td>
							</tr>

              <tr>
                <td>Review Rating:</td>
                <td><select name='reviewRating'><option value='1'>1</option>
                <option value='2'>2</option>
                <option value='3'>3</option>
                <option value='4'>4</option>
                <option value='5' selected>5</option>
              </td>
              </tr>

              <tr>
							  <td>Review Date:</td>
					           <td><input type = 'text' name = 'reviewDate' value="<%=reviewDate%>" readonly /> </td>
              </tr>

              <tr>
              	  <td>Review Text:</td>
                    <td><textarea name='reviewText' rows='10' cols='70'> </textarea></td>
              </tr>

              <tr>
                <td>Submit the Review:</td>
                <td><h3><input type="submit" class="search-submit" value="Submit"></h3></td>
                <td><input type = 'hidden' name='productName' value="<%= productInfo.getProductName()%>"> </td>
                <td><input type = 'hidden' name='productID' value="<%= productInfo.getProductID()%>"> </td>
             </tr>
            </form>
          </table>
        </fieldset>
          <%}%>
         <%}%>
          <%}catch(Exception e){
          e.printStackTrace();
          }%>

        </div>

    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

      </div> <!-- end Main-->

  <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
  </div>
  <!-- End Shell -->
</body>

</html>
