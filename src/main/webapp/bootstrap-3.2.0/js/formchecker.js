function validateForm()
{
   var input = document.places_form.city_name.value;
   if( input == "" || citiesList.indexOf(input) == -1 )
   {
     showError();
     return false;
   } else if(/^[A-Za-z]+/.test(input) == false
		   || checkString(input) == false){
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
function checkString(input) {
    for (var i=0; i<input.length; i++) {
        if (input.charCodeAt(i) > 127) {
            return false;
        }
    }
    return true;
}