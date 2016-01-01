import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;
import com.mongodb.ServerAddress;
import java.util.HashMap;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Date;
import java.util.Properties;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import sendEmail.*; // import sendEmail package

public class registerCustSer extends HttpServlet {

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

        String userExists="false";

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("userEmail");
        String password = request.getParameter("userPassword");
        String userRole = request.getParameter("userRole");

        try{


                DB db = mongo.getDB("FashionFactoryProd");
                DBCollection custLogin = db.getCollection("custLogin");
                // check email in DB - email is primary key
                BasicDBObject document=new BasicDBObject();
                BasicDBObject searchQuery=new BasicDBObject();
                searchQuery.put("email",email);
                BasicDBObject keys=new BasicDBObject();
                keys.put("email",1);
                DBCursor cursor=custLogin.find(searchQuery,keys);
                while (cursor.hasNext()) {
                        BasicDBObject obj=(BasicDBObject)cursor.next();
                        String result="";
                        result+=obj.getString("email");
                        if (result.equals(email)) {
                                userExists="true";
                        }
                }
                // if email found go back to jsp showing error message
                if(userExists.equals("true")){
                request.setAttribute("userExists",userExists);
                RequestDispatcher rd = request.getRequestDispatcher("registerCustomer.jsp");
                rd.forward(request,response);
                }
                // if email not found register customer
                if (userExists.equals("false")) {
                        HashMap<String,String> userInfo = new HashMap<>();

                        userInfo.put("firstName",firstName);
                        userInfo.put("lastName",lastName);
                        userInfo.put("email",email);
                        userInfo.put("password",encryptPassword(password));
                        userInfo.put("userRole",userRole);
                        userInfo.put("creation_date",new Date().toString());

                        // insert into DB
                        custLogin.insert(new BasicDBObject(userInfo));
                        // set attribute for message on response
                        request.setAttribute("userExists",userExists);
                        // send email to user for register
                        sendEmail registerMail = new sendEmail();
                        String toAddress=email;
                        String emailSubject="Welcome to Fashion Factory";
                        String emailMessage="Hello "+firstName+",<br><br><br>Your SignUp is completed sucessfully.Please use your email as your <a href='http://localhost/FashionFactory/login.jsp'>login</a> User ID. <br><br><br><br><b>-Fashion Factory Team</b>";
                        registerMail.sendTextEmail(toAddress,emailSubject,emailMessage);
                        // return back to jsp
                        RequestDispatcher rd = request.getRequestDispatcher("registerCustomer.jsp");
                        rd.forward(request,response);
                }

        } catch(MongoException me) {
                me.printStackTrace();
        }catch(Exception e) {
                e.printStackTrace();
        }
}

}
