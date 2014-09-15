<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="reivax.norac.topfive.webapp.*" %>

<%
// RETRIEVE THE MAIN OBJECT
String city = (String) request.getAttribute("city");
Map<PlaceType, List<Place>> placesByType = (Map<PlaceType, List<Place>>) request.getAttribute("placesByType");
List<Place> restoPlaces = placesByType!=null?placesByType.get(PlaceType.RESTAURANT):null;
List<Place> attractionPlaces = placesByType!=null?placesByType.get(PlaceType.ATTRACTION):null;
List<Place> pubPlaces = placesByType!=null?placesByType.get(PlaceType.PUB):null;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="title" content="Visit with Me - Travels">
<meta name="description" content="Weekend Planner - Top 5 Destinations">
<meta name="keywords" content="Xavier CARON, travel, weekend planner">
<title>Weekend Planner - Top 5</title>


	<link href='http://fonts.googleapis.com/css?family=UnifrakturMaguntia' rel='stylesheet' type='text/css'>

    <link href="./bootstrap-3.2.0/dist/css/bootstrap.css" rel="stylesheet">
    <link href="./bootstrap-3.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="text/javascript" src="./bootstrap-3.2.0/dist/js/bootstrap.js"></script>    
    
    <!-- Google Maps API -->
    <script type="text/javascript" src="./bootstrap-3.2.0/js/googlemapshelper.js"></script>
    
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

	<script type="text/javascript">
		// Global variable for Google Maps API
		var restoPos = new Array();
		var restoArray = new Array();
		var pubPos = new Array();
		var pubArray = new Array();
		var attractionPos = new Array();
		var attractionArray = new Array();
		
	</script>
	
	<%
	if(restoPlaces != null){
		for(int i=0; i<restoPlaces.size(); i++){
			Place r = restoPlaces.get(i);
			double lat = r.getLat();
			double lon = r.getLng();
			String name = r.getName();%>
			<script type="text/javascript">restoPos.push(new google.maps.LatLng(<%=lat%>, <%=lon%>));</script>
			<script type="text/javascript">restoArray.push('<%=name%>');</script>
		<%
		}
	}
	%>
	
</head>
<body onload="initializeMapPlaces(restoPos, restoArray, 12)">

	<div class="container">

	<div class="row">
        <div class="col-xs-12 col-sm-12">
          <div class="jumbotron shadow background-grey">
            <h1 class="center">Where are we going this weekend?</h1>
            <form role="form" action="PlacesListAction" method="post" class="shadow padding20 margin20">
			  <div class="input-group">
			    <input type="text" name="city_name" class="form-control" id="city_name" placeholder="Input a city name, i.e.: Melbourne" value="">
			 	<span class="input-group-btn"><button type="submit" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-search"></span></button></span>
			  </div>
             <br>
			</form>
            <% if(city != null) {
            %>
            <h1 class="center"><%=city %> it is!</h1>
            <%} %>
          </div>
        </div>
    </div>
    
      <%
      if(placesByType != null){
   	  %>

    <div class="row">
       <div class="col-xs-12">
         <div class="shadow padding10">
           <div id="map_places" style="height:500px;"></div>
         </div>
       </div>
     </div>
          
     <!-- Restaurants -->
     <div class="margin20 row center">
          <div class="col-xs-12">
       	  	<ul class="nav nav-pills">
			  <li class="active"><a href="#restaurants" role="tab" data-toggle="tab"><h1><span class="glyphicon glyphicon-cutlery"></span> Top Restaurants</h1></a></li>
			  <li><a href="#attractions" role="tab" data-toggle="tab"><h1><span class="glyphicon glyphicon-camera"></span> Top Attractions</h1></a></li>
			  <li><a href="#pubs" role="tab" data-toggle="tab"><h1><span class="glyphicon glyphicon-glass"></span> Top Pubs</h1></a></li>
			</ul>
          </div>
      </div>

	  <div class="row">
          <div class="tab-content">

          <div class="tab-pane active" id="restaurants">
          <%
	          for(int i=0; i<Math.min(10, restoPlaces.size()); i++){
	        	  Place p = restoPlaces.get(i);
	          %>
	            <div id="resto_<%=i %>">
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2><%=p.getName() %></h2>
	              <h4><span class="glyphicon glyphicon-heart"></span> <%=p.getRating()==null? "N/A":p.getRating()+"/5" %></h4>
	              <h4><span class="glyphicon glyphicon-usd"></span> <%=p.getPrice()==null? "N/A":p.getPrice()+"/5" %></h4>
	              <p><span class="glyphicon glyphicon-home"></span> <%=p.getAddress() %></p>
	              </div><!--/span-->
	            </div>
	            </div>
	          <%
	          }%>
          </div>
          
          <div class="tab-pane" id="attractions">
          <%
	          for(int i=0; i<Math.min(10, attractionPlaces.size()); i++){
	        	  Place p = attractionPlaces.get(i);
	          %>
	            <div id="attraction_<%=i %>">
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2><%=p.getName() %></h2>
	              <h4><span class="glyphicon glyphicon-heart"></span> <%=p.getRating()==null? "N/A":p.getRating()+"/5" %></h4>
	              <h4><span class="glyphicon glyphicon-usd"></span> <%=p.getPrice()==null? "N/A":p.getPrice()+"/5" %></h4>
	              <p><span class="glyphicon glyphicon-home"></span> <%=p.getAddress() %></p>
	              </div><!--/span-->
	            </div>
	            </div>
	          <%
	          }
          %>
          </div>
          
          <div class="tab-pane" id="pubs">
          <%
	          for(int i=0; i<Math.min(10, pubPlaces.size()); i++){
	        	  Place p = pubPlaces.get(i);
	          %>
	            <div id="pub_<%=i %>">
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2><%=p.getName() %></h2>
	              <h4><span class="glyphicon glyphicon-heart"></span> <%=p.getRating()==null? "N/A":p.getRating()+"/5" %></h4>
	              <h4><span class="glyphicon glyphicon-usd"></span> <%=p.getPrice()==null? "N/A":p.getPrice()+"/5" %></h4>
	              <p><span class="glyphicon glyphicon-home"></span> <%=p.getAddress() %></p>
	              </div><!--/span-->
	            </div>
	            </div>
	          <%
	          }
          %>
          </div>
          
          </div><!--/row-->
        </div><!--/span-->
        
     <%} %>
          
     </div>
	
</body>
</html>
