package com.trycatch.coffee.store.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.service.MemberService;
import com.trycatch.coffee.store.service.StoreService;

@Controller
public class StoreManageController {
	@Inject
	private StoreService service;

	/**
	 * @author 김준혁
	 * 메인 화면 매장관리 클릭시 해당 페이지로 이동
	 */
	@RequestMapping("/store.manager")
	public String storeGET(Model model) throws Exception{
		model.addAttribute("storeList", service.getStoreList());
		model.addAttribute("check", "store");
		return "manager/Manager";
	}
	
	/**
	 * @author 김준혁
	 * 매장 추가시 포커스가 점장 text에 맞춰지면 점장 검색 및 점장 생성 팝업창 호출
	 */
	@RequestMapping("/search.owner.insert.store.manager")
	public String ownerSToreGET() throws Exception{
		return "manager/Owner_Search&Create";
	}
	
	/**
	 * @author 김준혁
	 * 매장 검색시 해당 조건을 만족하는 매장의 List를 search
	 */
	@RequestMapping("/search.store.manager")
	public String searchStorePOST(Model model, String search_store_value) throws Exception{
		model.addAttribute("storeList", service.getStoreList_every_column(search_store_value));
		model.addAttribute("check", "store");
		model.addAttribute("search_store_value", search_store_value);
		return "manager/Manager";
	}
}
