package dto;

public class DiaryDto {
	private String diaryDate; //0000-00-00
	private String diaryMemo; //짧은 일정 메모
	public DiaryDto(String diaryDate, String diaryMemo) {
		this.diaryDate = diaryDate;
		this.diaryMemo = diaryMemo;
	}
	
	public String getDiaryDate() {
		return diaryDate;
	}
	public void setDiaryDate(String diaryDate) {
		this.diaryDate = diaryDate;
	}
	public String getDiaryMemo() {
		return diaryMemo;
	}
	public void setDiaryMemo(String diaryMemo) {
		this.diaryMemo = diaryMemo;
	}
	@Override
	public String toString() {
		return "DiaryDto [diaryDate=" + diaryDate + ", diaryMemo=" + diaryMemo + "]";
	}
}