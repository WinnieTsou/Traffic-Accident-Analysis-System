package orm;

public class Alcohol_test {
	private int casenum;
	private int vnumber;
	private int pnumber;
	private int test_type;
	private int result;

	public Alcohol_test(int casenum, int vnumber, int pnumber, int test_type, int result) {
		super();
		this.casenum = casenum;
		this.vnumber = vnumber;
		this.pnumber = pnumber;
		this.test_type = test_type;
		this.result = result;
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

	public int getTest_type() {
		return test_type;
	}

	public void setTest_type(int test_type) {
		this.test_type = test_type;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

}
