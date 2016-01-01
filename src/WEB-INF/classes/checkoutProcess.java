import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.*;
import java.text.SimpleDateFormat;
import shoppingCart.*;
import product.*;
import java.text.*;
import order.*;
import sendEmail.*; // import sendEmail package

public class checkoutProcess extends HttpServlet {

MongoClient mongo;

public void init() throws ServletException {
        // Connect to Mongo DB
        mongo = new MongoClient("localhost", 27017);
}

public void doPost(HttpServletRequest request,
                  HttpServletResponse response)
throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String)session.getAttribute("userEmail");
        String checkLogin = (String)session.getAttribute("loginName");
        String DATE_FORMAT = "MM/dd/yyyy";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, 0);
        Date date = cal.getTime();
        String purchasedat = sdf.format(date);

        cal.add(Calendar.DAY_OF_MONTH, 15);
        date = cal.getTime();
        String deliverydat = sdf.format(date);



        try{
                Date deliverydate = sdf.parse(deliverydat);
                Date purchasedate = sdf.parse(purchasedat);


                String s="";
                s=request.getParameter("addr") + "   ";
                s=s+request.getParameter("city") + ",  ";
                s=s+request.getParameter("state") + ",  ";
                s=s+request.getParameter("zip") + "   ";
                s=s+request.getParameter("country") + "   ";
                Random r = new Random();
                int Low = 123456;
                int High = 622653;
                int R = r.nextInt(High-Low) + Low;
                String order = "A#"+R;

                cart ekart;
                ekart = (cart) session.getAttribute("cart");
                ArrayList<productBean> Items= ekart.getCartItems();

                DB db = mongo.getDB("FashionFactoryProd");
                DBCollection myOrders = db.getCollection("myOrders");
                for(int i=0; i<Items.size(); i++) {
                        productBean productData = (productBean)Items.get(i);
                        BasicDBObject doc = new BasicDBObject("title", "myOrders").
                                            append("useremail",(userEmail)).
                                            append("firstName",checkLogin).
                                            append("ordernum",(order)).
                                            append("productid",(productData.getProductID())).
                                            append("model",(productData.getProductName())).
                                            append("price",(productData.getProductPrice()*productData.getProductPurchaseQuantity())).
                                            append("quantity",(productData.getProductPurchaseQuantity())).
                                            append("size",(productData.getProductSize())).
                                            append("purchasedate",(purchasedate)).
                                            append("deliverydate",(deliverydate)).
                                            append("shippingaddress",(s));
                        myOrders.insert(doc);

                }

                // send email to customer for order
                sendEmail orderMail = new sendEmail();
                String toAddress=userEmail;
                String emailSubject="Order Placed on Fashion Factory";
                String emailMessage="Hello "+checkLogin+",<br><br>Your Order "+order+" is placed sucessfully.You can cancel your order before 5 days of delivery.<br>Thank you for shopping with us.<br><br><b>- Fashion Factory Team</b>";
                orderMail.sendTextEmail(toAddress,emailSubject,emailMessage);

                // update inventory for product

                DBCollection myProducts= db.getCollection("productInfo");

                for(int i=0; i<Items.size(); i++) {

                        BasicDBObject searchquery = new BasicDBObject();
                        BasicDBObject searchquery1 = new BasicDBObject();

                        BasicDBObject upd = new BasicDBObject();
                        BasicDBObject upd1 = new BasicDBObject();

                        productBean productData = (productBean)Items.get(i);

                        int quantity=productData.getProductPurchaseQuantity()*(-1);

                        upd1.append("$inc",new BasicDBObject().append("productTotalQuantity", quantity));
                        searchquery1.put("productID", productData.getProductID());

                        if(productData.getProductSize().equals("Small"))
                        {
                                upd.append("$inc",new BasicDBObject().append("productQuantityS", quantity));
                                searchquery.put("productID", productData.getProductID());
                        }
                        else if (productData.getProductSize().equals("Large"))
                        {
                                upd.append("$inc",new BasicDBObject().append("productQuantityL",quantity));
                                searchquery.put("productID", productData.getProductID());
                        }
                        else if (productData.getProductSize().equals("Medium"))
                        {
                                upd.append("$inc",new BasicDBObject().append("productQuantityM",quantity));
                                searchquery.put("productID", productData.getProductID());
                        }
                        else if (productData.getProductSize().equals("XLarge"))
                        {
                                upd.append("$inc",new BasicDBObject().append("productQuantityXL",quantity));
                                searchquery.put("productID", productData.getProductID());
                        }

                        myProducts.update(searchquery, upd);
                        myProducts.update(searchquery1, upd1);

                }

                // update the count for trending

                DBCollection myTrending= db.getCollection("myTrending");

                for(int i=0; i<Items.size(); i++) {

                        BasicDBObject searchquery = new BasicDBObject();
                        BasicDBObject upd = new BasicDBObject();
                        productBean productData = (productBean)Items.get(i);
                        searchquery.put("productID", productData.getProductID());

                        upd.append("$inc",new BasicDBObject().append("count", productData.getProductPurchaseQuantity()));

                        myTrending.update(searchquery, upd);

                }

                session.removeAttribute("cart");
                ArrayList<orderInfo> Orders = new ArrayList<orderInfo>();
                orderInfo orderData = new orderInfo();
                orderData.setOrderNumber(order);
                orderData.setDeliveryDate(deliverydate);
                orderData.setPurchaseDate(purchasedate);
                orderData.setShippingAddress(s);
                Orders.add(orderData);
                session.setAttribute("Orders",Orders);
                response.sendRedirect("orderPlaced.jsp");

        }

        catch(Exception e)
        {

        }

}

}
