import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.UUID;
import sendEmail.*; // import sendEmail package

public class forgotPass extends HttpServlet {

  public String getRandomUUID(){

    String randomUUIDString="";

          try {

            UUID uuid = UUID.randomUUID();
            randomUUIDString = uuid.toString().replaceAll("-", "");

          }
          catch (Exception e)
          {
                  e.printStackTrace();
          }
          return randomUUIDString;
}

public void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

  MongoClient mongo = new MongoClient( "localhost", 27017 );

  String useremail = request.getParameter("username");
  String randomToken= getRandomUUID();
  String resetPassValue="false";

try{

          String resetURL="http://"+ request.getServerName() + ":" + request.getServerPort()
                          + "/FashionFactory/resetPassword.jsp?token="+randomToken;

          DB db = mongo.getDB("FashionFactoryProd");
          DBCollection forgotPass = db.getCollection("custForgotPass");
          BasicDBObject item=new BasicDBObject();
          item.put("userName",useremail);
          item.put("token",randomToken);
          forgotPass.insert(item);

          sendEmail forgotPassEmail = new sendEmail();
          String toAddress=useremail;
          String emailSubject="Password Reset Link for Fashion Factory";
          String emailMessage="Hello ,<br><br><br> Please <a href="+resetURL+">Click Here </a> to reset the password.<br><br><br><br><b>-Fashion Factory Team</b>";
          forgotPassEmail.sendTextEmail(toAddress,emailSubject,emailMessage);
          resetPassValue="true";
          request.setAttribute("resetPassValue",resetPassValue);

          RequestDispatcher rd = request.getRequestDispatcher("forgotPassword.jsp");
          rd.forward(request,response);

}catch(Exception e) {
        e.printStackTrace();
}


}

}
