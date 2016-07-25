package com.trycatch.coffee.order.service;

import javax.servlet.http.HttpServletRequest;

import com.trycatch.coffee.order.domain.Menu_OrderDTO;
import com.trycatch.coffee.order.domain.Menu_PaymentDTO;

public interface OrderService {
	public boolean insertOrder(Menu_PaymentDTO menuPaymentDto, Menu_OrderDTO menuOrderDto);
}
