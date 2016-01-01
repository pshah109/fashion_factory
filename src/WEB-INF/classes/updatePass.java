import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.Date;
import java.util.Properties;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class updatePass extends HttpServlet {

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

public void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

  MongoClient mongo = new MongoClient( "localhost", 27017 );

  String updatePassValue="false";

  String useremail = request.getParameter("userName");
  String password = request.getParameter("userPassword");

  try{

    DB db = mongo.getDB("FashionFactoryProd");
    DBCollection custLogin = db.getCollection("custLogin");

    BasicDBObject searchQuery=new BasicDBObject();
    searchQuery.put("email",useremail);

    DBCursor cursor=custLogin.find(searchQuery);

    if(cursor.count()==0){
      request.setAttribute("updatePassValue",updatePassValue);
      RequestDispatcher rd = request.getRequestDispatcher("resetPassword.jsp");
      rd.forward(request,response);
    }

    if(cursor.count()>0){
      BasicDBObject updatePassword = new BasicDBObject().append("$set",
      new BasicDBObject().append("password",encryptPassword(password)));

      custLogin.update(new BasicDBObject().append("email", useremail), updatePassword);

      updatePassValue="true";
      request.setAttribute("updatePassValue",updatePassValue);

      RequestDispatcher rd = request.getRequestDispatcher("resetPassword.jsp");
      rd.forward(request,response);

    }


}catch(Exception e) {
          e.printStackTrace();
}

}

}
