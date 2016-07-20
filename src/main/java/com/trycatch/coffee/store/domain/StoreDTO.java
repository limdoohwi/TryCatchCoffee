package com.trycatch.coffee.store.domain;

public class StoreDTO {
	private int store_no;
	private String store_name;
	private String store_addr;
	private int member_no;
	private String member_name;
	private int meeting_room;
	private String store_ip;
	private int profit;
	private String search_store_value;

	public String getSearch_store_value() {
		return search_store_value;
	}

	public void setSearch_store_value(String search_store_value) {
		this.search_store_value = search_store_value;
	}

	public int getProfit() {
		return profit;
	}

	public void setProfit(int profit) {
		this.profit = profit;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getStore_no() {
		return store_no;
	}

	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getStore_addr() {
		return store_addr;
	}

	public void setStore_addr(String store_addr) {
		this.store_addr = store_addr;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public int getMeeting_room() {
		return meeting_room;
	}

	public void setMeeting_room(int meeting_room) {
		this.meeting_room = meeting_room;
	}

	public String getStore_ip() {
		return store_ip;
	}

	public void setStore_ip(String store_ip) {
		this.store_ip = store_ip;
	}

}
