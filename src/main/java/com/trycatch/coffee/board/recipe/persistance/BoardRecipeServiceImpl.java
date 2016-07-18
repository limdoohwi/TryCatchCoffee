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
	public BoardRecipeDTO readBoardRecipe(Integer bno) throws Exception {
		return dao.readBoardRecipe(bno);
	}

	@Override
	public void updateBoardRecipe(BoardRecipeDTO dto) throws Exception {
		dao.updateBoardRecipe(dto);
	}

	@Override
	public void deleteBoardRecipe(Integer bno) throws Exception {
		dao.deleteBoardRecipe(bno);
	}

	@Override
	public List<BoardRecipeDTO> listAllBoardRecipe() throws Exception {
		return dao.listAllBoardRecipe();
	}



}
