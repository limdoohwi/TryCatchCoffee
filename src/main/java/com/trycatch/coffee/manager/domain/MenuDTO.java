package com.trycatch.coffee.manager.domain;

public class MenuDTO {
	private int menu_num;
	private String menu_name;
	private int menu_price;
	private int menu_category_num;
	private String menu_category_name;
	private String menu_image;
	public int getMenu_num() {
		return menu_num;
	}
	public void setMenu_num(int menu_num) {
		this.menu_num = menu_num;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public int getMenu_price() {
		return menu_price;
	}
	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	public int getMenu_category_num() {
		return menu_category_num;
	}
	public void setMenu_category_num(int menu_category_num) {
		this.menu_category_num = menu_category_num;
	}
	public String getMenu_category_name() {
		return menu_category_name;
	}
	public void setMenu_category_name(String menu_category_name) {
		this.menu_category_name = menu_category_name;
	}
	public String getMenu_image() {
		return menu_image;
	}
	public void setMenu_image(String menu_image) {
		this.menu_image = menu_image;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "MenuDTO [menu_num=" + menu_num + ", menu_name=" + menu_name + ", menu_price=" + menu_price
				+ ", menu_category_num=" + menu_category_num + ", menu_category_name=" + menu_category_name
				+ ", menu_image=" + menu_image + "]";
	}
	
	
}
