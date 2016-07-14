package com.rtycatch.coffee.board.recipe.persistance;

import java.util.List;

import com.rtycatch.coffee.board.recipe.domain.Board_RecipeDTO;
import com.trycatch.coffee.member.domain.MemberDTO;




public interface Board_RecipeDAO {
	  public void insertBoard_Recipe(Board_RecipeDTO dto) throws Exception;
	  public Board_RecipeDTO readBoard_Recipe(Integer bno) throws Exception;
	  public void updateBoard_Recipe(Board_RecipeDTO dto) throws Exception;
	  public void deleteBoard_Recipe(Integer bno) throws Exception;
	  public List<Board_RecipeDTO> listAll() throws Exception;
	
}

