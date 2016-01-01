function sortSelectAction(){
  var p1 = document.forms["sortSelect"]["sortByPrice"].value;
  var p2 = document.forms["sortSelect"]["category"].value;
  var p3 = document.forms["sortSelect"]["subcategory"].value;
  var p4 = document.forms["sortSelect"]["filterByBrand"].value;

  var f=document.sortSelect;
  f.action="productList?category="+p2+"&subcategory="+p3+"&sortByPrice="+p1+"&filterByBrand="+p4+"";
  f.submit();

}

function filterSelectAction(){
  var p1 = document.forms["filterBrand"]["filterByBrand"].value;
  var p2 = document.forms["filterBrand"]["category"].value;
  var p3 = document.forms["filterBrand"]["subcategory"].value;
  var p4 = document.forms["filterBrand"]["sortByPrice"].value;

  var f=document.filterBrand;
  f.action="productList?sortByPrice="+p4+"&category="+p2+"&subcategory="+p3+"&filterByBrand="+p1+"";
  f.submit();

}
