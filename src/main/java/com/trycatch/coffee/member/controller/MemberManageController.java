package com.trycatch.coffee.member.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.trycatch.coffee.member.service.MemberService;

@Controller
public class MemberManageController {
	@Inject
	private MemberService service;
	
	@RequestMapping("/member.manager")
	public String managerGet(Model model) throws Exception{
		model.addAttribute("memberList", service.getMemberList());
		model.addAttribute("check", "member");
		return "manager/Manager";
	}
	
	@RequestMapping("/search.member.manager")
	public String searchMember(Model model, String member_email) throws Exception{
		model.addAttribute("memberList", service.getMember_email_like(member_email));
		model.addAttribute("check", "member");
		return "manager/Manager";
	}
}
