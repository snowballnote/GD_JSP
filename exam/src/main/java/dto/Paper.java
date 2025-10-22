package dto;

public class Paper {
	private int paperId;
	private int studentId;
	private int questionId;
	private int paperAnswer;
	private String createdate;
	
	public int getPaperId() {
		return paperId;
	}
	public void setPaperId(int paperId) {
		this.paperId = paperId;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getPaperAnswer() {
		return paperAnswer;
	}
	public void setPaperAnswer(int paperAnswer) {
		this.paperAnswer = paperAnswer;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "Paper [paperId=" + paperId + ", studentId=" + studentId + ", questionId=" + questionId
				+ ", paperAnswer=" + paperAnswer + ", createdate=" + createdate + "]";
	}
}
