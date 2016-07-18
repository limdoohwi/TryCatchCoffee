package com.trycatch.coffee.store.controller;



import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.member.service.MemberService;
import com.trycatch.coffee.store.domain.StoreDTO;
import com.trycatch.coffee.store.service.StoreService;

@Controller
public class UpdateStoreController {
	@Inject
	private StoreService service;
	@Inject
	private MemberService memberService;
	
	private static final Logger logger = LoggerFactory.getLogger(UpdateStoreController.class);
	
	/**
	 * @author 김준혁
	 * 수정 할 매장 선택시 ajax를 이용한 해당 매장의 정보 호출 
	 */
	@RequestMapping(value="/load.storeInfo.update.store.manager", method=RequestMethod.POST)
	@ResponseBody
	public StoreDTO loadStoreInfoPOST(int store_no) throws Exception{
		return service.getStore_store_no(store_no);
	}
	
	@RequestMapping(value="/update.store.manager", method=RequestMethod.POST)
	public String updateStorePOST(StoreDTO dto, RedirectAttributes rttr) throws Exception{
		boolean isSuccessUpdateStore = service.updateStore(dto);
		rttr.addFlashAttribute("isSuccessUpdateStore", isSuccessUpdateStore);
		return "redirect:/store.manager";
	}
}
