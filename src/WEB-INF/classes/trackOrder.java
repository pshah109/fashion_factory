import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.*;
import java.text.*;
import order.*;

public class trackOrder extends HttpServlet {

public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {


        String orderNumber=request.getParameter("orderNumber");
        String trackOrderValue="false";
        String ordernum="A#"+orderNumber;
        String orderStatus="";

        MongoClient mongo = new MongoClient( "localhost", 27017 );

        try{

                DB db = mongo.getDB("FashionFactoryProd");
                DBCollection myOrders = db.getCollection("myOrders");

                BasicDBObject searchQuery = new BasicDBObject();
                searchQuery.put("ordernum",ordernum);

                DBCursor cursor = myOrders.find(searchQuery);

                if(cursor.count() == 0) {
                        request.setAttribute("trackOrderValue",trackOrderValue);

                        String redirectURL = String.format("trackOrder.jsp");

                        RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
                        rd.forward(request,response);
                }

                if(cursor.count() > 0){
                    trackOrderValue="true";
                ArrayList<orderInfo> orderdata = new ArrayList();
                Date deliveryDate =  new Date();


                while (cursor.hasNext())
                {
                        BasicDBObject obj = (BasicDBObject) cursor.next();
                        orderInfo orderbean = new orderInfo();
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
                        deliveryDate=obj.getDate("deliverydate");
                }

                Date todayDate=new Date();
                long diff = deliveryDate.getTime()-todayDate.getTime();
                long diffDays = diff/(24 * 60 * 60 * 1000);

                if(diffDays>=15){
                  orderStatus="Order is being packed by retailer. It will be shipped shortly.";
                } else if (diffDays<15 && diffDays>=10){
                  orderStatus="Order is shipped by retailer. It will delivered on time.";
                } else if(diffDays<10 && diffDays>=5){
                  orderStatus="Order is shipped by retailer and reached to our nearest warehouse. It will delivered on time.";
                } else if(diffDays<5 && diffDays>=3){
                  orderStatus="Order is reached to our nearest warehouse and will be dispatched for delivery.";
                } else if(diffDays<3 && diffDays>=0){
                  orderStatus="Order is out for delivery. It will reach to you shortly";
                } else if(diffDays<0){
                  orderStatus="Order is already delivered to you.";
                }

                request.setAttribute("orderStatus",orderStatus);
                request.setAttribute("trackOrderValue",trackOrderValue);
                request.setAttribute("orderdata", orderdata);

                String redirectURL = String.format("trackOrder.jsp");

                RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
                rd.forward(request,response);
              }

        } catch(Exception e) {

        }



}

}
