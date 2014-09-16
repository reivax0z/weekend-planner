package reivax.norac.topfive.webapp;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class GooglePlacesHelper {

	private static final String SEARCH_URL = "https://maps.googleapis.com/maps/api/place/textsearch/xml?query=";
	private static final String	KEY = "&key=AIzaSyAJvQMqlkgEd8jEHDGs76e3jdEtllMkX-g";
	private static final String IN = "+in+";

	public static List<Place> getAllPlacesFromGoogle(PlaceType keyword, String city) throws ExceptionProcessing, ExceptionNoCity{
		List<Place> toReturn = new ArrayList<Place>();
		
		String cityNoSpace = city.replaceAll(" ", "+");

		String urlPlacesString = SEARCH_URL + keyword + IN + cityNoSpace + KEY;
		System.out.println("Query= "+urlPlacesString);

		try {
			URL url = new URL(urlPlacesString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/xml");

			if (conn.getResponseCode() != 200) {
				throw new ExceptionProcessing(/*"Failed : HTTP error code : "
						+ conn.getResponseCode()*/);
			}

			//Get and parse
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			//			Document doc = dBuilder.parse("/WEB-INF/test.xml");
			Document doc = dBuilder.parse(conn.getInputStream());
			doc.getDocumentElement().normalize();
			conn.disconnect();

			Element status = (Element) doc.getElementsByTagName("status").item(0);

			if(!status.getFirstChild().getNodeValue().equalsIgnoreCase("OK")){
//				throw new RuntimeException("No city matched for the request: '"+city+"'");
				throw new ExceptionNoCity();
			}

			//Set
			NodeList nList = doc.getElementsByTagName("result");

			for (int temp = 0; temp < nList.getLength(); temp++) {

				Place place = new Place();

				Element eElement = (Element) nList.item(temp);

				String name = eElement.getElementsByTagName("name").item(0).getFirstChild().getNodeValue();
				String address = eElement.getElementsByTagName("formatted_address").item(0).getFirstChild().getNodeValue();
				Double rating = null;
				if(eElement.getElementsByTagName("rating").item(0) != null){
					rating = Double.valueOf(eElement.getElementsByTagName("rating").item(0).getFirstChild().getNodeValue());
				}
				Integer price = null;
				if(eElement.getElementsByTagName("price_level").item(0) != null){
					price = Integer.valueOf(eElement.getElementsByTagName("price_level").item(0).getFirstChild().getNodeValue());
				}

				place.setAddress(address);
				place.setName(name);
				place.setPrice(price);
				place.setRating(rating);
				place.setType(keyword);

				NodeList nLGeo = eElement.getElementsByTagName("location");
				Element eLat = (Element) nLGeo.item(0);

				Double lat = Double.valueOf(eLat.getElementsByTagName("lat").item(0).getFirstChild().getNodeValue());
				Double lng = Double.valueOf(eLat.getElementsByTagName("lng").item(0).getFirstChild().getNodeValue());

				place.setLat(lat);
				place.setLng(lng);

				toReturn.add(place);
			}
		} catch (IOException e) {
			throw new ExceptionProcessing();
		} catch (ParserConfigurationException e){
			throw new ExceptionProcessing();
		} catch (SAXException e){
			throw new ExceptionProcessing();
		}
		return toReturn;
	}

	public static void main(String[] args) throws ExceptionProcessing, ExceptionNoCity{
		getAllPlacesFromGoogle(PlaceType.RESTAURANT, "Melbourne");
	}
}
