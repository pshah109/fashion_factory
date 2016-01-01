function validate() {
  var p1 = document.forms["registerCust"]["userPassword"].value;
  var p2 = document.forms["registerCust"]["userPasswordR"].value;

  if (p1 != p2) {
    alert("Password not match. Please enter same value in both password field");
    document.forms["registerCust"]["userPassword"].focus();
    return false;
  }
}
