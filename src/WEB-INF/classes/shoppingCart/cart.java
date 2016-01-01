package shoppingCart;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import product.*;

public class cart implements java.io.Serializable {

ArrayList<productBean> cartItems;

public cart(){
			cartItems = new ArrayList<productBean>();
}
public ArrayList<productBean>  getCartItems(){
								return cartItems;
}

public void addToCart(productBean Bean){
								cartItems.add(Bean);
}

public void deleteFromCart(Integer productID,String productSize){

								for(int i=0; i<cartItems.size(); i++)
								{
									productBean productdata = (productBean)cartItems.get(i);
									int id = productdata.getProductID();
									String size = productdata.getProductSize();
									if((id==productID) &&  (size.equals(productSize)))
												{
												cartItems.remove(productdata);
												}
								}
}

public boolean checkDupProdCart(Integer productID,String productSize){

								for(int i=0; i<cartItems.size(); i++)
								{
									productBean productdata = (productBean)cartItems.get(i);
									int id = productdata.getProductID();
									String size = productdata.getProductSize();
									if((id==productID) &&  (size.equals(productSize)))
												{
												return true;
												}
								}
								return false;
}




}
