








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
    
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

	<script type="text/javascript">
		// Global variable for Google Maps API
		var positions = new Array();
		var countriesArray = new Array();
		
	</script>
	
</head>
<body>
    <div class="container">

	<div class="row">
        <div class="col-xs-12 col-sm-12">
          <div class="jumbotron shadow background-grey">
            <h1>Where are we going this weekend?</h1>
            <form role="form" action="PlacesListAction" method="post" class="shadow padding20">
			  <div class="form-group">
			    <label for="exampleInputEmail1">Input a city name:</label>
			    <input type="text" name="city_name" class="form-control" id="city_name" placeholder="i.e., Melbourne" value="">
			  </div>
              <button type="submit" class="btn btn-primary" style="float: right;"><span class="glyphicon glyphicon-search"></span></button>
			  <br>
			</form>
          </div>
         </div>
      </div>
      
      <div class="row">
            <div class="col-lg-12">
              <div class="shadow padding10">
                <div id="map_countries" style="height:500px;"></div>
              </div>
            </div>
          </div>
          
          <!-- Restaurants -->
          <div class="row">
          
          <div class="col-xs-12">
          <h1>Top Restaurants</h1>
          </div>
          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Zio's Restaurant</h2>
	              <h4><span class="glyphicon glyphicon-heart"></span> 4.3/5</h4>
	              <h4><span class="glyphicon glyphicon-euro"></span> 2/5</h4>
	              <p><span class="glyphicon glyphicon-home"></span> 14 Lansdowne St, East Melbourne VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Caffe e Cucina</h2>
	              <h4>4.2</h4>
	              <h4>3</h4>
	              <p>581 Chapel St, South Yarra VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Enoteca Sileno</h2>
	              <h4>4.2</h4>
	              <h4>N/A</h4>
	              <p>920 Lygon Street, Carlton North VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Centonove</h2>
	              <h4>4.2</h4>
	              <h4>3</h4>
	              <p>109 Cotham Rd, Kew VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Melba Restaurant</h2>
	              <h4>4.2</h4>
	              <h4>3</h4>
	              <p>1 Southgate Ave, Southbank VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Quaff</h2>
	              <h4>4.1</h4>
	              <h4>3</h4>
	              <p>436 Toorak Road, Toorak VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Q.P.O. Cafe Bar Restaurant</h2>
	              <h4>4.1</h4>
	              <h4>2</h4>
	              <p>186 High St, Kew VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Hellenic Republic Brunswick</h2>
	              <h4>4.1</h4>
	              <h4>2</h4>
	              <p>434 Lygon St, Brunswick East VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Bistro Thierry</h2>
	              <h4>4.0</h4>
	              <h4>2</h4>
	              <p>511 Malvern Rd, Toorak VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Romeo's of Toorak</h2>
	              <h4>4.0</h4>
	              <h4>N/A</h4>
	              <p>450 Toorak Rd, Toorak VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Steer Bar & Grill</h2>
	              <h4>3.9</h4>
	              <h4>3</h4>
	              <p>637 Chapel St, South Yarra VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Two Fat Indians - East Melbourne</h2>
	              <h4>3.9</h4>
	              <h4>2</h4>
	              <p>166 Wellington Parade, Melbourne VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Kent Hotel</h2>
	              <h4>3.9</h4>
	              <h4>N/A</h4>
	              <p>370 Rathdowne St, Carlton North VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>World Restaurant & Bar</h2>
	              <h4>3.6</h4>
	              <h4>1</h4>
	              <p>Shop 4, Building 2, Riverside Qy, Southbank VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Bluestone Restaurant Bar</h2>
	              <h4>3.5</h4>
	              <h4>N/A</h4>
	              <p>349 Flinders Ln, Melbourne VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Skinny Dog Hotel</h2>
	              <h4>3.3</h4>
	              <h4>1</h4>
	              <p>155 High St, Kew VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Bridie O'Reilly's</h2>
	              <h4>3.1</h4>
	              <h4>1</h4>
	              <p>462 Chapel St, South Yarra VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Fiorelli Restaurant</h2>
	              <h4>N/A</h4>
	              <h4>2</h4>
	              <p>209 Camberwell Rd, Hawthorn East VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Bistro Gitan</h2>
	              <h4>N/A</h4>
	              <h4>N/A</h4>
	              <p>52 Toorak Rd W, South Yarra VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
	            <div class="col-6 col-sm-12 col-lg-4">
	              <div class="shadow padding20">
	              <h2>Di Palma's</h2>
	              <h4>N/A</h4>
	              <h4>2</h4>
	              <p>686 High St, Kew East VIC, Australia</p>
	            </div><!--/span-->
	            </div>
	          
          </div><!--/row-->
        </div><!--/span-->
</body>
</html>
