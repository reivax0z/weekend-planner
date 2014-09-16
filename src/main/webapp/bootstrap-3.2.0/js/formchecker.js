function validateForm()
{
 
   if( document.places_form.city_name.value == "" )
   {
     showError();
     return false;
   } else if(/^[A-Za-z]+$/.test(document.places_form.city_name.value) == false){
	   showError();
	   return false;
   }
   hideError();
   return true;
}
function showError()
{
	document.getElementById('error_form').style.display = 'block';
}
function hideError()
{
	document.getElementById('error_form').style.display = 'none';
}