<!-- Header -->
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.*"%>
<%@ page import="shoppingCart.*"%>
<div id="header">
  <h1 id="logo"><a href="index.jsp">fashionfactory</a></h1>
  <!-- Navigation -->
  <div id="navigation">
    <ul>
      <li><a href="index.jsp">Home</a></li>

      <%String checkLogin = (String)session.getAttribute("loginName");
      String userRole = (String)session.getAttribute("userRole");
      String userEmail = (String)session.getAttribute("userEmail");%>

<%if(checkLogin==null || userRole==null ) {%>
              <li><a href="trendingOffers.jsp">Offers</a></li>
              <li><a href="trendingProducts.jsp"> Trending Products</a></li>
              <li><a href="trackOrder.jsp">Track Order</a></li>
              <li><a href="login.jsp">Login/Register</a></li>
              <%session.setAttribute("userRole","Guest");%>
<%}else if(userRole.equals("Customer"))  {%>
              <li><a href="trendingOffers.jsp">Offers</a></li>
              <li><a href="trendingProducts.jsp">Trending Products</a></li>
              <li><a> Hello  <%=checkLogin%> </a> </li>
              <li><a href="myWishlist.jsp">My WishList</a></li>
              <li><a href="myOrders.jsp">My Order</a></li>
              <li><a href="logout.jsp">Logout</a></li>
<%}else if(userRole.equals("Seller"))  {%>
                <li><a> Hello <%=checkLogin%> </a> </li>
                <li><a href="addProduct.jsp">Add Product</a></li>
                <li><a href="updateProductMain.jsp">Update Product</a></li>
                <li><a href="viewInventory.jsp">View & Update Inventory</a></li>
                <li><a href="logout.jsp">Logout</a></li>
<%}else if(userRole.equals("StoreManager"))  {%>
                <li><a> Hello <%=checkLogin%> </a> </li>
                <li><a href="updateProductMain.jsp">Update Product Offer</a></li>
                <li><a href="deleteProduct.jsp">Delete Product</a></li>
                <li><a href="viewInventory.jsp">View Inventory</a></li>
                <li><a href="logout.jsp">Logout</a></li>
<%}%>

<% int cartCount=0;
int cartPrice=0;
cart ekartCount;
ekartCount = (cart) session.getAttribute("cart");
if(ekartCount==null){
  cartCount=0;
} else{
  ArrayList<productBean> ItemsCount= ekartCount.getCartItems();
  if(ItemsCount.isEmpty()){
    cartCount=0;
    cartPrice=0;
  } else {
  cartCount=ItemsCount.size();
  for(int i=0; i<ItemsCount.size();i++) {
  productBean productData = (productBean)ItemsCount.get(i);
  cartPrice+=productData.getProductPrice()*productData.getProductPurchaseQuantity();
  }
}
}
%>
<%if(checkLogin==null || userRole==null || userRole.equals("Customer") ) {%>
      <li>
        <a href="viewCart.jsp">
            <font size="1">Total </font> $<%=cartPrice%>
          <img src="css/images/cart-link.png" height="50px" width="60px">
              <%=cartCount%>
        </a>
      </li>
      <%}%>
    </ul>
  </div>
  <!-- End Navigation -->
</div>
<!-- End Header -->
