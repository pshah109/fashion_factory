import java.io.*;
import javax.servlet.*;
import com.mongodb.*;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import javax.servlet.http.*;
import java.util.*;
import java.text.SimpleDateFormat;

public class returnOrder extends HttpServlet {

public void doGet(HttpServletRequest request,HttpServletResponse response)
throws ServletException, IOException {

        String useremail = request.getParameter("useremail");
 	      String product= request.getParameter("product");
	       String ordernum= request.getParameter("ordernum");
	        String delivery= request.getParameter("delivery");
	         String size= request.getParameter("size");
	          int quantity= Integer.parseInt(request.getParameter("quantity"));
	           int productId= Integer.parseInt(request.getParameter("productId"));
        String returnOrderValue = "false";


        MongoClient mongo  = new MongoClient("localhost", 27017);

        DB db = mongo.getDB("FashionFactoryProd");
        DBCollection myOrders = db.getCollection("myOrders");
        DBCollection myProducts = db.getCollection("productInfo");

                        BasicDBObject update = new BasicDBObject();
                        BasicDBObject update1 = new BasicDBObject();

                        BasicDBObject searchquery = new BasicDBObject();
                        searchquery.put("productID", productId);

                        update1.append("$inc",new BasicDBObject().append("productTotalQuantity", quantity));

                        if(size.equals("Small"))
                        {
                                update.append("$inc",new BasicDBObject().append("productQuantityS", quantity));

                        }
                        else if (size.equals("Large"))
                        {
                                update.append("$inc",new BasicDBObject().append("productQuantityL",quantity));

                        }
                        else if (size.equals("Medium"))
                        {
                                update.append("$inc",new BasicDBObject().append("productQuantityM",quantity));

                        }
                        else if (size.equals("XLarge"))
                        {
                                update.append("$inc",new BasicDBObject().append("productQuantityXL",quantity));

                        }

                        myProducts.update(searchquery, update);
                        myProducts.update(searchquery, update1);


                        BasicDBObject deleteproduct = new BasicDBObject();
                        deleteproduct.put("ordernum",ordernum);
                        deleteproduct.put("model",product);
                        deleteproduct.put("size",size);

                        myOrders.remove(deleteproduct);

                        returnOrderValue = "true";

                        request.setAttribute("returnOrderValue",returnOrderValue);
                        request.setAttribute("Rmodel",product);
                        request.setAttribute("Rsize",size);
                        request.setAttribute("Rordernum",ordernum);
                        RequestDispatcher rd = request.getRequestDispatcher("myOrders.jsp");
                        rd.forward(request,response);

}
}
