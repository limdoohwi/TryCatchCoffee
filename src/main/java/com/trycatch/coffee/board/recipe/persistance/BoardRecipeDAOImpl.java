package com.trycatch.coffee.board.recipe.persistance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.board.recipe.domain.BoardRecipeDTO;


@Repository
public class BoardRecipeDAOImpl implements BoardRecipeDAO {

	@Inject
	private SqlSession sqlSession;
	
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.boardrecipeMapper";

     
	//insert
	@Override
	public void insertBoardRecipe(BoardRecipeDTO dto) throws Exception {
		sqlSession.insert(NAMESPACE +".boardrecipeinsert",dto);
	}

	//read
	@Override
	public BoardRecipeDTO readBoardRecipe(Integer board_recipe_no) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".boardreciperead",board_recipe_no);
	}

	//update
	@Override
	public void updateBoardRecipe(BoardRecipeDTO dto) throws Exception {
		sqlSession.update(NAMESPACE + ".boardrecipemodify" , dto);
	}

	//delete
	@Override
	public void deleteBoardRecipe(Integer board_recipe_no) throws Exception {
		sqlSession.delete(NAMESPACE + ".boardrecipedelete" , board_recipe_no);
	}
	
	//listAll
	@Override
	public List<BoardRecipeDTO> listAllBoardRecipe() throws Exception {
		
		return sqlSession.selectList(NAMESPACE+".boardrecipelist");
	}

	//Count ++
	@Override
	public void updateBoardRecipeCount(Integer board_recipe_no) throws Exception {
		sqlSession.update(NAMESPACE+".boardrecipecount");
	}

	//Likes ++
	@Override
	public void updateBoardRecipeLikes(Integer board_recipe_no) throws Exception {
		sqlSession.update(NAMESPACE+".boardrecipelikes");
	}

	@Override
	public List<BoardRecipeDTO> searchBoardRecipe(String board_recipe_search) throws Exception {
		return sqlSession.selectList(NAMESPACE+".boardrecipesearch");	
	}


	


}
