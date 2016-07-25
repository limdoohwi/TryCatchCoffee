package com.trycatch.coffee.cart.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.cart.domain.CartDTO;
import com.trycatch.coffee.cart.service.CartService;
import com.trycatch.coffee.member.domain.MemberDTO;

@Controller
public class InsertCartController {
	@Inject
	private CartService service;
	@RequestMapping("/insert.cart")
	public @ResponseBody Object insertCart(HttpServletRequest req){
		int menu_num = Integer.parseInt(req.getParameter("menu_num"));
		MemberDTO member_dto = (MemberDTO)(req.getSession().getAttribute("member_dto"));
		CartDTO cartdto = new CartDTO();
		cartdto.setMember_no(member_dto.getMember_no());
		cartdto.setMenu_num(menu_num);
		System.out.println(cartdto.toString());
		boolean check = service.checkCart(cartdto);
		if(check==true){
			service.updateCart(cartdto);
		}
		else{
			service.insertCart(cartdto);
		}
		JSONObject obj = new JSONObject();
		cartdto.setMenu_num(0);
		obj.put("cartList", service.getCartList(cartdto));
		return obj;
	}
}
