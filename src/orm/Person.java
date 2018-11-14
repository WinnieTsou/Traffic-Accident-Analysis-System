package orm;

public class Person {
	private int casenum;
	private int vnumber;
	private int pnumber;
	private int ptype;
	private int sex;
	private int age;
	private int race;
	private int injury;

	public Person(int casenum, int vnumber, int pnumber, int ptype, int sex, int age, int race, int injury) {
		super();
		this.casenum = casenum;
		this.vnumber = vnumber;
		this.pnumber = pnumber;
		this.ptype = ptype;
		this.sex = sex;
		this.age = age;
		this.race = race;
		this.injury = injury;
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

	public int getPnumber() {
		return pnumber;
	}

	public void setPnumber(int pnumber) {
		this.pnumber = pnumber;
	}

	public int getPtype() {
		return ptype;
	}

	public void setPtype(int ptype) {
		this.ptype = ptype;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getRace() {
		return race;
	}

	public void setRace(int race) {
		this.race = race;
	}

	public int getInjury() {
		return injury;
	}

	public void setInjury(int injury) {
		this.injury = injury;
	}

}
