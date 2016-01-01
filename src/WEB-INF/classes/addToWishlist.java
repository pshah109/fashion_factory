import javax.servlet.http.*;
import javax.servlet.*;
import com.mongodb.*;
import java.io.*;

public class addToWishlist extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

int productID=Integer.parseInt(request.getParameter("productID"));
int productPrice=Integer.parseInt(request.getParameter("productPrice"));
String productName=request.getParameter("productName");
String productBrand=request.getParameter("productBrand");

HttpSession session = request.getSession();
String userEmail=(String)session.getAttribute("userEmail");

String wishlistLoginValue="false";
String addToWishlistValue="false";
String dupWishlistProd="false";

if(userEmail==null){

request.setAttribute("wishlistLoginValue",wishlistLoginValue);
request.setAttribute("addToWishlistValue",addToWishlistValue);

String redirectURL = String.format("viewProduct.jsp?productID=%s",productID);

RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
rd.forward(request,response);

} else if (userEmail!=null){

  MongoClient mongo = new MongoClient( "localhost", 27017 );
  DB db = mongo.getDB("FashionFactoryProd");
  DBCollection myWishlist = db.getCollection("custWishlist");

  BasicDBObject document=new BasicDBObject();
  BasicDBObject searchQuery=new BasicDBObject();
  searchQuery.put("userEmail",userEmail);
  searchQuery.put("productID",productID);
  DBCursor cursor=myWishlist.find(searchQuery);
  if(cursor.size()>0){
    wishlistLoginValue="true";
    dupWishlistProd="true";
    request.setAttribute("wishlistLoginValue",wishlistLoginValue);
    request.setAttribute("addToWishlistValue",addToWishlistValue);
    request.setAttribute("dupWishlistProd",dupWishlistProd);

    String redirectURL = String.format("viewProduct.jsp?productID=%s",productID);

    RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
    rd.forward(request,response);
  } else {

  BasicDBObject doc = new BasicDBObject("title", "myWishlist").append("productID", productID)
      .append("productName", productName).append("userEmail", userEmail)
      .append("productPrice",productPrice).append("productBrand", productBrand);

      myWishlist.insert(doc);

      addToWishlistValue="true";
      wishlistLoginValue="true";

      request.setAttribute("addToWishlistValue",addToWishlistValue);
      request.setAttribute("wishlistLoginValue",wishlistLoginValue);
      request.setAttribute("dupWishlistProd",dupWishlistProd);

      String redirectURL = String.format("viewProduct.jsp?productID=%s",productID);

      RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
      rd.forward(request,response);

    }

}

}

}
