package com.trycatch.coffee.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ManagerController {
	@RequestMapping("/go.manager")
	public String managerGet(){
		return "manager/Manager";
	}
}
