/*
 * 
 * 
 * 
 */

package com.trycatch.coffee.board.recipe.persistance;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.board.recipe.domain.BoardRecipeDTO;
import com.trycatch.coffee.board.recipe.service.BoardRecipeService;


@Service
public class BoardRecipeServiceImpl implements BoardRecipeService {
	
	@Inject
	private BoardRecipeDAO dao;	

	
	
	@Override
	public void insertBoardRecipe(BoardRecipeDTO dto) throws Exception {
		dao.insertBoardRecipe(dto);
	}

	@Override
	public BoardRecipeDTO readBoardRecipe(Integer board_recipe_no) throws Exception {
		return dao.readBoardRecipe(board_recipe_no);
	}

	@Override
	public void updateBoardRecipe(BoardRecipeDTO dto) throws Exception {
		dao.updateBoardRecipe(dto);
	}

	@Override
	public void deleteBoardRecipe(Integer board_recipe_no) throws Exception {
		dao.deleteBoardRecipe(board_recipe_no);
	}

	@Override
	public List<BoardRecipeDTO> listAllBoardRecipe() throws Exception {
		return dao.listAllBoardRecipe();
	}

	@Override
	public void updateBoardRecipeCount(Integer board_recipe_no) throws Exception {
		dao.updateBoardRecipeCount(board_recipe_no);
	}

	@Override
	public void updateBoardRecipeLikes(Integer board_recipe_no) throws Exception {
		dao.updateBoardRecipeLikes(board_recipe_no);
	}

	@Override
	public List<BoardRecipeDTO> searchBoardRecipe(String board_recipe_search) throws Exception {
		return dao.searchBoardRecipe(board_recipe_search);
	}





}
