package com.trycatch.coffee.meeting_room.domain;

public class MeetingRoomDTO {
	private int meeting_no;
	private int store_no;

	public int getMeeting_no() {
		return meeting_no;
	}

	public int getStore_no() {
		return store_no;
	}

	public void setMeeting_no(int meeting_no) {
		this.meeting_no = meeting_no;
	}

	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}

}
