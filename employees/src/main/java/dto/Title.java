package dto;
//title
public class Title {
	//복합키 PK(empNo + title + fromDate)
	private int emp_no;
	private String title;
	private String fromDate;
	private String toDate;
	
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
		return "Title [emp_no=" + emp_no + ", title=" + title + ", fromDate=" + fromDate + ", toDate=" + toDate + "]";
	}
}