package com.trycatch.coffee.menu.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.menu.domain.MenuDTO;
import com.trycatch.coffee.menu.persitance.MenuDAO;
@Service
public class MenuServiceImpl implements MenuService {
	@Inject
	private MenuDAO dao;
	
	
	@Override
	public boolean insertMenuCategory(String menu_category_name) {
		return dao.insertMenuCategory(menu_category_name);
	}

	@Override
	public int getMenuCategorynum(String menu_category_name) {
		return dao.getMenuCategorynum(menu_category_name);
	}
	
	@Override
	public List<String> getMenuCategoryList() {
		return dao.getMenuCategoryList();
	}

	@Override
	public boolean insertMenu(MenuDTO dto) {
		return dao.insertMenu(dto);
	}

	@Override
	public boolean deleteMenu(int menu_num) {
		return dao.deleteMenu(menu_num);
	}

	@Override
	public void updateMenu(MenuDTO dto) {
		dao.updateMenu(dto);

	}

	@Override
	public List<MenuDTO> getMenuList() {
		return dao.getMenuList();
	}

}
