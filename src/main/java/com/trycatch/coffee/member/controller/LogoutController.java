package com.trycatch.coffee.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LogoutController {
	@RequestMapping("/logout.member")
	public String Logout(HttpServletRequest req){
		req.getSession().removeAttribute("member_dto");
		req.getSession().removeAttribute("store_dto");
		return "redirect:/";
	}
}
