package com.trycatch.coffee.cart.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.cart.domain.CartDTO;
import com.trycatch.coffee.cart.service.CartService;
import com.trycatch.coffee.member.domain.MemberDTO;

@Controller
public class CartController {
	@Inject
	private CartService service;
	
	@RequestMapping(value="/list.cart",method=RequestMethod.POST)
	public @ResponseBody Object getCartList(HttpServletRequest req){
		MemberDTO member_dto = (MemberDTO)(req.getSession().getAttribute("member_dto"));
		CartDTO dto = new CartDTO();
		dto.setMember_no(member_dto.getMember_no());
		JSONObject obj = new JSONObject();
		obj.put("cartList", service.getCartList(dto));
		System.out.println("여긴 오지요?");
		return obj;
	}
}
