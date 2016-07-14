package com.trycatch.coffee.member.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.persitance.MemberDAO;
import com.trycatch.coffee.member.service.MemberService;

@Controller
@SessionAttributes("member_dto")
public class LoginController {
	@Inject
	private MemberService service;
	
	@RequestMapping(value= "/login.member", method=RequestMethod.GET)
	public String reqeustGet(){
		return "member/Log-In";
	}
	
	@RequestMapping(value= "/login.member", method=RequestMethod.POST)
	public ModelAndView reqeustPost(@RequestParam("member_email")String member_email,@RequestParam("member_pw")String member_pw) throws Exception{
		ModelAndView view = null; 
		MemberDTO member_dto =service.login(member_email, member_pw);
		if(member_dto==null){
			view =new ModelAndView("member/Log-In");
			view.addObject("login_success", false);
		}
		else{
			view = new ModelAndView("Main");
			view.addObject("login_success", true);
			view.addObject("member_dto", member_dto);
		}
		return view;
	}
}
