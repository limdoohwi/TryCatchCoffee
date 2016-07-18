package com.trycatch.coffee.store.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.store.domain.StoreDTO;
import com.trycatch.coffee.store.service.StoreService;

@Controller
public class InsertStoreController {
	@Inject
	private StoreService service;

	/**
	 * @author 김준혁
	 * 새로운 매장정보를 DB에 등록
	 */
	@RequestMapping(value="/insert.store.manager", method=RequestMethod.POST)
	public String insertStorePOST(Model model, StoreDTO dto, RedirectAttributes rttr) throws Exception{
		boolean isSuccessInsert = true;
		boolean isSuccessInsertStore = service.insertStore(dto);
		if(isSuccessInsertStore){
			isSuccessInsert = service.insertMeetingRoomStore();
		}
		else{
			isSuccessInsert = false;
		}
		rttr.addFlashAttribute("isSuccessInsertStore", isSuccessInsert);
		model.addAttribute("check", "store");
		return "redirect:/store.manager";
	}
}
