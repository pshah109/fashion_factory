        <div id="sidebar">
          <div class="box categories">
            <h2>Categories</h2>
            <div class="box-content">
              <nav class="navigation">
                <ul class="mainmenu">
                  <li><a href="#">Menswear</a>
                    <ul class="submenu">
                      <li><a href="productCatalog.jsp?category=Men&subcategory=Top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tops</a></li>
                      <li><a href="productCatalog.jsp?category=Men&subcategory=Bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bottoms</a></li>
                      <li><a href="productCatalog.jsp?category=Men&subcategory=Accessory">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accessories</a></li>
                    </ul>
                  </li>
                  <li><a href="#">Womenswear</a>
                    <ul class="submenu">
                      <li><a href="productCatalog.jsp?category=Women&subcategory=Top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tops</a></li>
                      <li><a href="productCatalog.jsp?category=Women&subcategory=Bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bottoms</a></li>
                      <li><a href="productCatalog.jsp?category=Women&subcategory=Accessory">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accessories</a></li>
                    </ul>
                  </li>
                  <li class="last"><a href="#">Kidswear</a>
                    <ul class="submenu">
                        <li><a href="productCatalog.jsp?category=Kid&subcategory=Top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tops</a></li>
                        <li><a href="productCatalog.jsp?category=Kid&subcategory=Bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bottoms</a></li>
                        <li><a href="productCatalog.jsp?category=Kid&subcategory=Accessory">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accessories</a></li>
                    </ul>
                    </li>
                  </li>
                </ul>
                <!-- End Mainmenu -->
              </nav>
              <!-- End Navigation -->
            </div>
          </div>
          <!-- End Categories -->
          <br>
          <div class="box search">
            <h2>Search by</h2>
            <div class="box-content">
              <form name="autofillform" action="viewSearch.jsp">
                <table>
                <label>Products</label>
                <input type="text" class="field" name="searchText" id="complete-field" onkeyup="doCompletion()" autocomplete="off">
                <td id="auto-row" colspan="2">
                <table id="complete-table" class="popupBox" />
                 </td>
                </table>
                </table>
                <label>Category</label>
                <select class="field" name="searchCategory">
                  <option value="Men">Menswear</option>
                  <option value="Women">Womenswear</option>
                  <option value="Kid">Kidswear</option>
                </select>
                <input type="submit" class="search-submit" value="Search" />
              </form>
            </div>
          </div>
        </div>
