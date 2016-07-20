package com.trycatch.coffee.member.domain;

public class MemberDTO {
	private int member_no;
    private String member_email;
    private String member_pw;
    private String member_name;
    private String member_tel;
    private String member_birth;
    private int member_mileage;
    private String member_regdate;
    private int member_code;
    
    
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "MemberDTO [member_no=" + member_no + ", member_email=" + member_email + ", member_pw=" + member_pw
				+ ", member_name=" + member_name + ", member_tel=" + member_tel + ", member_birth=" + member_birth
				+ ", member_mileage=" + member_mileage + ", member_regdate=" + member_regdate + ", member_code="
				+ member_code + "]";
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_tel() {
		return member_tel;
	}
	public void setMember_tel(String member_tel) {
		this.member_tel = member_tel;
	}
	public String getMember_birth() {
		return member_birth;
	}
	public void setMember_birth(String member_birth) {
		this.member_birth = member_birth;
	}
	public int getMember_mileage() {
		return member_mileage;
	}
	public void setMember_mileage(int member_mileage) {
		this.member_mileage = member_mileage;
	}
	public String getMember_regdate() {
		return member_regdate;
	}
	public void setMember_regdate(String member_regdate) {
		this.member_regdate = member_regdate;
	}
	public int getMember_code() {
		return member_code;
	}
	public void setMember_code(int member_code) {
		this.member_code = member_code;
	} 
}
