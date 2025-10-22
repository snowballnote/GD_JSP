package dto;

public class ExamResult {
	private int categoryId;
	private int studentId;
	private double score;
	private String createdate;
	
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "ExamResult [categoryId=" + categoryId + ", studentId=" + studentId + ", score=" + score
				+ ", createdate=" + createdate + "]";
	}
}
