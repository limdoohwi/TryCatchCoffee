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

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.service.MemberService;
import com.trycatch.coffee.store.service.StoreService;

@Controller
public class SearchOwnerController {
	@Inject
	private StoreService service;
	@Inject
	private MemberService memberService;
	
	/**
	 * @author 김준혁
	 * 매장 추가시 ajax를 이용한 기존 점장 이메일 검색 메서드
	 * @return
	 */
	@RequestMapping(value="/search.owner.insert.store.manager", method=RequestMethod.POST)
	public void ownerSearchPOST(Model model, String member_email, HttpServletResponse resp) throws Exception{
		JSONObject jsonRoot = memberService.getSearchOnwerList(member_email);
		PrintWriter out = resp.getWriter();
		out.println(jsonRoot);
	}
}
