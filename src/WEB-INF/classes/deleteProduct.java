import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.Date;
import java.text.*;

public class deleteProduct extends HttpServlet {
MongoClient mongo;

public void init() throws ServletException {
        mongo = new MongoClient("localhost", 27017);
}

public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String deleteProductValue="false";

        try {

                // Get the form data
                int productID = Integer.parseInt(request.getParameter("productID"));
                PrintWriter out = response.getWriter();
                DB db = mongo.getDB("FashionFactoryProd");
                DBCollection myProducts = db.getCollection("productInfo");
                DBCollection myTrending = db.getCollection("myTrending");
                BasicDBObject searchQuery=new BasicDBObject();
                searchQuery.put("productID",productID);
                DBCursor cursor = myProducts.find(searchQuery);

                if(cursor.count() == 0) {
                        deleteProductValue="false";
                        request.setAttribute("deleteProductValue",deleteProductValue);
                        RequestDispatcher rd = request.getRequestDispatcher("deleteProduct.jsp");
                        rd.forward(request,response);
                } else {
                        int product = 0;
                        while (cursor.hasNext()) {

                                BasicDBObject obj = (BasicDBObject) cursor.next();
                                product =  obj.getInt("productID");
                                if(product == productID)
                                {
                                        myProducts.remove(obj);
                                        myTrending.remove(searchQuery);
                                        deleteProductValue="true";

                                        request.setAttribute("deleteProductValue",deleteProductValue);

                                        RequestDispatcher rd = request.getRequestDispatcher("deleteProduct.jsp");
                                        rd.forward(request,response);
                                }
                        }
                }
        } catch (Exception e) {
                e.printStackTrace();
        }
}
}
