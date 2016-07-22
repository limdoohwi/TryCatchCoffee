package com.trycatch.coffee.board.client.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.fabric.xmlrpc.base.Param;
import com.trycatch.coffee.board.client.domain.BoardDTO;
import com.trycatch.coffee.board.client.service.BoardService;
import com.trycatch.coffee.main.controller.HomeController;


@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private BoardService service;
	
	//리스트 페이지로 이동
	@RequestMapping("/board/list")
	public String listAll(Model model, String keyValue, String keyWord, HttpServletRequest req)
			throws Exception{
			if(keyWord == null){
				model.addAttribute("list", service.listAll());	
			}
			else{
				model.addAttribute("list", service.search(keyValue, keyWord));
				
				model.addAttribute("keyWord", keyWord);
			}
			return "/board/list";
	}
	
	// 새로운 글쓰기 페이지로 이동
	@RequestMapping("/insert.client.board")
	public String registerGET(){
		return "/board/post";
	}
	
	//새로운글 저장후 리스트 페이지로 이동
	@RequestMapping(value="/post.client.board",method=RequestMethod.POST)
	public String registerPOST(BoardDTO board, RedirectAttributes rttr, int member_no) throws Exception{
		service.insert(board, member_no);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/list";
	}
	
	//읽기 페이지로 이동
	@RequestMapping("/read.client.board")
	public String read(BoardDTO board ,Model model) throws Exception{
		BoardDTO dto = service.read(board);
		String board_content = dto.getBoard_content();
		String replace_board_content = board_content.replace("\n", "<br/>");
		model.addAttribute("board_content", replace_board_content);
		model.addAttribute("board", service.read(board));
		model.addAttribute("board_password", board);
		return "/board/read";
	}
	
	//수정 페이지로 이동
	@RequestMapping("/update.client.board")
	public String update_page(BoardDTO board, Model model) throws Exception{
		model.addAttribute("board", service.read(board));
		return "/board/update";
	}
	
	//수정 내용 저장 후 리스트 페이지로 이동
	@RequestMapping(value="/update.submit.client.board")
	public String update(BoardDTO board, RedirectAttributes rttr) throws Exception{
		service.update(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/list";
	}

	//삭제 후 리스트 페이지로 이동
	@RequestMapping(value="/delete.client.board", method=RequestMethod.POST)
	public String remove(BoardDTO board, RedirectAttributes rttr, int board_num) throws Exception{
		service.delete_reply(board);
		service.delete(board_num);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/list";
	}
	
	//답글 페이지로 이동
	@RequestMapping("/reply.client.board")
	public String replyGET(String board_password, Model model){
		model.addAttribute("board_password", board_password);
		return "/board/reply";
	}
	
	//답글 저장 후 리스트 페이지로 이동
	@RequestMapping(value="/insert.reply.client.board", method=RequestMethod.POST)
	public String replyPOST(BoardDTO board, RedirectAttributes rttr, int member_no, int parent_board_num, int board_group) throws Exception{
		service.reply(board, member_no, parent_board_num, board_group);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/list";
	}
	
	//비밀번호 입력 페이지로 이동
	@RequestMapping(value="/pass.client.board")
	public String passGet(BoardDTO board, String board_password ,Model model) throws Exception{
		model.addAttribute("board", service.read(board));
		return "/board/password_check";
	}
	
	//비밀번호 확인 후 맞으면 읽기 페이지로 이동, 틀리면 다시 비밀번호 입력페이지로 이동
	@RequestMapping(value="/password.check.client.board")
	public String check_password(BoardDTO board, Model model, String board_password, String board_num) throws Exception{
		BoardDTO vo = service.check_password(board_password, board_num);
		model.addAttribute("board", service.read(board));
		if(vo!=null){
			return "/board/read";
		}
		else{
			return "/board/password_check";
		}
	}
}
