import com.mongodb.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Date;
import java.text.*;
import review.*;

public class submitReview extends HttpServlet {

public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

MongoClient mongo = new MongoClient( "localhost", 27017 );

int productID = Integer.parseInt(request.getParameter("productID"));
String productName = request.getParameter("productName");
String firstName = request.getParameter("firstName");
int reviewRating = Integer.parseInt(request.getParameter("reviewRating"));
String reviewDateFetch = request.getParameter("reviewDate");
String reviewText = request.getParameter("reviewText");

String submitReviewValue="false";

Date reviewDate = new Date();
try{
DateFormat formatdate = new SimpleDateFormat("MM/dd/yyyy");
reviewDate = formatdate.parse(reviewDateFetch);
}catch(ParseException e){

}

DB db = mongo.getDB("FashionFactoryProd");
DBCollection myReviews = db.getCollection("prodReviews");

BasicDBObject doc = new BasicDBObject("title", "myReviews").append("productID", productID)
    .append("productName", productName).append("firstName", firstName)
    .append("reviewRating",reviewRating).append("reviewDate",reviewDate)
    .append("reviewText",reviewText);

    myReviews.insert(doc);

    submitReviewValue="true";

    request.setAttribute("submitReviewValue",submitReviewValue);

    String redirectURL = String.format("writeReview.jsp?productID=%s",productID);

    RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
    rd.forward(request,response);



}
}
