package com.trycatch.coffee.cart.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.trycatch.coffee.cart.domain.CartDTO;
import com.trycatch.coffee.cart.service.CartService;
import com.trycatch.coffee.member.domain.MemberDTO;

@Controller
public class OrderCartController {
	@Inject
	private CartService service;
	@RequestMapping("/order.cart")
	public ModelAndView ordercart(HttpSession session){
		MemberDTO memberdto = (MemberDTO)session.getAttribute("member_dto");
		System.out.println(memberdto.toString());
		CartDTO cartdto= new CartDTO();
		cartdto.setMember_no(memberdto.getMember_no());
		ModelAndView view = new ModelAndView("reservation/Order");
		view.addObject("cartList", service.getCartList(cartdto));
		return view;
	}
}
