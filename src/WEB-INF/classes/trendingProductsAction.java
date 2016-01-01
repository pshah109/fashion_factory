import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import product.*;
import com.mongodb.*;

public class trendingProductsAction extends HttpServlet {

MongoClient mongo;

public void init() throws ServletException {
								mongo = new MongoClient("localhost", 27017);
}

public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {


								String productListValue="false";

								DB db = mongo.getDB("FashionFactoryProd");
								DBCollection trendingProducts = db.getCollection("myTrending");

								DBCollection myProducts = db.getCollection("productInfo");
								BasicDBObject searchQueryProducts = new BasicDBObject();


								DBObject sort = new BasicDBObject();

									int returnLimit = 6;
									sort.put("count",-1);
									DBCursor cursorID = trendingProducts.find().sort(sort).limit(returnLimit);

								ArrayList<productBean> productdata = new ArrayList();
								ArrayList<Integer> list = new ArrayList<Integer>();

								while(cursorID.hasNext()){
									BasicDBObject objTrending = (BasicDBObject) cursorID.next();
									int productIDFind=Integer.parseInt(objTrending.getString("productID"));
									list.add(productIDFind);
								}
								searchQueryProducts.put("productID",new BasicDBObject("$in", list));

									DBCursor cursor= myProducts.find(searchQueryProducts);

									if(cursor.count() == 0) {
									request.setAttribute("productListValue",productListValue);
									}

									while (cursor.hasNext())
										{
											BasicDBObject obj = (BasicDBObject) cursor.next();
											productBean productInfo = new productBean ();
											productInfo.setProductID(Integer.parseInt(obj.getString("productID")));
											productInfo.setProductCategory(obj.getString("productCategory"));
											productInfo.setProductSubCategory(obj.getString("productSubCategory"));
											productInfo.setProductName(obj.getString("productName"));
											productInfo.setProductPrice(Integer.parseInt(obj.getString("productPrice")));
											productInfo.setProductBrand(obj.getString("productBrand"));
											productInfo.setOfferPrice(obj.getInt("offerPrice"));
											productInfo.setDiscountPercent(obj.getInt("discountPercent"));
											productdata.add(productInfo);
										}

								if(cursor.count()>0){
									productListValue="true";
									request.setAttribute("productListValue",productListValue);
								  request.setAttribute("productdata", productdata);
								}

}

}
