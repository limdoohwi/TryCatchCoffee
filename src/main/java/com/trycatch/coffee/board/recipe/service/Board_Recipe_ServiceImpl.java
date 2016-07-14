package com.trycatch.coffee.board.recipe.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.rtycatch.coffee.board.recipe.domain.Board_RecipeDTO;
import com.rtycatch.coffee.board.recipe.persistance.Board_RecipeDAO;


@Service
public class Board_Recipe_ServiceImpl implements Board_Recipe_Service {
	
	@Inject
	private Board_RecipeDAO dat;

}
