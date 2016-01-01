package review;
import java.util.Date;

public class reviewInfoBean implements java.io.Serializable {

public reviewInfoBean(){
}

private String productName;
private int productID;
private String firstName;
private int reviewRating;
private Date reviewDate;
private String reviewText;

public String getProductName() {
	return productName;
}
public int getProductID() {
	return productID;
}
public String getFirstName() {
	return firstName;
}
public int getReviewRating() {
	return reviewRating;
}
public Date getReviewDate() {
	return reviewDate;
}
public String getReviewText() {
	return reviewText;
}

public void setProductName(String productName) {
	this.productName = productName;
}
public void setProductID(int productID) {
	this.productID = productID;
}
public void setFirstName(String firstName) {
	this.firstName = firstName;
}
public void setReviewRating(int reviewRating) {
	this.reviewRating = reviewRating;
}
public void setReviewDate(Date reviewDate) {
	this.reviewDate = reviewDate;
}
public void setReviewText(String reviewText) {
	this.reviewText = reviewText;
}

}
