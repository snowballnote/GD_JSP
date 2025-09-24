package dto;

public class Person {
	private String province;
	private String city;
	public Person(String province, String city) {
		this.province = province;
		this.city = city;
	}
	
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}	
}
