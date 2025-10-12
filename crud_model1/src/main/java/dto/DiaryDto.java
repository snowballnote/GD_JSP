package dto;
	
public class DiaryDto {
	private int diaryNo;
	private String  diaryDate;
	private String diaryTitle;
	private String diaryContent;
	private String createdate;
	public int getDiaryNo() {
		return diaryNo;
	}
	public void setDiaryNo(int diaryNo) {
		this.diaryNo = diaryNo;
	}
	public String getDiaryDate() {
		return diaryDate;
	}
	public void setDiaryDate(String diaryDate) {
		this.diaryDate = diaryDate;
	}
	public String getDiaryTitle() {
		return diaryTitle;
	}
	public void setDiaryTitle(String diaryTitle) {
		this.diaryTitle = diaryTitle;
	}
	public String getDiaryContent() {
		return diaryContent;
	}
	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "DiaryDto [diaryNo=" + diaryNo + ", diaryDate=" + diaryDate + ", diaryTitle=" + diaryTitle
				+ ", diaryContent=" + diaryContent + ", createdate=" + createdate + "]";
	}
}
