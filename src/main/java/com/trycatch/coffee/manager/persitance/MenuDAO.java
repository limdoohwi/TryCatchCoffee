package com.trycatch.coffee.manager.persitance;

import java.util.List;

import com.trycatch.coffee.manager.domain.MenuDTO;



public interface MenuDAO {
	public boolean insertMenuCategory(String menu_category_name);
	public int getMenuCategorynum(String menu_category_name);
	public boolean insertMenu(MenuDTO dto);
	public void deleteMenu(int member_no);
	public void updateMenu(MenuDTO dto);
	public List<MenuDTO> getMenuList();
}
