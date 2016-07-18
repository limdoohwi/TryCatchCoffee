package com.trycatch.coffee.member.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.service.MemberService;

@Controller
public class LoginController {
	@Inject
	private MemberService service;
	
	@RequestMapping(value= "/login.member", method=RequestMethod.GET)
	public String reqeustGet(){
		return "member/Log-In";
	}
	
	@RequestMapping(value= "/login.member", method=RequestMethod.POST)
	public String reqeustPost(HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		String member_email = req.getParameter("member_email");
		String member_pw = req.getParameter("member_pw");
		MemberDTO member_dto =service.login(member_email, member_pw);
		if(member_dto==null){
			rttr.addFlashAttribute("login_success", false);
			return "redirect:/login.member";
		}
		else{
			rttr.addFlashAttribute("login_success", true);
			req.getSession().setAttribute("member_dto", member_dto);
			
			return "redirect:/";
		}
		
	}
}
