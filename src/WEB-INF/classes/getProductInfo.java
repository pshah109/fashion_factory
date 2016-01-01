import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import product.*;

public class getProductInfo extends HttpServlet {

MongoClient mongo;

public void init() throws ServletException {
								mongo = new MongoClient("localhost", 27017);
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

  try{

		String singleProductInfoValue="false";

  int productID=Integer.parseInt(request.getParameter("productID"));  // get ID of product from jsp

  productBean productInfo = new productBean(); // bean to set values after fetching from DB

  DB db = mongo.getDB("FashionFactoryProd");
  DBCollection productInfoCol = db.getCollection("productInfo");
  BasicDBObject query = new BasicDBObject();
  query.put("productID",productID);
  DBCursor dbCursor = productInfoCol.find(query);

  while (dbCursor.hasNext()) {
			BasicDBObject obj = (BasicDBObject) dbCursor.next();
			productInfo.setProductID(obj.getInt("productID"));
      productInfo.setProductName(obj.getString("productName"));
      productInfo.setProductCategory(obj.getString("productCategory"));
      productInfo.setProductSubCategory(obj.getString("productSubCategory"));
      productInfo.setProductPrice(obj.getInt("productPrice"));
      productInfo.setProductOnSale(obj.getString("productOnSale"));
      productInfo.setProductBrand(obj.getString("productBrand"));
      productInfo.setProductQuantityS(obj.getInt("productQuantityS"));
      productInfo.setProductQuantityM(obj.getInt("productQuantityM"));
      productInfo.setProductQuantityL(obj.getInt("productQuantityL"));
      productInfo.setProductQuantityXL(obj.getInt("productQuantityXL"));
      productInfo.setProductTotalQuantity(obj.getInt("productTotalQuantity"));
      productInfo.setProductDescription(obj.getString("productDescription"));
      productInfo.setProductMaterial(obj.getString("productMaterial"));
			productInfo.setOfferPrice(Integer.parseInt(obj.getString("offerPrice")));
			productInfo.setDiscountPercent(Integer.parseInt(obj.getString("discountPercent")));
  }

	if(dbCursor.size()>0){
		singleProductInfoValue="true";
  request.setAttribute("singleProductInfo", productInfo);
	}

	  request.setAttribute("singleProductInfoValue", singleProductInfoValue);

} catch(Exception e){
  e.printStackTrace();
}

}

}
