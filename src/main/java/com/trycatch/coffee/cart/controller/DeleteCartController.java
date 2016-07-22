package com.trycatch.coffee.cart.controller;

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
public class DeleteCartController {
	@Inject
	private CartService service;
	@RequestMapping("/delete.cart")
	public @ResponseBody Object updatecart(HttpServletRequest req){
		MemberDTO member_dto = (MemberDTO)(req.getSession().getAttribute("member_dto"));
		int menu_num = Integer.parseInt(req.getParameter("menu_num"));
		CartDTO cartdto = new CartDTO();
		cartdto.setMember_no(member_dto.getMember_no());
		cartdto.setMenu_num(menu_num);
		service.deleteCart(cartdto);
		
		JSONObject obj = new JSONObject();
		cartdto.setMenu_num(0);
		obj.put("cartList", service.getCartList(cartdto));
		return obj;
	}
}
