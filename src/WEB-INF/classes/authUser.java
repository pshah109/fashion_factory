import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;
import com.mongodb.ServerAddress;
import java.util.Date;
import java.util.Properties;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class authUser extends HttpServlet {

public String encryptPassword(String password){

        String passwordToHash = password;
        String generatedPassword = null;
        try {
                MessageDigest md = MessageDigest.getInstance("SHA-1");
                md.update(passwordToHash.getBytes());
                byte[] bytes = md.digest();
                StringBuilder sb = new StringBuilder();
                for(int i=0; i< bytes.length; i++)
                {
                        sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                }
                generatedPassword = sb.toString();
        }
        catch (NoSuchAlgorithmException e)
        {
                e.printStackTrace();
        }
        return generatedPassword;

}

public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        MongoClient mongo = new MongoClient( "localhost", 27017 );
        HttpSession session = request.getSession();

        String loginValue="false";

        String useremail = request.getParameter("username");
        String password = request.getParameter("userpass");

        try{

                DB db = mongo.getDB("FashionFactoryProd");
                DBCollection custLogin = db.getCollection("custLogin");

                BasicDBObject searchQuery=new BasicDBObject();
                searchQuery.put("email",useremail);
                DBCursor cursor=custLogin.find(searchQuery);
                while (cursor.hasNext()) {
                        BasicDBObject obj=(BasicDBObject)cursor.next();
                        String result=obj.getString("password");
                        String firstName=obj.getString("firstName");
                        String loginType=obj.getString("userRole");
                        if (result.equals(encryptPassword(password))) {
                                loginValue="true";
                                // set attribute for message on response
                                request.setAttribute("loginValue",loginValue);
                                session.setAttribute("loginName", firstName);
                                session.setAttribute("userRole", loginType);
                                session.setAttribute("userEmail", useremail);
                                // return back to home
                                //RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                                //rd.forward(request,response);
                                if(loginType.equals("Customer")){
                                response.sendRedirect("index.jsp");
                                } else if (loginType.equals("Seller")){
                                response.sendRedirect("viewInventory.jsp");
                              } else if(loginType.equals("StoreManager")){
                                response.sendRedirect("viewInventory.jsp");
                              }
                        }
                }
                request.setAttribute("loginValue",loginValue);
                // return back to login jsp
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request,response);

        }catch(MongoException me) {
                me.printStackTrace();
        }catch(Exception e) {
                e.printStackTrace();
        }
}

public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

   PrintWriter out = response.getWriter();

   out.println("<html>");
   out.println("<h1> Forbidden Page. Invalid request.</h1>");
   out.println("</html>");

 }

}
