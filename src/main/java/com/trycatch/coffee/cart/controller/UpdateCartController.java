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
public class UpdateCartController {
	@Inject
	private CartService service;
	@RequestMapping("/update.cart")
	public @ResponseBody Object updatecart(HttpServletRequest req){
		MemberDTO member_dto = (MemberDTO)(req.getSession().getAttribute("member_dto"));
		String param = req.getParameter("param");
		int menu_num = Integer.parseInt(req.getParameter("menu_num"));
		CartDTO cartdto = new CartDTO();
		cartdto.setMember_no(member_dto.getMember_no());
		cartdto.setMenu_num(menu_num);
		if(param.equals("minus")){
			cartdto.setMenu_count(-1);
			service.updateCart(cartdto);
		}
		else if(param.equals("plus")){
			cartdto.setMenu_count(0);
			service.updateCart(cartdto);
		}
		else{
			int menu_count =Integer.parseInt(req.getParameter("menu_count"));
			cartdto.setMenu_count(menu_count);
			service.updateCart(cartdto);
		}
		JSONObject obj = new JSONObject();
		cartdto.setMenu_num(0);
		obj.put("cartList", service.getCartList(cartdto));
		return obj;
	}
}
