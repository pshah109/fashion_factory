import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.HashMap;
import java.util.Iterator;

/**
 *
 * @author nbuser
 */
public class autocomplete extends HttpServlet {
MongoClient mongo;
private ServletContext context;

@Override
public void init(ServletConfig config) throws ServletException {
								this.context = config.getServletContext();
}

/**
 * Handles the HTTP <code>GET</code> method.
 * @param request servlet request
 * @param response servlet response
 * @throws ServletException if a servlet-specific error occurs
 * @throws IOException if an I/O error occurs
 */
@Override
public void doGet(HttpServletRequest request, HttpServletResponse response)
throws IOException, ServletException {

								mongo = new MongoClient("localhost", 27017);
								DB db = mongo.getDB("FashionFactoryProd");
								DBCollection myProducts = db.getCollection("productInfo");

								BasicDBObject searchQuery = new BasicDBObject();

								DBCursor cursor = myProducts.find(searchQuery);

								String action = request.getParameter("action");
								String targetId = request.getParameter("id");
								StringBuffer sb = new StringBuffer();

								if (targetId != null) {
																targetId = targetId.trim().toLowerCase();
								}

								boolean namesAdded = false;
								if (action.equals("complete")) {

																// check if user sent empty string
																if (!targetId.equals("")) {

													while  (cursor.hasNext()) {

															BasicDBObject obj = (BasicDBObject) cursor.next();
															String productName=obj.getString("productName");
															String productID=obj.getString("productID");
															String productCategory=obj.getString("productCategory");

															if ( productName.toLowerCase().contains(targetId))
															{
															sb.append("<product>");
															sb.append("<id>" + productID + "</id>");
															sb.append("<name>" + productName + "</name>");
															sb.append("<category>" + productCategory + "</category>");
															sb.append("</product>");
															namesAdded = true;
															} //if
													} // while
								} // outer if

																if (namesAdded) {
																								response.setContentType("text/xml");
																								response.setHeader("Cache-Control", "no-cache");
																response.getWriter().write("<products>" + sb.toString() + "</products>");
																} else {
																								//nothing to show
																								response.setStatus(HttpServletResponse.SC_NO_CONTENT);
																}
								} // if action complete
}
}
