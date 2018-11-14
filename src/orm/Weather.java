package orm;

public class Weather {
	private int casenum;
	private int weather_code;

	public Weather(int casenum, int weather_code) {
		super();
		this.casenum = casenum;
		this.weather_code = weather_code;
	}

	public int getCasenum() {
		return casenum;
	}

	public void setCasenum(int casenum) {
		this.casenum = casenum;
	}

	public int getWeather_code() {
		return weather_code;
	}

	public void setWeather_code(int weather_code) {
		this.weather_code = weather_code;
	}

}
