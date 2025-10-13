package dto;
//dept_emp
public class DeptEmpDto {
	//복합키 PK(empNo + deptNo)
	//FK : Forien Key - employees.emp_no : 부모
	private int empNo;
	//FK - employees.dept_no
	private String deptNo;
	private String fromDate;
	private String toDate;
	
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	@Override
	public String toString() {
		return "DeptEmp [empNo=" + empNo + ", deptNo=" + deptNo + ", fromDate=" + fromDate + ", toDate=" + toDate + "]";
	}
}
