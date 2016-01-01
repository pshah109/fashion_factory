import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.*;
import java.text.*;
import order.*;

public class fetchOrders extends HttpServlet {
MongoClient mongo;

public void init() throws ServletException{
		mongo = new MongoClient("localhost", 27017);
}

public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {


				String useremail=request.getParameter("useremail");
				String searchField = "useremail";
				DB db = mongo.getDB("FashionFactoryProd");
				DBCollection myReviews = db.getCollection("myOrders");
				BasicDBObject searchQuery = new BasicDBObject();
				searchQuery.put(searchField,useremail);
				DBCursor cursor = myReviews.find(searchQuery);


				ArrayList<orderInfo> orderdata = new ArrayList();


				while (cursor.hasNext())
								{
								BasicDBObject obj = (BasicDBObject) cursor.next();
								orderInfo  orderbean = new orderInfo();
								orderbean.setUserID(obj.getString("useremail"));
								orderbean.setOrderNumber(obj.getString("ordernum"));
								orderbean.setProductModel(obj.getString("model"));
								orderbean.setProductID(obj.getInt("productid"));
								orderbean.setProductSize(obj.getString("size"));
								orderbean.setProductPrice(obj.getInt("price"));
								orderbean.setProductQuantity(obj.getInt("quantity"));
								orderbean.setDeliveryDate(obj.getDate("deliverydate"));
								orderbean.setShippingAddress(obj.getString("shippingaddress"));
								orderdata.add(orderbean);
								}
								request.setAttribute("orderdata", orderdata);

                }

}
