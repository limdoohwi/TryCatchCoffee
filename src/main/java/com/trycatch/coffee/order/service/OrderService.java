package com.trycatch.coffee.order.service;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;

import com.trycatch.coffee.cart.domain.CartDTO;
import org.json.simple.JSONObject;

import com.trycatch.coffee.order.domain.Menu_OrderDTO;
import com.trycatch.coffee.order.domain.Menu_PaymentDTO;

public interface OrderService {
	public boolean insertMenuPayment(Menu_PaymentDTO menuPaymentDto,  Menu_OrderDTO menuOrderDto);
	public JSONObject getMenu_Payment_withMember_no(int member_no, int start_page, String date);
	public JSONObject getMenu_DetailList_withMenu_Payment_no(int menu_payment_no);
	public JSONObject getMemberMenuPaymentList(int member_no, int start_page, String date);
}
