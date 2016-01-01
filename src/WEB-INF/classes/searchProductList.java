import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import product.*;
import com.mongodb.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class searchProductList extends HttpServlet {

MongoClient mongo;

public void init() throws ServletException {
								mongo = new MongoClient("localhost", 27017);
}

public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

								String category=request.getParameter("category");
								String subcategory=request.getParameter("subcategory");
                String searchText=request.getParameter("searchText");
                String productListValue="false";

								DB db = mongo.getDB("FashionFactoryProd");
								DBCollection myProducts = db.getCollection("productInfo");

								DBCursor cursor = null;

								BasicDBObject searchQuery = new BasicDBObject();
								searchQuery.put("productCategory", category);
                searchQuery.put("productName", java.util.regex.Pattern.compile(searchText,Pattern.CASE_INSENSITIVE));


							cursor = myProducts.find(searchQuery);

								ArrayList<productBean> productdata = new ArrayList();

								if(cursor.count() == 0) {
									request.setAttribute("productListValue",productListValue);
								}

								while (cursor.hasNext()) {
																BasicDBObject obj = (BasicDBObject) cursor.next();
																productBean productInfo = new productBean ();
																productInfo.setProductID(Integer.parseInt(obj.getString("productID")));
																productInfo.setProductCategory(obj.getString("productCategory"));
																productInfo.setProductSubCategory(obj.getString("productSubCategory"));
																productInfo.setProductName(obj.getString("productName"));
																productInfo.setProductPrice(Integer.parseInt(obj.getString("productPrice")));
																productInfo.setProductBrand(obj.getString("productBrand"));
																productInfo.setOfferPrice(Integer.parseInt(obj.getString("offerPrice")));
																productInfo.setDiscountPercent(Integer.parseInt(obj.getString("discountPercent")));
																productdata.add(productInfo);
															}

								if(cursor.count()>0){
									productListValue="true";
									request.setAttribute("productListValue",productListValue);
								  request.setAttribute("productdata", productdata);
									}


								}



}
