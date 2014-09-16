package reivax.norac.topfive.webapp;


import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CountriesServlet
 */
//@WebServlet(name="/PlacesList", urlPatterns={"/PlacesListAction", "/Home"})
public class PlacesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor. 
	 */
	public PlacesServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processData(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processData(request, response);
	}

	private void processData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Get back the city name from the request
		String cityName = request.getParameter("city_name");

		if(cityName != null){

			try{
			
				// Call Google Places
				List<Place> restos = GooglePlacesHelper.getAllPlacesFromGoogle(PlaceType.RESTAURANT, cityName);
				Collections.sort(restos, new ComparatorPlaces());
				restos = restos.subList(0, 10);
				
				List<Place> attractions = GooglePlacesHelper.getAllPlacesFromGoogle(PlaceType.ATTRACTION, cityName);
				Collections.sort(attractions, new ComparatorPlaces());
				attractions = attractions.subList(0, 10);
				
				List<Place> pubs = GooglePlacesHelper.getAllPlacesFromGoogle(PlaceType.PUB, cityName);
				Collections.sort(pubs, new ComparatorPlaces());
				pubs = pubs.subList(0, 10);
	
				Map<PlaceType, List<Place>> placesByType = new HashMap<PlaceType, List<Place>>();
				placesByType.put(PlaceType.RESTAURANT, restos);
				placesByType.put(PlaceType.ATTRACTION, attractions);
				placesByType.put(PlaceType.PUB, pubs);
	
				// Forward the info to the appropriate JSP
				request.setAttribute("placesByType", placesByType);
				
			}catch(ExceptionNoCity e){
				request.setAttribute("isInError", Boolean.TRUE);
				request.setAttribute("errorType", ErrorType.ERROR_NOCITY);
				request.setAttribute("city", cityName);
				request.getRequestDispatcher("DisplayPlaces.jsp").forward(request, response);
				return;
			}catch(ExceptionProcessing e){
				request.setAttribute("isInError", Boolean.TRUE);
				request.setAttribute("errorType", ErrorType.ERROR_PROCESSING);
				request.getRequestDispatcher("DisplayPlaces.jsp").forward(request, response);
				return;
			}
			
			request.setAttribute("city", cityName);
		}

		request.setAttribute("isInError", Boolean.FALSE);
		request.getRequestDispatcher("DisplayPlaces.jsp").forward(request, response);
	}

}
