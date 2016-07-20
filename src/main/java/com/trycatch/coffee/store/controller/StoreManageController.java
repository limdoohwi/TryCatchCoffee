package com.trycatch.coffee.store.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.service.MemberService;
import com.trycatch.coffee.store.domain.StoreDTO;
import com.trycatch.coffee.store.service.StoreService;

@Controller
public class StoreManageController {
	@Inject
	private StoreService service;

	private static final Logger logger = LoggerFactory.getLogger(StoreManageController.class);
	/**
	 * @author 김준혁
	 * 메인 화면 매장관리 클릭시 해당 페이지로 이동
	 */
	@RequestMapping("/store.manager")
	public String storeGET(StoreDTO dto, Model model) throws Exception{
		if(dto != null && !dto.getSearch_store_value().equals("")){
			model.addAttribute("storeList", service.getStoreList(dto));
			model.addAttribute("search_store_value", dto.getSearch_store_value());
		}
		else{
			model.addAttribute("storeList", service.getStoreList());
		}
		model.addAttribute("check", "store");
		return "manager/Manager";
	}
	
	/**
	 * @author 김준혁
	 * GPS 실행시 DB에 저장되어 있는 매장 List를 호출
	 */
	@RequestMapping(value="/set.store.manager", method=RequestMethod.POST)
	public void storePOST(boolean isGPSgetStoreList, HttpServletResponse resp) throws Exception{
		JSONObject jsonRoot = service.getStoreList(isGPSgetStoreList);
		PrintWriter out = resp.getWriter();
		out.println(jsonRoot);
	}
	
	/**
	 * @author 김준혁
	 * 매장 추가시 포커스가 점장 text에 맞춰지면 점장 검색 및 점장 생성 팝업창 호출
	 */
	@RequestMapping("/search.owner.insert.store.manager")
	public String ownerSToreGET() throws Exception{
		return "manager/Owner_Search&Create";
	}
}
