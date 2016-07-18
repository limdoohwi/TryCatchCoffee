package com.trycatch.coffee.member.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.persitance.MemberDAO;
import com.trycatch.coffee.member.service.MemberService;

@Controller
public class RegisterController {
	@Inject
	MemberService service;
	
	@RequestMapping(value="/register.member", method = RequestMethod.GET)
	public String requestGet(){
		return "member/Register";
	}
	@RequestMapping(value="/register.member", method = RequestMethod.POST)
	public ModelAndView requestPost(@ModelAttribute MemberDTO dto) throws Exception{
		ModelAndView view = new ModelAndView("redirect:/");
		boolean register_success = service.register(dto);
		view.addObject("register_success",register_success);
		return view;
	}
}
