package com.trycatch.coffee.menu.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.menu.domain.MenuDTO;
import com.trycatch.coffee.menu.service.MenuService;

@Controller
public class InsertMenuController {
	@Inject
	private MenuService service;
	
	private ServletContext ctx;
	@RequestMapping("/insert.menu.manager")
	public ModelAndView InsertMenu(MultipartHttpServletRequest req, RedirectAttributes rttr) throws IllegalStateException, IOException{
		ModelAndView view = new ModelAndView("redirect:/menu.manager");
		// 파일 저장
		ctx = req.getServletContext();
		Map<String, MultipartFile> files = req.getFileMap();
		CommonsMultipartFile cmf = (CommonsMultipartFile)files.get("menu_image");
		//경로 
		String path = ctx.getRealPath("resources/imgUpload")+ '/' + cmf.getOriginalFilename();
		File file = new File(path);
		cmf.transferTo(file);
		//Menu Category 여부 판단
		String menu_category_name = req.getParameter("menu_category_name");
		if(menu_category_name.equals("카테고리 추가")){
			menu_category_name = req.getParameter("new_menu_category_name");
			service.insertMenuCategory(menu_category_name);
		}
		// 메뉴 DTO 저장
		MenuDTO dto = new MenuDTO();
		dto.setMenu_name(req.getParameter("menu_name"));
		dto.setMenu_price(Integer.parseInt(req.getParameter("menu_price")));
		dto.setMenu_category_name(menu_category_name);
		dto.setMenu_category_num(service.getMenuCategorynum(menu_category_name));
		dto.setMenu_image(cmf.getOriginalFilename());
		System.out.println(dto.toString());
		service.insertMenu(dto);
		rttr.addAttribute("result", "sucess");
		return view;
	}
}
