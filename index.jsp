<!--<%@page import="org.w3c.dom.*, javax.xml.parsers.*, java.io.*, java.util.*,java.text.*"%> -->
	<%@include file="parseFinal.jsp" %> <!--main parse file XML for data -->
	
<!-- to do:
> output price with deliminator
> add conditional sold field (done)

change vars to function calls
-->

<HTML>
	<HEAD>
	<TITLE>Real Estate Listing</TITLE>
	<link href="style.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript">
	//pop up window 
function popup(url){
	popUpWindow = window.open(url, 'entry form', 'height=500,width=500,top=200,menubar=no,location=no,scrollbars=no');
	if (window.focus) {popUpWindow.focus();}	
}
</script>
	</HEAD>
	
	<BODY onload="document.sortbyForm.reset(),document.searchbyLocForm.reset(),document.searchbyPriceForm.reset()">

<div id = "main">
		<img src="keywest.jpg"/>

	
<ul id="nav">
			<li><a href=""> Home</a></li>
			<li><a href="">Search</a></li>
			<li><a href="form.jsp" onclick="popup(this.href); return false">Add Listing</a></li>
			<li><a href="">Modify</a></li>
</ul>	
	
	
<div id="container">	
<h1> NOVA Real Estate Listing </h1>
<br/>

<div id ="search">

<!-- search menu  -------------------------------------------- -->
	<div id="search_menu">
		<form action="" name="searchbyLocForm" style="margin-bottom:0; float:left;">
			<label>Show Listing by city:</label>
			<select name="search_Location" onChange="showbyCity(this.value),sortbyForm.reset()">
						<option value="-1" selected>(All)</option>
						<option value="Arlington">Arlington</option>
						<option value="Alexandria">Alexandria</option>
						<option value="Fairfax">Fairfax</option>						
						<option value="Falls Church" >Falls Church</option>
						<option value="Reston">Reston</option>
						<option value="Vienna">Vienna</option>
			</select>
		</form>
				
			<form action="" name="searchbyPriceForm" style="margin-bottom:0;" >
			<label>&nbsp;&nbsp;&nbsp;&nbsp;By price range:</label>
			<select name="search_Price" onChange="">
						<option value="-1" selected>(All)</option>
						<option value="1">&lt;400K</option>
						<option value="2">400K - 700K</option>						
						<option value="3" >700K - 1M</option>
						<option value="4">1M + </option>
			</select>
		</form>
</div> <!-- search menu ---------------- -->
	
<b>There are currently <%= numHouse %> listings. </b> 
<!-- sort menu  -------------------------------------------- -->
	<div id="sort_menu">

		<form action="" name="sortbyForm">
			<label>Sort by:</label>
			<select name="SORT_order" onChange="sortby(this.value)">
						<option value="-1" selected>(Select a method)</option>
						<option value="SORT_PriceAsc">Price (low to high)</option>
						<option value="SORT_PriceDesc" >Price (high to low)</option>
						<option value="SORT_LocAsc">Location (Ascending)</option>
						<option value="SORT_LocDsc">Location (Descending)</option>
			</select>
		</form>

	</div> <!-- sort menu ---------------- -->

</div> <!--- search div -->	
	

<div id="content">

<script type="text/javascript">
//var testname = document.forms[index].elements["SORT_order"].value;
//document.write(testname);

var homes = new Array(); //create homes object array
getHomes(); //retrieve data from server


//default array to loop through houses
var pos = new Array();
//create array of listing indexes
for (var i=0; i<homes.length; i++){
pos.push(i);
//document.write( i+',');
}

document.write(outputListing(homes, pos));
//objBubbleSort(homes,"location", "desc");
//outputListing(); //get home listing


/* // test static homes:
homes[0] = new Home( 3212, "Annandale", 543400, "06/12/2008", 55, "No", "N/A",  'desc of something', "http://localhost:8080/image.jpg");
homes[1] = new Home( 1054, "Reston", 100400, "01/22/2009", 130, "Yes", "09/01/2009",  'desc of something else yeah', "http://localhost:8080/image.jpg");
homes[3] = new Home();
homes[3].location = "test location";
document.write(homes[3].location);
*/

//function to get home listing from server
function getHomes(){
 
//parse data on server side
<%getData(); %>

//pass data from server into Homes object
<% for (int i = 0; i < numHouse; i++) { %>

//.write(locData[<%=i%>]);

/*
homes[<%= i %>]	= new Home();
homes[<%= i %>].id = <%= id[i] %>;
homes[<%= i %>].location = "<%= location[i] %>";
homes[<%= i %>].price = <%= price[i] %>;
homes[<%= i %>].dateOnMarket = "<%= dateOnMarket[i] %>";
homes[<%= i %>].numDaysOnMarket = <%= numDaysOnMarket[i] %>;
homes[<%= i %>].sold = "<%= sold[i] %>";
homes[<%= i %>].dateSold = "<%= dateSold[i] %>";
homes[<%= i %>].shortDesc ="<%= shortDesc[i] %>";
homes[<%= i %>].image = "<%= imageURL[i] %>";
*/

homes[<%= i %>] = new Home(<%= id[i] %>, "<%= location[i] %>",<%= price[i] %>,"<%= dateOnMarket[i] %>",<%= numDaysOnMarket[i] %>,"<%= sold[i] %>","<%= dateSold[i] %>","<%= shortDesc[i] %>","<%= imageURL[i] %>");	
	<% } %>
	
} /*end getHome() function */

//define "homes" object
function Home(id, location, price, dateOnMarket, numDaysOnMarket, sold, dateSold, shortDesc, image){
this.id = id;
this.location = location;
this.price = price;
this.dateOnMarket = dateOnMarket;
this.numDaysOnMarket = numDaysOnMarket;
this.sold = sold;
this.dateSold = dateSold;
this.shortDesc = shortDesc;
this.image = image; 
}


function outputListing(homes, position){
var listing =new String(); //string var to store HTML output for listing
var i = 0; //count for search position

//if position is not specified, use all listings
if (position == undefined){
//document.write("yes");
position = new Array();
//create array of listing indexes
for (var c=0; c<homes.length; c++){
position.push(c);
		}
}

//loop through all listing and append data to html
for (var x=0; x<homes.length; x++){

	if ( x == position[i]){
	
		listing = listing.concat('<div class="listing_title">');
		 listing = listing.concat('<span class="listingBold">$'+homes[x].price+'              -         '+'</span>');
		 listing = listing.concat('<span class="locationH">'+'( #'+homes[x].id + ' )  '+ homes[x].location+', VA'+'</span>'); 
		 if (homes[x].sold == "Yes") {
		 listing = listing.concat('     <span class="sold"> ( Sold on '+ homes[x].dateSold+ ' )</span>');
		 }
		 // listing = listing.concat('Price:  ');	
		listing = listing.concat('</div>');//end div listing title
	
  listing = listing.concat('<div class ="listing">');
  //listing = listing.concat('<p> test para </p>');

  listing = listing.concat('<div class ="image">');
 if (homes[x].image != "N/A"){
  listing = listing.concat('<img src="'+homes[x].image+'">');}
  listing = listing.concat('</div>'); //end div image
  listing = listing.concat('<div class ="info">');
// listing = listing.concat('<p>');
 //listing = listing.concat('<h2>Location:</h2>  ');

 //listing = listing.concat('<br/>');
 listing = listing.concat('<b>Date on Market:  </b>');		listing = listing.concat(homes[x].dateOnMarket+'<br/>');
  listing = listing.concat('<b>Days on Market:  </b>');	listing = listing.concat(homes[x].numDaysOnMarket+'<br/><br/>');
 listing = listing.concat('<b>Description:</b><br/> ');	listing = listing.concat(homes[x].shortDesc+'<br/>');
 //listing = listing.concat('</p>');
  listing = listing.concat('</div>'); //end div for info
  //document.write (home[1].image);
 // document.write (homes[1].location +",");  
  //document.write (homes[1].price + "<br/>");   
  listing = listing.concat('</div>'); //end div for listing
  
  i =i+1;
		}
	}
	return listing;
}/*end outputListing() function */


//sorting function. input: array object, element to sort by (string), order by flag ("desc)
 function objBubbleSort(objArray, el, order) {
 var length = objArray.length;
  
    for (var i=0; i<(length-1); i++){
        for (var j=i+1; j<length; j++)
            if (objArray[j][el] < objArray[i][el]) {
                var dummy = objArray[i];
                objArray[i] = objArray[j];
                objArray[j] = dummy;
				}
			}
if (order == "desc"){	
	var dummyArray = objArray.slice();	//create copy of array
	for (var x=0; x<(length); x++)
		{
	j = length-1-x;
	//document.write (objArray[x][el]+"," + dummyArray[x][el] +"\n");  
		
		//document.write (x+"," + j +"\n");  
	objArray[x] = dummyArray[j];
		//document.write (objArray[x][el]+"," + dummyArray[x][el] +"\n");  
		}
	}
}
function sortby(input){
var contentLoc = document.getElementById("content");

//change HTML output of div "content"
	if (input != "-1"){
	switch (input){
		case "SORT_PriceAsc":		
		objBubbleSort(homes,"price");
		break;
		case "SORT_PriceDesc":
		objBubbleSort(homes,"price", "desc");
		break;
		case "SORT_LocAsc":
		objBubbleSort(homes,"location");
		break;
		case "SORT_LocDsc":
		objBubbleSort(homes,"location", "desc");
		break; 	
		}
		showbyCity(searchbyLocForm.search_Location.value);			
	}
}

function showbyCity(input){
var contentLoc = document.getElementById("content");
var posSearch = new Array();

//change HTML output of div "content"

	if (input != "-1"){
	
	for (var i=0; i<homes.length; i++){
	if (homes[i].location == input){
		posSearch.push(i);
			}		
		}
	if (posSearch.length==0)
		contentLoc.innerHTML = "<br/><p>No listings available for this search.</p>";	
	else
		contentLoc.innerHTML = outputListing(homes, posSearch);		
	}
	else{
	contentLoc.innerHTML = outputListing(homes);
	}
}

function showbyPrice(input){
var contentLoc = document.getElementById("content");
var posSearch = new Array();

//change HTML output of div "content"	

	if (input != "-1"){
		
		switch (input){ 
			case "1":		//<400K
			//objBubbleSort(homes,"price");
			break;
			case "2": //400-700k
			//objBubbleSort(homes,"price", "desc");
			break;
			case "3": //700-1M
			//objBubbleSort(homes,"location");
			break;
			case "4": //>1M
			//objBubbleSort(homes,"location", "desc");
			break; 	
			}
	/*for (var i=0; i<homes.length; i++){
	if (homes[i].location == input){
		posSearch.push(i);
			}		
		}
	if (posSearch.length==0)
		contentLoc.innerHTML = "<br/><p>No listings available for this search.</p>";	
	else
		contentLoc.innerHTML = outputListing(homes, posSearch);		
	}*/
	}
	else  {contentLoc.innerHTML = outputListing(homes);}
}

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