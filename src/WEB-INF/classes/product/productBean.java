package product;
import java.util.Date;

public class productBean implements java.io.Serializable {

public productBean(){
}

private int productID;
private String productCategory;
private String productSubCategory;
private int productPrice;
private String productName;
private String productOnSale; // will contain offer ID
private String productBrand;
private Date productAddDate;
private int productQuantityS;
private int productQuantityM;
private int productQuantityL;
private int productQuantityXL;
private int productTotalQuantity;
private String productDescription;
private String productMaterial;
private String productSize;
private int productPurchaseQuantity;
private int discountPercent;
private int offerPrice;


public int getProductID(){
								return productID;
}
public String getProductCategory(){
								return productCategory;
}
public String getProductSubCategory(){
								return productSubCategory;
}
public int getProductPrice(){
								return productPrice;
}
public String getProductName(){
								return productName;
}
public String getProductOnSale(){
								return productOnSale;
}
public String getProductBrand(){
								return productBrand;
}
public Date getProductAddDate(){
								return productAddDate;
}
public int getProductQuantityS(){
								return productQuantityS;
}
public int getProductQuantityM(){
								return productQuantityM;
}
public int getProductQuantityL(){
								return productQuantityL;
}
public int getProductQuantityXL(){
								return productQuantityXL;
}
public int getProductTotalQuantity(){
								return productTotalQuantity;
}
public String getProductDescription(){
								return productDescription;
}
public String getProductMaterial(){
								return productMaterial;
}
public String getProductSize(){
								return productSize;
}
public int getProductPurchaseQuantity(){
								return productPurchaseQuantity;
}
public int getOfferPrice(){
			return offerPrice;
}
public int getDiscountPercent(){
			return discountPercent;
}


public void setProductID(int productID){
								this.productID = productID;
}
public void setProductCategory(String productCategory){
								this.productCategory = productCategory;
}
public void setProductSubCategory(String productSubCategory){
								this.productSubCategory = productSubCategory;
}
public void setProductName(String productName){
								this.productName = productName;
}
public void setProductPrice(int productPrice){
								this.productPrice = productPrice;
}
public void setProductOnSale(String productOnSale){
								this.productOnSale = productOnSale;
}
public void setProductBrand(String productBrand){
								this.productBrand = productBrand;
}
public void setProductAddDate(Date productAddDate){
								this.productAddDate = productAddDate;
}
public void setProductQuantityS(int productQuantityS){
								this.productQuantityS = productQuantityS;
}
public void setProductQuantityL(int productQuantityL){
								this.productQuantityL = productQuantityL;
}
public void setProductQuantityM(int productQuantityM){
								this.productQuantityM = productQuantityM;
}
public void setProductQuantityXL(int productQuantityXL){
								this.productQuantityXL = productQuantityXL;
}
public void setProductTotalQuantity(int productTotalQuantity){
								this.productTotalQuantity = productTotalQuantity;
}
public void setProductDescription(String productDescription){
								this.productDescription = productDescription;
}
public void setProductMaterial(String productMaterial){
								this.productMaterial = productMaterial;
}
public void setProductSize(String productSize){
								this.productSize = productSize;
}
public void setProductPurchaseQuantity(int productPurchaseQuantity){
								this.productPurchaseQuantity = productPurchaseQuantity;
}
public void setOfferPrice(int offerPrice){
								this.offerPrice = offerPrice;
}
public void setDiscountPercent(int discountPercent){
								this.discountPercent = discountPercent;
}



}
