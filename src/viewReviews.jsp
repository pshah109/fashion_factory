<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="review.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>

<head>
  <title>View Reviews</title>
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
          <br>
<%int productID=Integer.parseInt(request.getParameter("productID"));
String accessType=request.getParameter("accessType");%>

<jsp:include page="getProductInfo" flush="true">
  <jsp:param name="productID" value="<%=productID%>"/>
</jsp:include>

<jsp:include page="getReviews">
  <jsp:param name="productID" value="<%=productID%>"/>
  <jsp:param name="accessType" value="All"/>
</jsp:include>

<%
ArrayList<reviewInfoBean> viewReview = new ArrayList();
String viewReviewValue = (String)request.getAttribute("viewReviewValue");
viewReview = (ArrayList<reviewInfoBean>)request.getAttribute("viewReviews");

productBean productInfo = null;
productInfo = (productBean)request.getAttribute("singleProductInfo");%>

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

<%if(viewReviewValue=="false"){%>
                           <h4> No review found for Product </h4>
                           <br>
                           <h4>Be the first to write a review for the product now!!! </h4>
                           <%} else if (viewReviewValue=="true") {%>
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
                         <%}%>

                       </div>

                   <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

                     </div> <!-- end Main-->

                 <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
                 </div>
                 <!-- End Shell -->
               </body>

               </html>
