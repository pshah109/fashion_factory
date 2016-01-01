import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import product.*;
import com.mongodb.*;

public class productList extends HttpServlet {

MongoClient mongo;

public void init() throws ServletException {
								mongo = new MongoClient("localhost", 27017);
}

public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

								String category=request.getParameter("category");
								String subcategory=request.getParameter("subcategory");
								String productListValue="false";
								String redirectURLValue="false";
								String sortByPrice=request.getParameter("sortByPrice");
								String filterByBrand=request.getParameter("filterByBrand");

								DB db = mongo.getDB("FashionFactoryProd");
								DBCollection myProducts = db.getCollection("productInfo");

								DBCursor cursor = null;
								DBObject sort = new BasicDBObject();

								// get distinct value of brand
								List distinctBrand = null;
								DBObject whereBrand = new BasicDBObject();
								whereBrand.put("productCategory",category);
								whereBrand.put("productSubCategory",subcategory);
								distinctBrand=myProducts.distinct("productBrand",whereBrand);

								BasicDBObject searchQuery = new BasicDBObject();
								searchQuery.put("productCategory", category);
								searchQuery.put("productSubCategory", subcategory);

								if(sortByPrice.equals("desc")){
								sort.put("productPrice",-1);
								cursor = myProducts.find(searchQuery).sort(sort);
								} else if(sortByPrice.equals("asc")){
								sort.put("productPrice",1);
								cursor = myProducts.find(searchQuery).sort(sort);
								}else if (!filterByBrand.equals("false")) {
								searchQuery.put("productBrand", filterByBrand);
								cursor = myProducts.find(searchQuery);
								} else if(sortByPrice.equals("false") && filterByBrand.equals("false")) {
								cursor = myProducts.find(searchQuery);
								}

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

									if(sortByPrice.equals("false") && filterByBrand.equals("false") ){
									productListValue="true";
									request.setAttribute("productListValue",productListValue);
								  request.setAttribute("productdata", productdata);
									request.setAttribute("distinctBrand",distinctBrand);
									} else if(!sortByPrice.equals("false")){
									redirectURLValue="true";
									productListValue="true";
									request.setAttribute("productListValue",productListValue);
								  request.setAttribute("productdata", productdata);
									request.setAttribute("redirectURLValue", redirectURLValue);
									request.setAttribute("distinctBrand",distinctBrand);

									String redirectURL = String.format("productCatalog.jsp?category=%s&subcategory=%s",category,subcategory);

							    RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
							    rd.forward(request,response);
									} else if(!filterByBrand.equals("false")){
									redirectURLValue="true";
									productListValue="true";
									request.setAttribute("productListValue",productListValue);
								  request.setAttribute("productdata", productdata);
									request.setAttribute("redirectURLValue", redirectURLValue);
									request.setAttribute("distinctBrand",distinctBrand);

									String redirectURL = String.format("productCatalog.jsp?category=%s&subcategory=%s",category,subcategory);

							    RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
							    rd.forward(request,response);

									}


								}


}

}
