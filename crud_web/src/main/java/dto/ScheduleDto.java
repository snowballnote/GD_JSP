package dto;

public class ScheduleDto {
	private int scheduleNo;
	private String scheduleDate;
	private String scheduleTitle;
	private String scheduleContent;
	private String createdate;
	
	public int getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public String getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getScheduleTitle() {
		return scheduleTitle;
	}
	public void setScheduleTitle(String scheduleTitle) {
		this.scheduleTitle = scheduleTitle;
	}
	public String getScheduleContent() {
		return scheduleContent;
	}
	public void setScheduleContent(String scheduleContent) {
		this.scheduleContent = scheduleContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "ScheduleDto [scheduleNo=" + scheduleNo + ", scheduleDate=" + scheduleDate + ", scheduleTitle="
				+ scheduleTitle + ", scheduleContent=" + scheduleContent + ", createdate=" + createdate + "]";
	}
	
	
	
}
