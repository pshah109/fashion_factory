import review.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.ArrayList;
import java.util.List;
import com.mongodb.*;
import java.io.*;

public class getReviews extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

ArrayList<reviewInfoBean> viewReview = new ArrayList();

int productID=Integer.parseInt(request.getParameter("productID"));
String accessType=request.getParameter("accessType");

String viewReviewValue="false";

try{

MongoClient mongo;
mongo = new MongoClient("localhost", 27017);

DB db = mongo.getDB("FashionFactoryProd");
DBCollection myReviews = db.getCollection("prodReviews");
BasicDBObject query = new BasicDBObject();
DBCursor dbCursor=null;
DBObject sort = new BasicDBObject();

if(accessType.equals("Latest")){
query.put("productID",productID);
sort.put("reviewDate",-1);
dbCursor = myReviews.find(query).limit(5).sort(sort);
} else if (accessType.equals("All")) {
query.put("productID",productID);
sort.put("reviewDate",-1);
sort.put("reviewRating",-1);
dbCursor = myReviews.find(query).sort(sort);
}

if(dbCursor.count() == 0) {
request.setAttribute("viewReviewValue",viewReviewValue);
}

while (dbCursor.hasNext()) {
viewReviewValue="true";
request.setAttribute("viewReviewValue",viewReviewValue);

BasicDBObject obj = (BasicDBObject) dbCursor.next();

reviewInfoBean review = new reviewInfoBean();

review.setFirstName(obj.getString("firstName"));
review.setReviewRating(obj.getInt("reviewRating"));
review.setReviewDate(obj.getDate("reviewDate"));
review.setReviewText(obj.getString("reviewText"));

viewReview.add(review);

}

if(dbCursor.size() > 0) {
request.setAttribute("viewReviews",viewReview);
}

}catch(Exception e) {
e.printStackTrace();
}

}
}
