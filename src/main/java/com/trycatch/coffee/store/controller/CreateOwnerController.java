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
public class CreateOwnerController {
	@Inject
	private StoreService service;
	@Inject
	private MemberService memberService;
	
	/**
	 * @author 김준혁
	 * 점장 생성시 ajax를 이용한 이메일 중복확인 메서드
	 */
	@RequestMapping(value="/email.overlap.check.insert.store.manager", method=RequestMethod.POST)
	public void ownerEmailOverlapCheckPOST(Model model, String member_email, HttpServletResponse resp) throws Exception{
		PrintWriter out = resp.getWriter();
		boolean isExistEmail = memberService.isExistEmail(member_email);
			out.println(isExistEmail);
	}
	
	/**
	 * @author 김준혁
	 * 점장 생성 시 ajax를 이용한 점장 정보 DB에 등록
	 */
	@RequestMapping(value="/create.owner.insert.store.manager", method=RequestMethod.POST)
	public void createOwnerPOST(Model model, MemberDTO dto, HttpServletResponse resp) throws Exception{
		PrintWriter out = resp.getWriter();
		JSONObject jsonRoot = new JSONObject();
		boolean isSuccessRegister = memberService.register(dto);
		if(isSuccessRegister == true){
			jsonRoot = memberService.getCreate_owner();
		}
		else{
			jsonRoot.put("flag", "false");
		}
		out.println(jsonRoot);
	}
}
