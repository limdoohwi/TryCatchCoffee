package com.trycatch.coffee.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MenuManageController {
	@RequestMapping("/menu.manager")
	public ModelAndView menumanageGet(){
		ModelAndView view = new ModelAndView("manager/Manager");
		view.addObject("check", "menu");
		return view;
	}
}
