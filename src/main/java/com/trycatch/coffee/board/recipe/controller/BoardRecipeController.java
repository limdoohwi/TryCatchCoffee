package com.trycatch.coffee.board.recipe.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.trycatch.coffee.board.recipe.domain.BoardRecipeDTO;
import com.trycatch.coffee.board.recipe.service.BoardRecipeService;

@Controller
public class BoardRecipeController {

	@Inject
	private BoardRecipeService service;
	
	
	//listAll (GET) 게시글 전체 보기
	@RequestMapping("/community/Recipe_List")
	public void ListAllBoardRecipeGET(Model model) throws Exception{		
		model.addAttribute("recipelist",service.listAllBoardRecipe());
	} 
		
	//insert (GET) 게시글 쓰기 페이지로 이동
	@RequestMapping(value="/community.recipe_insert",method=RequestMethod.GET)
	public String InsertBoardRecipeGET(){
		
		return "/community/Recipe_Insert";
	}
		
	//insert (POST) 게시글 올리기
	@RequestMapping(value="/community.recipe_insert",method=RequestMethod.POST)
	public String InsertBoardRecipe_POST(BoardRecipeDTO dto) throws Exception{
		service.insertBoardRecipe(dto);
		return "redirect:/community/Recipe_List";
	}
	
	//read (GET) 게시글 읽기
	@RequestMapping("/community.recipe_read")
	public String ReadBoardRecipe(int board_recipe_no , Model model) throws Exception{
		model.addAttribute(service.readBoardRecipe(board_recipe_no));
		return "/community/Recipe_Read";
	}
	
	//modify (GET) 게시글 수정 페이지로 이동
	@RequestMapping(value="/community.recipe_modify",method=RequestMethod.GET)
	public String ModifyBoardRecipeGET(int board_recipe_no ,Model model) throws Exception{
		model.addAttribute(service.readBoardRecipe(board_recipe_no));
		return "/community/Recipe_Modify";
	}
	
	//modify (POST) 게시글 수정 후 해당하는 게시글 보기
	@RequestMapping(value="/community.recipe_modify",method=RequestMethod.POST)
	public String ModifyBoardRecipePOST(int board_recipe_no,BoardRecipeDTO dto) throws Exception{
		service.updateBoardRecipe(dto);
		System.out.println("인서트성공");
		return "redirect:/community.recipe_read?board_recipe_no="+board_recipe_no;
	}
	
	//delete  게시글 삭제
	@RequestMapping("/communty.recipe_delete")
	public String ModifyBoardDelete(int board_recipe_no) throws Exception{
		service.deleteBoardRecipe(board_recipe_no);
		return "redirect:/community/Recipe_List";
	}
}
