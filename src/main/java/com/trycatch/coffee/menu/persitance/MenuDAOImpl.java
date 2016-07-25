package com.trycatch.coffee.menu.persitance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.menu.domain.MenuDTO;

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
	public List<String> getMenuCategoryList() {
		return sqlSession.selectList(NAMESPACE+".getMenuCategoryList");
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
	public boolean deleteMenu(int menu_num) {
		try{
			sqlSession.delete(NAMESPACE+".deleteMenu", menu_num);
			return true;
		}catch(Exception err){
			return false;
		}
	}

	@Override
	public void updateMenu(MenuDTO dto) {
		sqlSession.update(NAMESPACE + ".updateMenu", dto);

	}

	@Override
	public List<MenuDTO> getMenuList() {
		try {
			return sqlSession.selectList(NAMESPACE + ".getMenuList");
		} catch (Exception err) {
			err.printStackTrace();
			return null;
		}
	}



}
