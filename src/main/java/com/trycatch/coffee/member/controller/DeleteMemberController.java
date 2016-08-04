package com.trycatch.coffee.member.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.member.service.MemberService;

@Controller
public class DeleteMemberController {
	@Inject
	private MemberService service;
	
	@RequestMapping("/delete.member.manage")
	public @ResponseBody boolean deleteMember(int member_no) throws Exception{
		return service.deleteMember(member_no);
	}
}
