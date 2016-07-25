package com.trycatch.coffee.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.order.domain.Menu_OrderDTO;
import com.trycatch.coffee.order.domain.Menu_PaymentDTO;
import com.trycatch.coffee.order.service.OrderService;
import com.trycatch.coffee.store.domain.StoreDTO;

@Controller
public class InsertMenuPaymentController {
	@Inject
	private OrderService service;
	
	private static final Logger logger = LoggerFactory.getLogger(InsertMenuPaymentController.class);
	
	@RequestMapping("/insert.menu_payment.order")
	public @ResponseBody boolean insertMenuPaymentOrderPOST(HttpServletRequest req, Menu_PaymentDTO menuPaymentDto, Menu_OrderDTO menuOrderDto) throws Exception{
		Date today = new Date();
		SimpleDateFormat formatToday = new SimpleDateFormat("yyyy-MM-dd");
		String resultToday = formatToday.format(today);
		menuPaymentDto.setMenu_reserve_time(resultToday + " " + menuPaymentDto.getMenu_reserve_time());
		//결제하는 회원 번호 가져오기
		MemberDTO memberDto = (MemberDTO)req.getSession().getAttribute("member_dto");
		menuPaymentDto.setMember_no(memberDto.getMember_no());
		//결제하는 매장 번호 가져오기
		StoreDTO storeDto = (StoreDTO)req.getSession().getAttribute("store_dto");
		menuPaymentDto.setStore_no(storeDto.getStore_no());
		logger.info("결제 컨트롤러 : " + menuPaymentDto.getMember_no() + ", " + menuPaymentDto.getMenu_payment_date() +", " + menuPaymentDto.getMenu_payment_style() +", " + menuPaymentDto.getMenu_reserve_time() +", " + menuPaymentDto.getMenu_total_mileage() +", " + menuPaymentDto.getMenu_total_price() + ", " + menuPaymentDto.getOrder_name() +", " + menuPaymentDto.getOrder_tel() + ", " + menuPaymentDto.getStore_no() );
		
		return service.insertOrder(menuPaymentDto, menuOrderDto);
	}
}
