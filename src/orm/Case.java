package orm;

import java.util.Date;

public class Case {
	private int casenum;
	private Date accident_date;
	private int city_id;
	private int county_id;
	private double latitude;
	private double longitude;
	private int collision_type;
	private int holiday_related;
	private boolean is_NHS_related;
	private int junction_related;
	private int light_condition;
	private int route_signing;
	private int intersection_type;

	public Case(int casenum, Date accident_date, int city_id, int county_id, double latitude, double longitude,
			int collision_type, int holiday_related, boolean is_NHS_related, int junction_related, int light_condition,
			int route_signing, int intersection_type) {
		super();
		this.casenum = casenum;
		this.accident_date = accident_date;
		this.city_id = city_id;
		this.county_id = county_id;
		this.latitude = latitude;
		this.longitude = longitude;
		this.collision_type = collision_type;
		this.holiday_related = holiday_related;
		this.is_NHS_related = is_NHS_related;
		this.junction_related = junction_related;
		this.light_condition = light_condition;
		this.route_signing = route_signing;
		this.intersection_type = intersection_type;
	}

	public int getCasenum() {
		return casenum;
	}

	public void setCasenum(int casenum) {
		this.casenum = casenum;
	}

	public Date getAccident_date() {
		return accident_date;
	}

	public void setAccident_date(Date accident_date) {
		this.accident_date = accident_date;
	}

	public int getCity_id() {
		return city_id;
	}

	public void setCity_id(int city_id) {
		this.city_id = city_id;
	}

	public int getCounty_id() {
		return county_id;
	}

	public void setCounty_id(int county_id) {
		this.county_id = county_id;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public int getCollision_type() {
		return collision_type;
	}

	public void setCollision_type(int collision_type) {
		this.collision_type = collision_type;
	}

	public int getHoliday_related() {
		return holiday_related;
	}

	public void setHoliday_related(int holiday_related) {
		this.holiday_related = holiday_related;
	}

	public boolean isIs_NHS_related() {
		return is_NHS_related;
	}

	public void setIs_NHS_related(boolean is_NHS_related) {
		this.is_NHS_related = is_NHS_related;
	}

	public int getJunction_related() {
		return junction_related;
	}

	public void setJunction_related(int junction_related) {
		this.junction_related = junction_related;
	}

	public int getLight_condition() {
		return light_condition;
	}

	public void setLight_condition(int light_condition) {
		this.light_condition = light_condition;
	}

	public int getRoute_signing() {
		return route_signing;
	}

	public void setRoute_signing(int route_signing) {
		this.route_signing = route_signing;
	}

	public int getIntersection_type() {
		return intersection_type;
	}

	public void setIntersection_type(int intersection_type) {
		this.intersection_type = intersection_type;
	}

}
