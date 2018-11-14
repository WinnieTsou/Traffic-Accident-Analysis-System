package orm;

public class Vehicle {
	private int casenum;
	private int vnumber;
	private int manufacturer;
	private int year;
	private int type;
	private int airbag_deployed;
	private boolean fire_occurred;
	private int speed;
	private int is_speeding;
	private boolean is_drowsy_driving;

	public Vehicle(int casenum, int vnumber, int manufacturer, int year, int type, int airbag_deployed,
			boolean fire_occurred, int speed, int is_speeding, boolean is_drowsy_driving) {
		super();
		this.casenum = casenum;
		this.vnumber = vnumber;
		this.manufacturer = manufacturer;
		this.year = year;
		this.type = type;
		this.airbag_deployed = airbag_deployed;
		this.fire_occurred = fire_occurred;
		this.speed = speed;
		this.is_speeding = is_speeding;
		this.is_drowsy_driving = is_drowsy_driving;
	}

	public int getCasenum() {
		return casenum;
	}

	public void setCasenum(int casenum) {
		this.casenum = casenum;
	}

	public int getVnumber() {
		return vnumber;
	}

	public void setVnumber(int vnumber) {
		this.vnumber = vnumber;
	}

	public int getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(int manufacturer) {
		this.manufacturer = manufacturer;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getAirbag_deployed() {
		return airbag_deployed;
	}

	public void setAirbag_deployed(int airbag_deployed) {
		this.airbag_deployed = airbag_deployed;
	}

	public boolean isFire_occurred() {
		return fire_occurred;
	}

	public void setFire_occurred(boolean fire_occurred) {
		this.fire_occurred = fire_occurred;
	}

	public int getSpeed() {
		return speed;
	}

	public void setSpeed(int speed) {
		this.speed = speed;
	}

	public int getIs_speeding() {
		return is_speeding;
	}

	public void setIs_speeding(int is_speeding) {
		this.is_speeding = is_speeding;
	}

	public boolean isIs_drowsy_driving() {
		return is_drowsy_driving;
	}

	public void setIs_drowsy_driving(boolean is_drowsy_driving) {
		this.is_drowsy_driving = is_drowsy_driving;
	}

}
