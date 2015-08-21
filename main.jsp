<!--<%@page import="org.w3c.dom.*, javax.xml.parsers.*, java.io.*, java.util.*,java.text.*"%> -->


<HTML>
	<HEAD>
	<TITLE>Real Estate Search</TITLE>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<script src="sort.js" type="tex/javascript"></script>
	</HEAD>
	
	<BODY>
	
<div id = "main">
	<img src="keywestS.jpg"/>		
<div id="container">	
<h1> Real Estate Search </h1>


	<div id="sort menu">
	<span class="sort_by">
		<form action="" name="sortbyform1"><input type="hidden" name="IDXSESS" value="in8j6om0u8c34s79f4hcu1gh54" />
			<input type='hidden' name='ss_id' value='64451' />
			<label>Sort by:</label>
			<select class="submit_on_change" name="SORT_order">
						<option value="SORT_Def" selected="selected">(Select a method)</option>
						<option value="SORT_PriceAsc">Price (low to high)</option>
						<option value="SORT_PriceDesc" >Price (high to low)</option>
						<option value="SORT_LocAsc">Location (Ascending)</option>
						<option value="SORT_LocDsc">Location (Descending)</option>
			</select>
		</form>
		</span>
	</div> <!-- sort menu -->

<div id="content">

<p>	
<%@include file="parseFinal.jsp" %> <!--parse XML for data -->
</p>
<div class ="listing">
<div class="image">
	</div>	
<div class="info"> test test test</div>
	</div> <!-- listing -->
<p>There are currently <%= numHouse %> houses listed </p>
<p>The date is <%= dateString %>  </p>
<p>Thest location :<%= location[0] %>  </p>


<script type="text/javascript">
//read data from java array to javascript
var locData =  new Array();

<%
for (int i = 0; i < location.length; i++) {
out.println("locData["+i +"]=\"" +location[i] + "\""+";");
}
%>
</script>


</div> <!-- content -->
	<%
	// Obtain an element
  //Element elementT = doc.getElementById("1000");
// Get an attribute value; returns null if not present
//out.println(element.getAttribute("id")); // value1

  //out.println("<br/>: " + elementT.getAttribute());

%>	
<div id="footer">
	<p>&copy; 2012 Elaine Li</p>
</div>
</div> <!-- container-->
</div> <!-- main -->
	</BODY>
</HTML>