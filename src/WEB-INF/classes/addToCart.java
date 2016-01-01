import java.util.ArrayList;
import java.util.List;
import java.io.*;
import product.*;
import javax.servlet.http.*;
import javax.servlet.*;
import shoppingCart.*;

public class addToCart extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	try{

								HttpSession session = request.getSession();
								int productID=Integer.parseInt(request.getParameter("productID"));
								String productName = request.getParameter("productName");
								String productSize = request.getParameter("productSize");
								int productPrice =Integer.parseInt(request.getParameter("productPrice"));
								int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));

								cart ekart;
								ekart = (cart) session.getAttribute("cart");
								if(ekart == null) {
																ekart = new cart();
																session.setAttribute("cart", ekart);
								}

								productBean productCart = new productBean ();
								productCart.setProductID(productID);
								productCart.setProductName(productName);
								productCart.setProductPurchaseQuantity(productQuantity);
								productCart.setProductPrice(productPrice);
								productCart.setProductSize(productSize);

								boolean dupProd=ekart.checkDupProdCart(productID,productSize);
								String dupProdValue="false";

								if(dupProd==false){
								ekart.addToCart(productCart);
								}else if(dupProd==true){
								dupProdValue="true";
								}

								session.setAttribute("cart", ekart);
								request.setAttribute("dupProdValue", dupProdValue);

								RequestDispatcher rd = request.getRequestDispatcher("viewCart.jsp");
								rd.forward(request,response);

}catch(Exception e){
	e.printStackTrace();
}

}
}
