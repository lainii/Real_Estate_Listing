<%@page import="org.w3c.dom.*, javax.xml.parsers.*, javax.xml.transform.*,javax.xml.transform.dom.DOMSource, javax.xml.transform.stream.StreamResult,java.io.*, java.util.*,java.text.*"%>

<%! // variable declarations
Document doc;
NodeList nList; //node list for the home

int[] id; 
String[] location;
int[] price;
String[] dateOnMarket;
int[] numDaysOnMarket;
String[] sold;
String[] dateSold;
String[] shortDesc;
String[] imageURL;

int numHouse; //count of number of houses in data
String dateString;
int lastID;

//String nID;
%>

<%! // method declarations
//return text node of element nodes by element tag
	private static String getTagValue(String sTag, Element eElement) {
	NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
 
    Node nValue = (Node) nlList.item(0);
 
	return nValue.getNodeValue();
	}

//set text node of element nodes by element tag

private static void setTagValue(String sTag, Element eElement, String newValue) {

NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
     Node nValue = (Node) nlList.item(0);
 nValue.setTextContent(newValue);
}
%>

<%
//  Parse the content of the given URI as an XML document and return a new DOM Document object
	File fileXML = new File("data.xml");

	DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	doc = docBuilder.parse(fileXML);
	doc.getDocumentElement().normalize(); //remove #text nodes
	
	nList = doc.getElementsByTagName("home"); //get node list for "home"
	numHouse = nList.getLength(); //get number of houses
	
	//initialize vars	
	id = new int[numHouse];
    location = new String[numHouse];
	price = new int[numHouse];
	dateOnMarket = new String[numHouse];
	numDaysOnMarket = new int[numHouse];
	sold = new String[numHouse];
	dateSold = new String[numHouse];
	shortDesc = new String[numHouse];
	imageURL = new String[numHouse];


%>

<%!
public void getData(){
		//loop through each "home" node
		for (int i = 0; i < numHouse; i++) {
	 //out.println(nList.getLength());
			   Node nNode = nList.item(i);
			   //if (nNode.getNodeType() == Node.ELEMENT_NODE) {

			      Element eElement = (Element) nNode;
				//get "home" attr Id
				  NamedNodeMap attrs = eElement.getAttributes();    
				 Node attN = attrs.getNamedItem("id");
				 //out.println("<br/> house ID: " + attN.getNodeValue()	);


				 id[i] = Integer.parseInt(attN.getNodeValue());

				 //store values to arrays
					if (getTagValue("location", eElement) !=null){
				 location[i]= getTagValue("location", eElement);
				}
				else {location[i]="N/A";}
				 price[i]	= Integer.parseInt(getTagValue("price", eElement));
				 dateOnMarket[i]	= getTagValue("dateOnMarket", eElement);
				 numDaysOnMarket[i] = Integer.parseInt(getTagValue("numDaysOnMarket", eElement));
				sold[i] = getTagValue("sold", eElement);
				dateSold[i] = getTagValue("dateSold", eElement);
				shortDesc[i] = getTagValue("shortDescription", eElement);
				imageURL[i] = getTagValue("imageURL", eElement);

				 //get "home" child element values
				/*
			      out.println("<br/>Location: " + location[i]);	  
			      out.println("<br/>Price: " + price[i]);
		          out.println("<br/>Date on Market: " + dateOnMarket[i]);
			      out.println("<br/>Days on Market: " + numDaysOnMarket[i]);
				  out.println("<br/>Sold?: " + sold[i]);
				  out.println("<br/>Date Sold: " + dateSold[i]);
				  out.println("<br/>Desc: " + shortDesc[i]);
				  out.println("<br/>Image: " + imageURL[i] );
				  out.println("<br/><br/>");
	*/
			   //}



	
					//	 DateFormat formatter = new SimpleDateFormat("mm/dd/yyyy");

					//	 Date date = (Date) formatter.parse(getTagValue("dateOnMarket", eElement));
						 //out.println(date);
					//	 dateString = formatter.format(date);


			}	
			lastID = id[numHouse-1];
}

%>	
	

<%!

// modify existing nodes: change price

public void changePrice(){

int inputID = 1001;
String priceChange = "33333";

//loop through each node of "home"
	for (int i = 0; i < numHouse; i++) {
	Node nNode = nList.item(i);
	Element eElement = (Element) nNode;
	
//out.println("<br/>id for current node: " + id[i]);	 
	if (id[i] == inputID){
	//out.println("<br/>id =: " + id[i]);	
	    //out.println("<br/>old Price: " + getTagValue("price", eElement));
		setTagValue("price", eElement, priceChange);
		//out.println("<br/>new Price: " + getTagValue("price", eElement));
		}
	}

	}
%>

<%!
//public void addRecord(int id, String location, int price, String dateOnMarket, int n//umDaysOnMarket, String sold, String dateSold, String shortDesc, String imageURL){
	
	public String addRecord(String newLocation, String newPrice, String newDate, String newNumMarket, String newSold, String newDateSold, String newDesc, String newURL){
	
	int newID = lastID + 1; //get value of new adding based on last id in record
	
	Element newHome = doc.createElement("home");

	newHome.setAttribute("id", Integer.toString(newID) ); //set id attr for new home
	
	Element nLoc = doc.createElement("location");
	nLoc.setTextContent(newLocation);
	Element nPrice = doc.createElement("price");
	nPrice.setTextContent(newPrice);
	Element nDate = doc.createElement("dateOnMarket");
	nDate.setTextContent(newDate);
	Element nNumDays = doc.createElement("numDaysOnMarket");
	nNumDays.setTextContent(newNumMarket);
	Element nSold = doc.createElement("sold");
	nSold.setTextContent(newSold);
	Element nDateSold = doc.createElement("dateSold");
	nDateSold.setTextContent(newDateSold);
	Element nDesc = doc.createElement("shortDescription");
	nDesc.setTextContent(newDesc);
	Element nImg = doc.createElement("imageURL");
	nImg.setTextContent(newURL);
	
	
	newHome.appendChild(nLoc);
	newHome.appendChild(nPrice);
	newHome.appendChild(nDate);
	newHome.appendChild(nNumDays);
	newHome.appendChild(nSold);
	newHome.appendChild(nDateSold);
	newHome.appendChild(nDesc);
	newHome.appendChild(nImg);
	
	doc.getDocumentElement().appendChild(newHome); //append home record to document
	
	//updateData(); //save document to XML file
	
	return Integer.toString(newID); //return new home ID
}

%>
<%!
private void updateData() {

 //write content to XML file using transformer object
try {
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		//transformer.setOutputProperty(OutputKeys.INDENT, "yes");

		//initialize StreamResult with object to save to file
		StreamResult result = new StreamResult(new File("data.xml"));
		DOMSource source = new DOMSource(doc);
		transformer.transform(source, result); 
		//System.out.println("<br/>Done");
		}
	catch (TransformerException tfe) {
		tfe.printStackTrace();
	   } 
	
}
%>
