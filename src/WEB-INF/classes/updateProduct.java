import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.mongodb.*;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.Date;
import java.text.*;

public class updateProduct extends HttpServlet {
MongoClient mongo;

public void init() throws ServletException{
		mongo = new MongoClient("localhost", 27017);
}

public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	String updateProductValue="false";

		try {

			// Get the form data
			int productID = Integer.parseInt(request.getParameter("productID"));
			String ProductCategory = request.getParameter("productCategory");
			int ProductPrice = Integer.parseInt(request.getParameter("productPrice"));
			String ProductSubCategory = request.getParameter("productSubCategory");
			String ProductName = request.getParameter("productName");
			String ProductOnSale = request.getParameter("productOnSale");
			String ProductBrand = request.getParameter("productBrand");
			//String AddDate = request.getParameter("productAddDate");

			int DiscountAmount = 0;
			int OfferPrice = 0;
			if(Integer.parseInt(request.getParameter("discountPercent")) != 0 && ProductOnSale.equals("Yes") )
			{
				DiscountAmount = Integer.parseInt(request.getParameter("discountPercent"));
				OfferPrice = ProductPrice*(100-DiscountAmount)/100;
			}

			Date ProductAddDate =  new Date();

			int ProductQuantityS = Integer.parseInt(request.getParameter("productQuantityS"));
			int ProductQuantityM = Integer.parseInt(request.getParameter("productQuantityM"));
			int ProductQuantityL = Integer.parseInt(request.getParameter("productQuantityL"));
			int ProductQuantityXL = Integer.parseInt(request.getParameter("productQuantityXL"));
			int ProductTotalQuantity = ProductQuantityS+ProductQuantityM+ProductQuantityL+ProductQuantityXL;
			String ProductDescription = request.getParameter("productDescription");
			String ProductMaterial = request.getParameter("productMaterial");

			DB db = mongo.getDB("FashionFactoryProd");
			DBCollection myProducts = db.getCollection("productInfo");

			BasicDBObject updateName = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productName", ProductName));
			myProducts.update(new BasicDBObject().append("productID", productID), updateName);

			BasicDBObject updatePrice  = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productPrice",ProductPrice));
			myProducts.update(new BasicDBObject().append("productID", productID), updatePrice);


			BasicDBObject updateSale = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productOnSale", ProductOnSale));
			myProducts.update(new BasicDBObject().append("productID", productID), updateSale);

			BasicDBObject updateDiscount = new BasicDBObject()
			.append("$set",new BasicDBObject().append("discountPercent", DiscountAmount));
			myProducts.update(new BasicDBObject().append("productID", productID), updateDiscount);

			BasicDBObject updateOffer = new BasicDBObject()
			.append("$set",new BasicDBObject().append("offerPrice", OfferPrice));
			myProducts.update(new BasicDBObject().append("productID", productID), updateOffer);

			BasicDBObject updateBrand = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productBrand", ProductBrand));
			myProducts.update(new BasicDBObject().append("productID", productID), updateBrand);

			BasicDBObject updateQuantityS = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productQuantityS", ProductQuantityS));
			myProducts.update(new BasicDBObject().append("productID", productID), updateQuantityS );

			BasicDBObject updateQuantityM = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productQuantityM", ProductQuantityM));
			myProducts.update(new BasicDBObject().append("productID", productID), updateQuantityM);

			BasicDBObject  updateQuantityL = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productQuantityL", ProductQuantityL));
			myProducts.update(new BasicDBObject().append("productID", productID),  updateQuantityL);

			BasicDBObject updateQuantityXL  = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productQuantityXL", ProductQuantityXL));
			myProducts.update(new BasicDBObject().append("productID", productID), updateQuantityXL );

			BasicDBObject updateTotalQuantity = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productTotalQuantity", ProductTotalQuantity ));
			myProducts.update(new BasicDBObject().append("productID", productID), updateTotalQuantity );

			BasicDBObject updateDescription = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productDescription", ProductDescription));
			myProducts.update(new BasicDBObject().append("productID", productID), updateDescription );

			BasicDBObject updateMaterial = new BasicDBObject()
			.append("$set",new BasicDBObject().append("productMaterial",ProductMaterial));
			myProducts.update(new BasicDBObject().append("productID", productID), updateMaterial);


				 updateProductValue="true";

				 request.setAttribute("updateProductValue",updateProductValue);

				 String redirectURL = String.format("updateProduct.jsp?productID=%s",productID);

				 RequestDispatcher rd = request.getRequestDispatcher(redirectURL);
				 rd.forward(request,response);

		} catch (MongoException e) {
			e.printStackTrace();
		}

	}

}
