import java.util.ArrayList;
import java.util.List;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import product.*;
import com.mongodb.*;

public class getWishlist extends HttpServlet {

MongoClient mongo;

public void init() throws ServletException {
								mongo = new MongoClient("localhost", 27017);
}

public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

								String userEmail=request.getParameter("userEmail");

                String getWishlistValue="false";

								DB db = mongo.getDB("FashionFactoryProd");
								DBCollection myWishlist = db.getCollection("custWishlist");
								BasicDBObject searchQuery = new BasicDBObject();
								searchQuery.put("userEmail", userEmail);

								DBCursor cursor = myWishlist.find(searchQuery);

								ArrayList<productBean> wishlistdata = new ArrayList();

								if(cursor.count() == 0) {
									request.setAttribute("getWishlistValue",getWishlistValue);
								}

								while (cursor.hasNext()) {
																BasicDBObject obj = (BasicDBObject) cursor.next();
																productBean wishlistInfo = new productBean ();
																wishlistInfo.setProductID(Integer.parseInt(obj.getString("productID")));
																wishlistInfo.setProductName(obj.getString("productName"));
																wishlistInfo.setProductPrice(Integer.parseInt(obj.getString("productPrice")));
																wishlistInfo.setProductBrand(obj.getString("productBrand"));
																wishlistdata.add(wishlistInfo);
															}

								if(cursor.count()>0){
									getWishlistValue="true";
									request.setAttribute("getWishlistValue",getWishlistValue);
								  request.setAttribute("wishlistdata", wishlistdata);
								}

}

}
