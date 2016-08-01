package com.trycatch.coffee.order.domain;

public class Menu_PaymentDTO {
	private int menu_payment_no;
	private int member_no;
	private String menu_reserve_time;
	private String menu_payment_style;
	private int menu_total_price;
	private int menu_total_mileage;
	private String menu_payment_date;
	private String order_name;
	private String order_tel;
	private int store_no;
	private String store_name;

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public int getMenu_payment_no() {
		return menu_payment_no;
	}

	public void setMenu_payment_no(int menu_payment_no) {
		this.menu_payment_no = menu_payment_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getMenu_reserve_time() {
		return menu_reserve_time;
	}

	public void setMenu_reserve_time(String menu_reserve_time) {
		this.menu_reserve_time = menu_reserve_time;
	}

	public String getMenu_payment_style() {
		return menu_payment_style;
	}

	public void setMenu_payment_style(String menu_payment_style) {
		this.menu_payment_style = menu_payment_style;
	}

	public int getMenu_total_price() {
		return menu_total_price;
	}

	public void setMenu_total_price(int menu_total_price) {
		this.menu_total_price = menu_total_price;
	}

	public int getMenu_total_mileage() {
		return menu_total_mileage;
	}

	public void setMenu_total_mileage(int menu_total_mileage) {
		this.menu_total_mileage = menu_total_mileage;
	}

	public String getMenu_payment_date() {
		return menu_payment_date;
	}

	public void setMenu_payment_date(String menu_payment_date) {
		this.menu_payment_date = menu_payment_date;
	}

	public String getOrder_name() {
		return order_name;
	}

	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}

	public String getOrder_tel() {
		return order_tel;
	}

	public void setOrder_tel(String order_tel) {
		this.order_tel = order_tel;
	}

	public int getStore_no() {
		return store_no;
	}

	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}

}
