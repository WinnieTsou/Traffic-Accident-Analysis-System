package orm;

import java.util.Date;

public class Died {
	private int casenum;
	private int vnumber;
	private int pnumber;
	private Date time;
	
	
	public Died(int casenum, int vnumber, int pnumber, Date time) {
		super();
		this.casenum = casenum;
		this.vnumber = vnumber;
		this.pnumber = pnumber;
		this.time = time;
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
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
}
