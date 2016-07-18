package com.trycatch.coffee.meeting_room.domain;

public class MeetingRoomReservationDTO {
	private int meeting_reservation_no;
	private int meeting_no;
	private int member_no;
	private int meeting_reservation_time;
	private String meeting_reservation_date;
	private String meeting_order_date;

	public int getMeeting_reservation_no() {
		return meeting_reservation_no;
	}

	public int getMeeting_no() {
		return meeting_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public int getMeeting_reservation_time() {
		return meeting_reservation_time;
	}

	public String getMeeting_reservation_date() {
		return meeting_reservation_date;
	}

	public String getMeeting_order_date() {
		return meeting_order_date;
	}

	public void setMeeting_reservation_no(int meeting_reservation_no) {
		this.meeting_reservation_no = meeting_reservation_no;
	}

	public void setMeeting_no(int meeting_no) {
		this.meeting_no = meeting_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public void setMeeting_reservation_time(int meeting_reservation_time) {
		this.meeting_reservation_time = meeting_reservation_time;
	}

	public void setMeeting_reservation_date(String meeting_reservation_date) {
		this.meeting_reservation_date = meeting_reservation_date;
	}

	public void setMeeting_order_date(String meeting_order_date) {
		this.meeting_order_date = meeting_order_date;
	}

}
