import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import product.*;
import com.mongodb.*;

public class trendingOffersAction extends HttpServlet {

MongoClient mongo;

public void init() throws ServletException {
								mongo = new MongoClient("localhost", 27017);
}

public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


								String productListValue="false";

								DB db = mongo.getDB("FashionFactoryProd");
								DBCollection myProducts = db.getCollection("productInfo");
								BasicDBObject searchQuery = new BasicDBObject();
								DBObject sort = new BasicDBObject();

									searchQuery.put("offerPrice", new BasicDBObject("$ne", 0));
									int returnLimit = 6;
									sort.put("productAddDate",-1);
									DBCursor cursor = myProducts.find(searchQuery).limit(returnLimit).sort(sort);

								ArrayList<productBean> productdata = new ArrayList();

								if(cursor.count() == 0) {
									request.setAttribute("productListValue",productListValue);
								}

								while (cursor.hasNext()) {
																BasicDBObject obj = (BasicDBObject) cursor.next();
																productBean productInfo = new productBean ();
																productInfo.setProductID(obj.getInt("productID")));
																productInfo.setProductCategory(obj.getString("productCategory"));
																productInfo.setProductSubCategory(obj.getString("productSubCategory"));
																productInfo.setProductName(obj.getString("productName"));
																productInfo.setProductPrice(Integer.parseInt(obj.getString("productPrice")));
																productInfo.setProductBrand(obj.getString("productBrand"));
																productdata.add(productInfo);
															}

								if(cursor.count()>0){
									productListValue="true";
									request.setAttribute("productListValue",productListValue);
								  request.setAttribute("productdata", productdata);
								}

}

}
