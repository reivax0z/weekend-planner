$(document).ready(function() {
 var citiesList = [];
 
 $.ajax({
   type: "GET",
   url: "./cities.xml", // change to full path of file on server
   dataType: "xml",
   success: parseXml,
   complete: setupAC,
   failure: function(data) {
     alert("XML File could not be found");
   }
 });
 
 function parseXml(xml)
 {
   //find every query value
   $(xml).find("city").each(function()
   {
	   citiesList.push(this.textContent/*innerHTML*/);
   });
 }
 
 function setupAC() {
   $("#city_name").autocomplete({
   source: citiesList,
   minLength: 1,
   select: function(event, ui) {
     $("#city_name").val(ui.item.value);
     $("#places_form").submit();
   }
  });
 }
});