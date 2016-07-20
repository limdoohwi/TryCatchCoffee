package com.trycatch.coffee.board.recipe.service;

import java.util.List;

import com.trycatch.coffee.board.recipe.domain.BoardRecipeDTO;

public interface BoardRecipeService {
	  public void insertBoardRecipe(BoardRecipeDTO dto) throws Exception;
	  public BoardRecipeDTO readBoardRecipe(Integer bno) throws Exception;
	  public void updateBoardRecipe(BoardRecipeDTO dto) throws Exception;
	  public void deleteBoardRecipe(Integer bno) throws Exception;
	  public List<BoardRecipeDTO> listAllBoardRecipe() throws Exception;
	  public void updateBoardRecipeCount(Integer bno) throws Exception;
	  public void updateBoardRecipeLikes(Integer bno) throws Exception;
}
