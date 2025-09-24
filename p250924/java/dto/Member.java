//Member.java
package dto;

import java.util.List;

public class Member {
	//필드 -> 필드를 비노출 -> 정보은닉
	private String id;
	private String pw;
	private String name;
	private String birth;
	private int num;
	private Gender gender; //enum
	private List<String> hobby;
	private String mail;
	private String memo;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public Gender getGender() {
		return gender;
	}
	public void setGender(Gender gender) {
		this.gender = gender;
	}
	public List<String> getHobby() {
		return hobby;
	}
	public void setHobby(List<String> hobby) {
		this.hobby = hobby;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Override
	public String toString() {
		return "Member [id=" + id + ", pw=" + pw + ", name=" + name + ", birth=" + birth + ", num=" + num + ", gender="
				+ gender + ", hobby=" + hobby + ", mail=" + mail + ", memo=" + memo + "]";
	}
	
	
	// 외부에서 간접적으로 은닉된 필드를 읽기접근 -> 캡슐화
//	public String readId() {
//		return this.id;
//	}
	
	//외부에서 간접적으로 은닉된 필드를 쓰기 -> 캡슐화
//	public void writeId(String newId) {
//		this.id = newId;
//	}
	
}
