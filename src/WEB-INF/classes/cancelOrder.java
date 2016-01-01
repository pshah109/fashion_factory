import java.io.*;
import javax.servlet.*;
import com.mongodb.*;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import javax.servlet.http.*;
import java.util.*;
import java.text.SimpleDateFormat;

public class cancelOrder extends HttpServlet {

public void doGet(HttpServletRequest request,HttpServletResponse response)
throws ServletException, IOException {

        String useremail = request.getParameter("useremail");
 	      String product= request.getParameter("product");
	       String ordernum= request.getParameter("ordernum");
	        String delivery= request.getParameter("delivery");
	         String size= request.getParameter("size");
	          int quantity= Integer.parseInt(request.getParameter("quantity"));
	           int productId= Integer.parseInt(request.getParameter("productId"));
        String cancelOrderValue = "false";


        MongoClient mongo  = new MongoClient("localhost", 27017);

        DB db = mongo.getDB("FashionFactoryProd");
        DBCollection myOrders = db.getCollection("myOrders");
        DBCollection myProducts = db.getCollection("productInfo");


        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, 5);
        Date date = cal.getTime();
        String DATE_FORMAT = "MM/dd/yyyy";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        String checkdate = sdf.format(date);
        try{
                Date del = sdf.parse(delivery);
                Date chk = sdf.parse(checkdate);
                if(del.compareTo(chk)>0)
                {

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

                        cancelOrderValue = "true";

                        request.setAttribute("cancelOrderValue",cancelOrderValue);
                        request.setAttribute("model",product);
                        request.setAttribute("size",size);
                        request.setAttribute("ordernum",ordernum);
                        RequestDispatcher rd = request.getRequestDispatcher("myOrders.jsp");
                        rd.forward(request,response);
                }

                else
                {
                        cancelOrderValue = "false";
                        request.setAttribute("cancelOrderValue",cancelOrderValue);
                        request.setAttribute("model",product);
                        request.setAttribute("size",size);
                        request.setAttribute("ordernum",ordernum);
                        RequestDispatcher rd = request.getRequestDispatcher("myOrders.jsp");
                        rd.forward(request,response);
                }

        }
        catch (Exception e)
        {

        }


}
}
