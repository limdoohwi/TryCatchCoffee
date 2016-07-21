package com.trycatch.coffee.board.recipe.persistance;

import java.util.List;

import com.trycatch.coffee.board.recipe.domain.BoardRecipeDTO;
import com.trycatch.coffee.member.domain.MemberDTO;




public interface BoardRecipeDAO {
	  public void insertBoardRecipe(BoardRecipeDTO dto) throws Exception;
	  public BoardRecipeDTO readBoardRecipe(Integer board_recipe_no) throws Exception;
	  public void updateBoardRecipe(BoardRecipeDTO dto) throws Exception;
	  public void deleteBoardRecipe(Integer board_recipe_no) throws Exception;
	  public List<BoardRecipeDTO> listAllBoardRecipe() throws Exception;
	  public void updateBoardRecipeCount(Integer board_recipe_no) throws Exception;
	  public void updateBoardRecipeLikes(Integer board_recipe_no) throws Exception;
	  public List<BoardRecipeDTO> searchBoardRecipe(String board_recipe_search) throws Exception;
}

