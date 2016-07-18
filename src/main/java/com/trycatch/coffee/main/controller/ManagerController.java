package com.trycatch.coffee.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ManagerController {
	@RequestMapping("/go.manager")
	public ModelAndView managerGet(){
		ModelAndView view = new ModelAndView("manager/Manager");
		view.addObject("check", "manager");
		return view;
	}
}
