package reivax.norac.topfive.webapp;

import java.util.Comparator;

public class ComparatorPlaces implements Comparator<Place>{

	public int compare(Place arg0,	Place arg1) {
		if(arg0.getRating() == null){
			return 1;
		}
		if(arg1.getRating() == null){
			return -1;
		}
		return -Double.valueOf(arg0.getRating()).compareTo(arg1.getRating());
	}
}
