import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import product.*;
import java.util.ArrayList;
import java.util.List;

public class viewInventory extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

  MongoClient mongo = new MongoClient("localhost", 27017);

  try{

    HttpSession session = request.getSession();
    String sellerName = (String)session.getAttribute("userEmail");
    String userRole = (String)session.getAttribute("userRole");

    DB db = mongo.getDB("FashionFactoryProd");
    DBCollection myProducts = db.getCollection("productInfo");
    DBCursor cursor =null;
    String productListValue="false";

    BasicDBObject query = new BasicDBObject();
    query.put("sellerName",sellerName);

    DBObject sort = new BasicDBObject();
    sort.put("productTotalQuantity",1);

    if(userRole.equals("Seller")){
     cursor = myProducts.find(query).sort(sort);
    } else if(userRole.equals("StoreManager")) {
    cursor = myProducts.find().sort(sort);
    }

    ArrayList<productBean> productdata = new ArrayList();

    if(cursor.count() == 0) {
      request.setAttribute("productListValue",productListValue);
    }

    while (cursor.hasNext()) {
                    BasicDBObject obj = (BasicDBObject) cursor.next();
                    productBean productInfo = new productBean ();
              			productInfo.setProductID(obj.getInt("productID"));
                    productInfo.setProductName(obj.getString("productName"));
                    productInfo.setProductBrand(obj.getString("productBrand"));
                    productInfo.setProductQuantityS(obj.getInt("productQuantityS"));
                    productInfo.setProductQuantityM(obj.getInt("productQuantityM"));
                    productInfo.setProductQuantityL(obj.getInt("productQuantityL"));
                    productInfo.setProductQuantityXL(obj.getInt("productQuantityXL"));
                    productInfo.setProductTotalQuantity(obj.getInt("productTotalQuantity"));
                    productdata.add(productInfo);
                  }

                  	if(cursor.count()>0){
                      productListValue="true";
                      request.setAttribute("productListValue",productListValue);
                      request.setAttribute("productdata", productdata);
                    }

} catch(Exception e){
  e.printStackTrace();
}

}

}
