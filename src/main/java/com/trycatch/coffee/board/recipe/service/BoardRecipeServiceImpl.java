/*
 * 
 * 
 * 
 */

package com.trycatch.coffee.board.recipe.service;

import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.trycatch.coffee.board.recipe.domain.BoardRecipeDTO;
import com.trycatch.coffee.board.recipe.persistance.BoardRecipeDAO;


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
	public List<BoardRecipeDTO> listAllBoardRecipe(Integer limit) throws Exception {
		return dao.listAllBoardRecipe(limit);
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
	public List<BoardRecipeDTO> searchBoardRecipe(String board_recipe_search,int limit) throws Exception {
		return dao.searchBoardRecipe(board_recipe_search,limit);
	}

	@Override
	public List<BoardRecipeDTO> listAllBoardRecipe() throws Exception {
		return dao.listAllBoardRecipe();
	}

	@Override
	public List<BoardRecipeDTO> boardrecipelistall_with_memberNo_date(int member_no, int start_page, String date) throws Exception {
		return dao.boardrecipelistall_with_memberNo_date(member_no, start_page, date);
	}



}
