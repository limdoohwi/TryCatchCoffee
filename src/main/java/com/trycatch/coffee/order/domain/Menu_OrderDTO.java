package com.trycatch.coffee.order.domain;

public class Menu_OrderDTO {
	private int menu_order_no;
	private int menu_payment_no;
	private String menu_no;
	private String menu_count;
	private String menu_price;
	private String menu_option;
	private String menu_name;

	public String getMenu_price() {
		return menu_price;
	}

	public void setMenu_price(String menu_price) {
		this.menu_price = menu_price;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public int getMenu_order_no() {
		return menu_order_no;
	}

	public void setMenu_order_no(int menu_order_no) {
		this.menu_order_no = menu_order_no;
	}

	public int getMenu_payment_no() {
		return menu_payment_no;
	}

	public void setMenu_payment_no(int menu_payment_no) {
		this.menu_payment_no = menu_payment_no;
	}

	public String getMenu_count() {
		return menu_count;
	}

	public void setMenu_count(String menu_count) {
		this.menu_count = menu_count;
	}

	public String getMenu_option() {
		return menu_option;
	}

	public void setMenu_option(String menu_option) {
		this.menu_option = menu_option;
	}

	public String getMenu_no() {
		return menu_no;
	}

	public void setMenu_no(String menu_nos) {
		this.menu_no = menu_nos;
	}
}
