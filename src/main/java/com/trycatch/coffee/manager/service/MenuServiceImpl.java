package com.trycatch.coffee.manager.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.manager.domain.MenuDTO;
import com.trycatch.coffee.manager.persitance.MenuDAO;
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
	public boolean insertMenu(MenuDTO dto) {
		return dao.insertMenu(dto);
	}

	@Override
	public void deleteMenu(int member_no) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateMenu(MenuDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<MenuDTO> getMenuList() {
		// TODO Auto-generated method stub
		return null;
	}

}
