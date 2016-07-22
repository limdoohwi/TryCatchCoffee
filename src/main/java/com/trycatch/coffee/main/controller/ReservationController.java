package com.trycatch.coffee.main.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.trycatch.coffee.menu.service.MenuService;

@Controller
public class ReservationController {
	@Inject
	MenuService service;
	
	@RequestMapping("/go.reservation")
	public ModelAndView reservationGet(){
		ModelAndView view = new ModelAndView("reservation/Reservation");
		view.addObject("check", "drink");
		view.addObject("menucategoryList", service.getMenuCategoryList());
		view.addObject("menuList", service.getMenuList());
		return view;
	}
}
