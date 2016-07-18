package com.trycatch.coffee.board.client.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.board.client.domain.BoardVO;
import com.trycatch.coffee.board.client.service.BoardService;
import com.trycatch.coffee.main.controller.HomeController;


@Controller
public class BoardController {
	//private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping("/board/List")
	public void listAll(Model model) throws Exception{
		System.out.println("test");
		model.addAttribute("List", service.listAll());
	}
	
	@RequestMapping("/insert.client.board")
	public String registerGET(){
		return "/board/post";
	}
	
	@RequestMapping(value="/post.client.board",method=RequestMethod.POST)
	public String registerPOST(BoardVO board, RedirectAttributes rttr) throws Exception{
		//logger.info("insertPOST : " + board.toString());
		service.insert(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/List";
	}
	
	@RequestMapping("/read.client.board")
	public String read(int board_num, String board_password ,Model model) throws Exception{
		model.addAttribute("board", service.read(board_num, board_password));
		return "/board/read";
	}
	
	@RequestMapping("/update.client.board")
	public String modify(BoardVO board, Model model) throws Exception{
		model.addAttribute("board");
		return "/board/update";
	}
	
	@RequestMapping(value="/update.submit.client.board", method=RequestMethod.POST)
	public String update(BoardVO board, RedirectAttributes rttr) throws Exception{
		service.update(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/List";
	}
	
	@RequestMapping(value="/delete.client.board", method=RequestMethod.POST)
	public String remove(int board_num, RedirectAttributes rttr) throws Exception{
		service.delete(board_num);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/List";
	}
	
	@RequestMapping("/reply.client.board")
	public String passGET(){
		return "board/reply";
	}
	
	@RequestMapping(value="/insert.reply.client.board", method=RequestMethod.POST)
	public String replyPOST(BoardVO board, RedirectAttributes rttr) throws Exception{
		service.reply(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/List";
	}
	
}
