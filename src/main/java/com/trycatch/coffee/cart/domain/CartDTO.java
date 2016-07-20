package com.trycatch.coffee.cart.domain;

public class CartDTO {
	private int cart_no;	
	private int member_no;
	private int menu_num;
	private String menu_name;
	private int menu_price;
	/**
	 * @return the menu_price
	 */
	public int getMenu_price() {
		return menu_price;
	}
	/**
	 * @param menu_price the menu_price to set
	 */
	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	private int menu_count;
	
	@Override
	public String toString() {
		return "CartDTO [cart_no=" + cart_no + ", member_no=" + member_no + ", menu_num=" + menu_num + ", menu_name="
				+ menu_name + ", menu_count=" + menu_count + "]";
	}
	public int getCart_no() {
		return cart_no;
	}
	/**
	 * @param cart_no the cart_no to set
	 */
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}
	/**
	 * @return the member_no
	 */
	public int getMember_no() {
		return member_no;
	}
	/**
	 * @param member_no the member_no to set
	 */
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	/**
	 * @return the menu_num
	 */
	public int getMenu_num() {
		return menu_num;
	}
	/**
	 * @param menu_num the menu_num to set
	 */
	public void setMenu_num(int menu_num) {
		this.menu_num = menu_num;
	}
	/**
	 * @return the menu_name
	 */
	public String getMenu_name() {
		return menu_name;
	}
	/**
	 * @param menu_name the menu_name to set
	 */
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	/**
	 * @return the menu_count
	 */
	public int getMenu_count() {
		return menu_count;
	}
	/**
	 * @param menu_count the menu_count to set
	 */
	public void setMenu_count(int menu_count) {
		this.menu_count = menu_count;
	}
}
