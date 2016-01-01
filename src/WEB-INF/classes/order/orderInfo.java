package order;

import java.util.*;

public class orderInfo implements java.io.Serializable {
	
	public orderInfo() {
    }
	
    private String userID;
	private String orderNumber;
	private int productID;
	private String productModel;
	private String productSize;
	private int productPrice;
	private int productQuantity;
	private Date purchaseDate;
	private Date deliveryDate;
	private String shippingAddress;

public String getUserID() {
	return userID;
}
public String getOrderNumber() {
	return orderNumber;
}
public int getProductID() {
	return productID;
}
public String getProductModel() {
	return productModel;
}
public String getProductSize() {
	return productSize;
}
public int getProductPrice() {
	return productPrice;
}
public int getProductQuantity() {
	return productQuantity;
}
public Date getPurchaseDate() {
	return purchaseDate;
}
public Date getDeliveryDate() {
	return deliveryDate;
}
public String getShippingAddress() {
	return shippingAddress;
}


public void setUserID(String userID) {
	this.userID = userID;
}
public void setOrderNumber(String orderNumber) {
	this.orderNumber = orderNumber;
}
public void setProductID(int productID) {
	this.productID = productID;
}
public void setProductModel(String productModel) {
	this.productModel = productModel;
}
public void setProductSize(String productSize) {
	this.productSize = productSize;
}
public void setProductPrice(int productPrice) {
	this.productPrice = productPrice;
}
public void setProductQuantity(int productQuantity) {
	this.productQuantity = productQuantity;
}
public void setPurchaseDate(Date purchaseDate) {
	this.purchaseDate = purchaseDate;
}
public void setDeliveryDate(Date deliveryDate) {
	this.deliveryDate = deliveryDate;
}
public void setShippingAddress(String shippingAddress) {
	this.shippingAddress = shippingAddress;
}	

}