package com.trycatch.coffee.manager.persitance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.manager.domain.MenuDTO;

@Repository
public class MenuDAOImpl implements MenuDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.menuMapper";
	@Override
	public boolean insertMenuCategory(String menu_category_name) {
		try{
			sqlSession.insert(NAMESPACE +".insertMenucategory",menu_category_name);
			return true;
		}catch(Exception err){
			System.out.println("실패 : " + err);
			return false;
		}
	}

	@Override
	public int getMenuCategorynum(String menu_category_name) {
		return sqlSession.selectOne(NAMESPACE +".getMenucategorynum", menu_category_name);
	}

	

	@Override
	public boolean insertMenu(MenuDTO dto) {
		try{
			sqlSession.insert(NAMESPACE +".insertMenu", dto);
			return true;
		}catch(Exception err){
		return false;}
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
