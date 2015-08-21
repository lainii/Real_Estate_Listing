<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
	<%@include file="parseFinal.jsp" %> <!--main parse file XML for data -->

<html>
  <head>
    
    <title>Real Estate Listing Form</title>
		<link href="style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

function checkSold(input){ //show date sold field if house is sold
	var dateSoldLoc = document.getElementById("ifSold"); //get div location
	if (input=="Yes"){
	 dateSoldLoc.innerHTML = '	 Date Sold:* ';
	document.entryForm.dateSold.type = "text";
	//document.write("hello!");
}
else {
	dateSoldLoc.innerHTML = '';
	document.entryForm.dateSold.type = "hidden";
	
	}	
}

function checkEntry(){
	
var one_day=1000*60*60*24; //constant to calculate millisec. in one day
valid = true;

//get data from form

var location = document.entryForm.location.value;
var price = (document.entryForm.price.value).trim();	
var dateOnMarket = (document.entryForm.date.value).trim();
var numDays; //calculated value
var sold = document.entryForm.sold.value;
var dateSold = document.entryForm.dateSold.value;
var shortDesc = (document.entryForm.desc.value).trim();
var image = (document.entryForm.image.value).trim();

var numExpression = /^[0-9]+$/; //reg exp to check pos integers
var dateExpression = /^\d{2}\/\d{2}\/\d{4}$/  //reg exp to check format of date

var msg = "<br/>"; //HTML string to show validation error message
var msgLoc = document.getElementById("notValid"); //div location to put msg	

//perform validation
   if ( location == "-1" )
   {
      msg = msg.concat ( "Please select a location <br/>" );
      valid = false;
   }
	if (price == "" || numExpression.test(price)== false){
		 msg = msg.concat ( "Please enter a valid price <br/>" );
     valid = false;	
	}
	if (dateOnMarket == "" || dateExpression.test(dateOnMarket)== false)
	{
		msg = msg.concat ( "Please enter date in valid format for 'date on market' <br/>" );
    valid = false;
	}
	else { //check if date entered is valid and is not greater than today's date
		var monthF = dateOnMarket.split("/")[0]; //get month string value
		var dayF = dateOnMarket.split("/")[1]; //get day string value
		var yearF = dateOnMarket.split("/")[2]; //get year string value
		
		var dayObj = new Date(yearF, monthF-1, dayF); //create new date based on input (month from 0 - 11)
		if ( (dayObj.getMonth()+1 != monthF) || (dayObj.getDate() != dayF) || (dayObj.getFullYear() != yearF) || dayObj > new Date() ) { 
			msg = msg.concat ( "Please enter a valid date for 'date on market' <br/>" );
			valid = false;
		}
	}

	if ( sold == "-1" )
   {
      msg = msg.concat ( "Please select a status <br/>" );
      valid = false;
		}
			else if (sold == "Yes"){
				if (dateSold == "" || dateExpression.test(dateSold)== false)
				{
					msg = msg.concat ( "Please enter date in valid format for 'date sold' <br/>" );
			    valid = false;
				}
				else { //check if date entered is valid and is not greater than today's date
					var monthF = dateSold.split("/")[0]; //get month string value
					var dayF = dateSold.split("/")[1]; //get day string value
					var yearF = dateSold.split("/")[2]; //get year string value

					var dayObj = new Date(yearF, monthF-1, dayF); //create new date based on input (month from 0 - 11)
					if ( (dayObj.getMonth()+1 != monthF) || (dayObj.getDate() != dayF) || (dayObj.getFullYear() != yearF) || dayObj > new Date()) { 
						msg = msg.concat ( "Please enter a valid date for 'date sold' <br/>" );
						valid = false;
					}
				}
			
   }

  msgLoc.innerHTML = msg; //output message
	
	
	if (valid){  //perform calculations if form is validated
	price = parseInt(price.trim(), 10); //remove any leading zeros for price
	
	if (shortDesc == ""){
		document.entryForm.desc.value = "N/A"; //set form value		
	}
	if (image == ""){
		document.entryForm.image.value = "N/A"; //set form value		
	}
	
	if (sold == "No"){ 	//if not sold, calc date diff between today and date on market
		dateSold = "N/A";
		numDays = Math.ceil((new Date() - new Date(dateOnMarket))/one_day); 
		
		}
		else {//if sold, calc date diff between date sold and date on market
			numDays = Math.ceil((new Date(dateSold) - new 	Date(dateOnMarket))/one_day); 
		}
	//update form values
	document.entryForm.price.value = price; 
	document.entryForm.numDays.value = numDays; 	
	document.entryForm.dateSold.value = dateSold;
}
	
	return valid;
	
}
</script>
</head>

  <body onload="document.entryForm.reset()" onunload="opener.location=('index.jsp')">
<div id="main_form">
		<%
		String newLocation = request.getParameter("location");
		String newPrice = request.getParameter("price");
		String newDate = request.getParameter("date");
		String newNumMarket = request.getParameter("numDays");
		String newSold = request.getParameter("sold");
		String newDateSold = request.getParameter("dateSold");
		String newDesc = request.getParameter("desc");
		String newURL = request.getParameter("image");
		
		if( newLocation != null && newPrice != null){
		%>

		<h1> New listing added successfully! <br/> </h1>
		
		<p>ID: <%= addRecord(newLocation, newPrice, newDate, newNumMarket, newSold, newDateSold, newDesc, newURL) %><br/>
		 Location: <%= newLocation %><br/>
    Price: <%= newPrice%></p>
		<p>Date on Market: <%= newDate %><br/>
		Number of days on market: <%= newNumMarket %><br/>
		Sold: <%= newSold %><br/>
  	date Sold: <%= newDateSold %><br/>
		Desc: <%= newDesc %><br/>
		Image URL: <%= newURL %> </p>

<form method ="post">
	<input type = "button" value= "Close Window" onclick= "window.close()">
	</form>
	
		<% }
		else{
			getData();
%>
    <h1>Real Estate Listing Entry</h1>
	<p><i>Enter record for new home for sale. (Fields with * are required)</i></p>

<%
// check null for required fields: if ( ID==null || location==null || dateonmarket == null || short desc == null ) {
%>
    <form name="entryForm" method ="post" action="form.jsp" onSubmit="return checkEntry()">
	<p>Location:  <select name="location">
	<option value = "-1" selected="selected"> (Select location) </option>
	<option value = "Alexandria"> Alexandria </option>
	<option value = "Annandale"> Annandale </option>
	<option value = "Arlington"> Arlington </option>
	<option value = "Falls Church"> Falls Church </option>
	<option value = "Reston"> Reston </option>
  <option value = "Vienna"> Vienna </option>
</select> *</p>
      <P>Price:     $ <input type="text" name="price" size="10" /> *</P>
			 <P>Date on Market :    
	      <input type="text" name="date" size="15" value="mm/dd/yyyy" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;"/> *</P>
				<P>Status:     
		      <select name="sold" onchange="checkSold(this.value)">
			<option value = "-1" selected ="selected"> (Select Status) </option>
			<option value = "No"> Not Sold </option>
			<option value = "Yes"> Sold </option></select> *
			 <span id="ifSold">  </span>  
	      <input type="hidden" name="dateSold" size="15" value="mm/dd/yyyy" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;"/></P>
      <P>Short Description <i>(max 500 characters)</i>:  <br/>      
      <textarea name="desc" rows="4" cols="30"/></textarea> </P>
      <P>Image URL:        
      <input type="text" name="image"/></P>
      <br/>
        <input type= "hidden" name="numDays"/>                                                  
        <input type="submit" value="submit" name="submit"/>
        <input type="reset" value="reset" name="cancel" />

    </form>

<div id = "notValid"></div>

<%
//}
//else{
	//write data to XML;	
	//home.addHome(objects);
	
	//forward page to success page: 
	//out.println(<jsp:forward page = "success.jsp");
//}
%>


<%
} %>


</div> <!-- main -->
</body>
</html>