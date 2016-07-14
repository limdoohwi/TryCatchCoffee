package com.rtycatch.coffee.board.recipe.persistance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import com.rtycatch.coffee.board.recipe.domain.Board_RecipeDTO;

public class Board_RecipeDAOImpl implements Board_RecipeDAO {

	@Inject
	private SqlSession sqlSession;
	
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.board_recipeMapper";

     
	@Override
	public void insertBoard_Recipe(Board_RecipeDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Board_RecipeDTO readBoard_Recipe(Integer bno) throws Exception {
		return null;
	}


	@Override
	public void updateBoard_Recipe(Board_RecipeDTO dto) throws Exception {
		
	}


	@Override
	public void deleteBoard_Recipe(Integer bno) throws Exception {
		
	}

	@Override
	public List<Board_RecipeDTO> listAll() throws Exception {
		return null;
	} 
	


}
