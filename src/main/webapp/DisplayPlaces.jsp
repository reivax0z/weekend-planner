<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="reivax.norac.topfive.webapp.*" %>

<%
// RETRIEVE THE MAIN OBJECT
String city = (String) request.getAttribute("city");
Boolean isInError = (Boolean) request.getAttribute("isInError");
ErrorType errorType = (ErrorType) request.getAttribute("errorType");
Map<PlaceType, List<Place>> placesByType = (Map<PlaceType, List<Place>>) request.getAttribute("placesByType");
List<Place> restoPlaces = placesByType!=null?placesByType.get(PlaceType.RESTAURANT):null;
List<Place> attractionPlaces = placesByType!=null?placesByType.get(PlaceType.ATTRACTION):null;
List<Place> pubPlaces = placesByType!=null?placesByType.get(PlaceType.PUB):null;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" prefix="og: http://ogp.me/ns#">
<head>
<meta charset="ISO-8859-1">
	<meta name="title" content="Weekend Planner - Top 10 Places">
	<meta name="description" content="Weekend Planner - A web app providing top 10 places for the preparation of weekend adventure (featuring a choice of restaurants, attractions and pubs)">
	<meta name="keywords" content="Travel, weekend planner">
    <meta name="author" content="Xavier CARON">
	
	<meta property="og:title" content="Weekend Planner - Top 10 Places" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="xaviertraveltips.herokuapp.com" />
	<meta property="og:description" content="Weekend Planner - A web app providing top 10 places for the preparation of weekend adventure (featuring a choice of restaurants, attractions and pubs)" />
	<meta property="og:image" content="http://xavier.w.caron.free.fr/website/resources/img/weekend-planner/cover_top_10.JPG" />
	<meta property="og:image:type" content="image/jpeg" />
	<meta property="og:image:width" content="150" />
	<meta property="og:image:height" content="150" />
	
	<meta name="twitter:card" content="summary" />
	<meta name="twitter:title" content="Weekend Planner - Top 10 Places" />
	<meta name="twitter:description" content="Weekend Planner - A web app providing top 10 places for the preparation of weekend adventure (featuring a choice of restaurants, attractions and pubs)" />
	<meta name="twitter:creator" content="@Xavier_w_Caron" />
	<meta name="twitter:image:src" content="http://xavier.w.caron.free.fr/website/resources/img/weekend-planner/cover_top_10.JPG" />
	<meta name="twitter:image:width" content="150" />
	<meta name="twitter:image:height" content="150" />
	
	
    <link rel="shortcut icon" href="http://xavier.w.caron.free.fr/website/resources/img/icon/globe.ico">


	<title>Weekend Planner - Top 10 Places</title>

	<!-- CSS -->
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <link href="./bootstrap-3.2.0/dist/css/bootstrap.css" rel="stylesheet">
    <link href="./bootstrap-3.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- JQUERY -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<!--     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script> -->
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.js"></script>
    
    <!-- BOOTSTRAP -->
    <script type="text/javascript" src="./bootstrap-3.2.0/dist/js/bootstrap.js"></script>    
    
    <!-- MY JS FILES -->
    <script type="text/javascript" src="./bootstrap-3.2.0/js/googlemapshelper.js"></script>
    <script type="text/javascript" src="./bootstrap-3.2.0/js/formchecker.js"></script>
    <script type="text/javascript" src="./bootstrap-3.2.0/js/autocomplete.js"></script>
    
    <!-- GOOGLE MAPS -->
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
			<script type="text/javascript">restoArray.push("<%=name%>");</script>
		<%
		}
	}
	if(attractionPlaces != null){
		for(int i=0; i<attractionPlaces.size(); i++){
			Place r = attractionPlaces.get(i);
			double lat = r.getLat();
			double lon = r.getLng();
			String name = r.getName();%>
			<script type="text/javascript">attractionPos.push(new google.maps.LatLng(<%=lat%>, <%=lon%>));</script>
			<script type="text/javascript">attractionArray.push("<%=name%>");</script>
		<%
		}
	}
	if(pubPlaces != null){
		for(int i=0; i<pubPlaces.size(); i++){
			Place r = pubPlaces.get(i);
			double lat = r.getLat();
			double lon = r.getLng();
			String name = r.getName();%>
			<script type="text/javascript">pubPos.push(new google.maps.LatLng(<%=lat%>, <%=lon%>));</script>
			<script type="text/javascript">pubArray.push("<%=name%>");</script>
		<%
		}
	}
	%>
	
</head>
<body onload="initializeMapPlaces(restoPos, restoArray, 13, 0)">

	<div class="container">

	<div class="row">
        <div class="col-xs-12 col-sm-12">
          <div class="jumbotron shadow background-grey" style="background-color:#E7E7E7; background: url('http://xavier.w.caron.free.fr/website/resources/img/weekend-planner/cover_top_10.JPG') no-repeat center center; background-size: cover;">
            <% if(city != null) {
            %>
            <h1 style="color:white"><%=city %> it is!</h1>
            <h2 style="color:white">Or maybe something else?</h2>
            <%} else{%>
            <h1 style="color:white">Where are we going this weekend?</h1>
            <%} %>
            <form role="form" action="PlacesListAction" id="places_form" name="places_form" method="post" onsubmit="return(validateForm());" class="shadow padding20 margin20">
			  <div class="input-group">
			  	<span class="input-group-addon">Input a city name:</span>
			    <input type="text" name="city_name" class="form-control" id="city_name" placeholder="i.e., Melbourne" value="">
			 	<span class="input-group-btn">
			 		<button type="submit" class="btn btn-primary">
			 			<span class="glyphicon glyphicon-search"></span> Search
		 			</button>
	 			</span>
			  </div>
			</form>
          </div>
        </div>
    </div>
    
    <div class="row">
    	<div class="col-xs-12">
    	<% if(isInError) {
            %>
			
			<%if(errorType.equals(ErrorType.ERROR_NOCITY)){ %>
			<div id="error_nocity" class="alert alert-danger" role="alert">
      			<strong>Oh snap!</strong> No city <%=city!=null?"'"+city+"' ":"" %>found...
    		</div>
    		<% }else if(errorType.equals(ErrorType.ERROR_PROCESSING)){%>
    		
    		<div id="error_processing" class="alert alert-danger" role="alert">
      			<strong>Oh snap!</strong> Something went wrong, sorry about that. Try the service again.
    		</div>
    		<%} %>
    		
    		<%} else{%>
    		
    		<div id="error_form" class="alert alert-warning" role="alert" style="display:none">
    		<p><strong>Oh snap!</strong>  Invalid form format, change it a bit and try submitting again.</p>
      			<p>Make sure you are not using non UTF-8 characters (e.g.: &ccedil;, &eacute;, &agrave;, &icirc;...)</p>
    		</div>
    		<%} %>
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
       	  	<ul class="nav nav-pills" style="display:inline-table">
			  <li class="active"><a href="#restaurants" onclick="initializeMapPlaces(restoPos, restoArray, 12, 0);" role="tab" data-toggle="tab"><h1><span class="glyphicon glyphicon-cutlery"></span> Top Restaurants</h1></a></li>
			  <li><a href="#attractions" onclick="initializeMapPlaces(attractionPos, attractionArray, 12, 1);" role="tab" data-toggle="tab"><h1><span class="glyphicon glyphicon-camera"></span> Top Attractions</h1></a></li>
			  <li><a href="#pubs" onclick="initializeMapPlaces(pubPos, pubArray, 12, 2);" role="tab" data-toggle="tab"><h1><span class="glyphicon glyphicon-glass"></span> Top Pubs</h1></a></li>
			</ul>
          </div>
      </div>

	  <div class="row">
          <div class="tab-content">

          <div class="tab-pane active" id="restaurants">
          <%
	          for(int i=0; i<restoPlaces.size(); i++){
	        	  Place p = restoPlaces.get(i);
	          %>
	            <a href="#map_places" onclick="bounceAndCenter(0, <%=i%>);">
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
	            </a>
	          <%
	          }%>
          </div>
          
          <div class="tab-pane" id="attractions">
          <%
	          for(int i=0; i<attractionPlaces.size(); i++){
	        	  Place p = attractionPlaces.get(i);
	          %>
	           <a href="#map_places" onclick="bounceAndCenter(1, <%=i%>);">
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
	            </a>
	          <%
	          }
          %>
          </div>
          
          <div class="tab-pane" id="pubs">
          <%
	          for(int i=0; i<pubPlaces.size(); i++){
	        	  Place p = pubPlaces.get(i);
	          %>
	          <a href="#map_places" onclick="bounceAndCenter(2, <%=i%>);">
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
	            </a>
	          <%
	          }
          %>
          </div>
          
          </div><!--/row-->
        </div><!--/span-->
        
     <%} %>
          
       <hr>

      <footer>
        <p>Data and rankings based on <i>Google Places</i>. Design adapted from <i>Bootstrap</i>.</p>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>© <a href="http://www.linkedin.com/in/xavierwilfriddimitrycaron" target="_blank"><b>Xavier CARON</b></a>, 2014</p>
      </footer>

    </div><!--/.container-->
	
</body>
</html>
