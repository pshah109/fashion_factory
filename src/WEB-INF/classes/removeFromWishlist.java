import javax.servlet.http.*;
import javax.servlet.*;
import com.mongodb.*;
import java.io.*;

public class removeFromWishlist extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

int productID=Integer.parseInt(request.getParameter("productID"));

HttpSession session = request.getSession();
String userEmail=(String)session.getAttribute("userEmail");

String removeFromWishlistValue="false";
String wishlistEmptyValue="false";

  MongoClient mongo = new MongoClient( "localhost", 27017 );
  DB db = mongo.getDB("FashionFactoryProd");
  DBCollection myWishlist = db.getCollection("custWishlist");

  BasicDBObject searchQuery=new BasicDBObject();
  searchQuery.put("userEmail",userEmail);

  DBCursor cursor=myWishlist.find(searchQuery);

  if(cursor.size()==0){
    wishlistEmptyValue="true";

    request.setAttribute("wishlistEmptyValue",wishlistEmptyValue);

    String redirectURL = String.format("myWishlist.jsp");

    RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
    rd.forward(request,response);
  } else if (cursor.size()>0) {

    searchQuery.put("productID",productID);

    myWishlist.remove(searchQuery);

    removeFromWishlistValue="true";

    request.setAttribute("removeFromWishlistValue",removeFromWishlistValue);

    String redirectURL = String.format("myWishlist.jsp");

    RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
    rd.forward(request,response);
  }



}
}
