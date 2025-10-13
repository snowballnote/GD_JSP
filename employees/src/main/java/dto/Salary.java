package dto;
//salary
public class Salary {
	//복합키 PK(emoNo + fromDate)
	//FK - employees.emp_no
	private int emp_no;
	private String fromDate;
	private String toDate;
	private int salary;
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
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
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	@Override
	public String toString() {
		return "Salary [emp_no=" + emp_no + ", fromDate=" + fromDate + ", toDate=" + toDate + ", salary=" + salary
				+ "]";
	}
}
