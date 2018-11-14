package orm;

public class Crash_factor {
	private int casenum;
	private int crash_factor_code;
	
	public Crash_factor(int casenum, int crash_factor_code) {
		super();
		this.casenum = casenum;
		this.crash_factor_code = crash_factor_code;
	}

	public int getCasenum() {
		return casenum;
	}

	public void setCasenum(int casenum) {
		this.casenum = casenum;
	}

	public int getCrash_factor_code() {
		return crash_factor_code;
	}

	public void setCrash_factor_code(int crash_factor_code) {
		this.crash_factor_code = crash_factor_code;
	}
	
}
