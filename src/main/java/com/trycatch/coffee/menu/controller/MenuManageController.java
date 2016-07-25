package com.trycatch.coffee.menu.controller;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.trycatch.coffee.menu.service.MenuService;

@Controller
public class MenuManageController {
	@Inject
	private MenuService service;
	
	@RequestMapping("/menu.manager")
	public ModelAndView menumanageGet(@ModelAttribute String nowPage_MenuManage, @ModelAttribute String nowBlock_MenuManage){
		ModelAndView view = new ModelAndView("manager/Manager");
		view.addObject("check", "menu");
		view.addObject("menucategoryList", service.getMenuCategoryList());
		view.addObject("menuList", service.getMenuList());
		return view;
	}
}
