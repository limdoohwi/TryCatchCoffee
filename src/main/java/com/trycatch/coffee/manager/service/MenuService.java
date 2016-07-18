package com.trycatch.coffee.manager.service;

import java.util.List;

import com.trycatch.coffee.manager.domain.MenuDTO;

public interface MenuService {
	public boolean insertMenuCategory(String menu_category_name);
	public int getMenuCategorynum(String menu_cateogyr_name);
	public boolean insertMenu(MenuDTO dto);
	public void deleteMenu(int member_no);
	public void updateMenu(MenuDTO dto);
	public List<MenuDTO> getMenuList();
}
