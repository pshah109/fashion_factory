import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.Date;
import java.text.*;

public class addProduct extends HttpServlet {
MongoClient mongo;

public void init() throws ServletException{
		mongo = new MongoClient("localhost", 27017);
}

public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	String addProductValue="false";
	String dupProdValue="false";

		try {

			// Get the form data
			HttpSession session = request.getSession();
			int productID = Integer.parseInt(request.getParameter("productID"));
			String ProductCategory = request.getParameter("productCategory");
			int ProductPrice = Integer.parseInt(request.getParameter("productPrice"));
			String ProductSubCategory = request.getParameter("productSubCategory");
			String ProductName = request.getParameter("productName");
			String ProductOnSale = request.getParameter("productOnSale");
			String ProductBrand = request.getParameter("productBrand");
			String AddDate = request.getParameter("productAddDate");
			String sellerName = (String)session.getAttribute("userEmail");

			int DiscountAmount = 0;
			int OfferPrice = 0;
			if(Integer.parseInt(request.getParameter("discountPercent")) != 0 && ProductOnSale.equals("Yes") )
			{
				DiscountAmount = Integer.parseInt(request.getParameter("discountPercent"));
				OfferPrice = ProductPrice*(100-DiscountAmount)/100;
			}

			Date ProductAddDate =  new Date();
			try{
			DateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd");
			ProductAddDate = formatdate.parse(AddDate);
			}catch(ParseException e){

			}

			int ProductQuantityS = Integer.parseInt(request.getParameter("productQuantityS"));
			int ProductQuantityM = Integer.parseInt(request.getParameter("productQuantityM"));
			int ProductQuantityL = Integer.parseInt(request.getParameter("productQuantityL"));
			int ProductQuantityXL = Integer.parseInt(request.getParameter("productQuantityXL"));
			int ProductTotalQuantity = ProductQuantityS+ProductQuantityM+ProductQuantityL+ProductQuantityXL;
			String ProductDescription = request.getParameter("productDescription");
			String ProductMaterial = request.getParameter("productMaterial");

			DB db = mongo.getDB("FashionFactoryProd");
			DBCollection myProducts = db.getCollection("productInfo");
			DBCollection myTrending = db.getCollection("myTrending");


			BasicDBObject searchQuery=new BasicDBObject();
			searchQuery.put("productID",productID);
			DBCursor cursor=myProducts.find(searchQuery);

			if(cursor.size()>0){

				dupProdValue="true";
				request.setAttribute("dupProdValue",dupProdValue);

				RequestDispatcher rd = request.getRequestDispatcher("addProduct.jsp");
				rd.forward(request,response);

				} else {

			BasicDBObject doc = new BasicDBObject("title", "myProducts").append("productID", productID)
					.append("productCategory", ProductCategory).append("productPrice", ProductPrice)
					.append("productSubCategory", ProductSubCategory).append("productName", ProductName).append("productOnSale", ProductOnSale)
					.append("productBrand", ProductBrand).append("productAddDate", ProductAddDate).append("productQuantityS", ProductQuantityS).append("productQuantityM", ProductQuantityM)
					.append("productQuantityL", ProductQuantityL).append("productQuantityXL", ProductQuantityXL)
					.append("productTotalQuantity", ProductTotalQuantity).append("productDescription", ProductDescription)
					.append("productMaterial", ProductMaterial).append("offerPrice",OfferPrice).append("discountPercent",DiscountAmount)
					.append("sellerName",sellerName);

					myProducts.insert(doc);

					// inert value into trending DB Test
					BasicDBObject trending = new BasicDBObject().append("productID",productID).append("count",0);
				  myTrending.insert(trending);

				 addProductValue="true";

				 request.setAttribute("addProductValue",addProductValue);
				 session.removeAttribute("addProductID");
				 session.setAttribute("uploadImageValue","false");

				 RequestDispatcher rd = request.getRequestDispatcher("addProduct.jsp");
				 rd.forward(request,response);
			 }

		} catch (MongoException e) {
			e.printStackTrace();
		}

	}

}
