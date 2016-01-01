<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <title>Delete Product</title>
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
        <% String deleteProductValue="";
        deleteProductValue = (String)request.getAttribute("deleteProductValue"); %>

        <%if(deleteProductValue=="true"){%>
          <h2> Product Deleted successfully.</h2>
            <%deleteProductValue="false";
           request.setAttribute("deleteProductValue",deleteProductValue);
        } else if (deleteProductValue=="false") { %>
            <h2> No Product Found with this ID Please provide valid product ID!!</h2>
       <%}%>

       <br>
        <form  method ="post" action="deleteProduct">
        <h2><b>To delete product, please enter the ProductID:</b> </h2>
        <br>
        Caution : product will get deleted from DB
        <br>
        <br>    
        <input type="number" name="productID" min='1' max='9999' required/>
        <br>
        <input type="submit" value="Delete" class="search-submit" />
        </form>


      </div>

    <%@include file="global/sidebar.jsp"%>     <!-- include from gloabl of sidebar before end main -->

    </div> <!-- end Main-->

    <%@include file="global/footer.jsp"%>     <!-- include from gloabl of footer before end shell -->
    </div>
    <!-- End Shell -->
    </body>

    </html>
