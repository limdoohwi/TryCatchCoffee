package com.trycatch.coffee.order.persitance;

import java.util.List;

import com.trycatch.coffee.cart.domain.CartDTO;
import com.trycatch.coffee.order.domain.Menu_OrderDTO;
import com.trycatch.coffee.order.domain.Menu_PaymentDTO;

public interface OrderDAO {
	public void insertMenu_Payment(Menu_PaymentDTO dto);
	public void insertMenu_Order(Menu_OrderDTO dto);
	public Menu_PaymentDTO getNowInsert_Menu_Payment();
	public void deleteCart(int member_no, int menu_no);
	public List<Menu_PaymentDTO> getMemberMenuPaymentList(int member_no, int start_page, String date);
}
