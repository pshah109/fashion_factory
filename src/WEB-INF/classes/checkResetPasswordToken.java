import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;

public class checkResetPasswordToken extends HttpServlet {

public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

  MongoClient mongo = new MongoClient( "localhost", 27017 );

  String randomToken = request.getParameter("token");
  String tokenValue="false";

try{
        DB db = mongo.getDB("FashionFactoryProd");
        DBCollection forgotPass = db.getCollection("custForgotPass");
        BasicDBObject searchQuery=new BasicDBObject();
        searchQuery.put("token",randomToken);
        DBCursor cursor=forgotPass.find(searchQuery);

        if(cursor.count()==0){
        tokenValue="false";
        request.setAttribute("tokenValue",tokenValue);
        }

        while (cursor.hasNext()) {
          BasicDBObject obj=(BasicDBObject)cursor.next();
          String email=obj.getString("userName");
          tokenValue="true";
          request.setAttribute("tokenValue",tokenValue);
          request.setAttribute("resetEmail",email);
        }
        
} catch(Exception e) {
        e.printStackTrace();
}

}

}
