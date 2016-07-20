package com.trycatch.coffee.menu.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.menu.service.MenuService;

@Controller
public class DeleteMenuController {
	@Inject
	private MenuService service;
	
	@RequestMapping("/delete.menu")
	@ResponseBody
	public boolean deleteMenu(int menu_num){
		return service.deleteMenu(menu_num);
	}
}
