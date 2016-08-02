package com.trycatch.coffee.order.service;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.trycatch.coffee.cart.domain.CartDTO;
import com.trycatch.coffee.cart.persitance.CartDAO;
import com.trycatch.coffee.order.domain.Menu_OrderDTO;
import com.trycatch.coffee.order.domain.Menu_PaymentDTO;
import com.trycatch.coffee.order.persitance.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {
	@Inject
	private OrderDAO dao;
	@Inject
	private CartDAO cartDao;
	@Inject
	private DataSourceTransactionManager transactionManager;
	private DefaultTransactionDefinition transaction = new DefaultTransactionDefinition();
	private TransactionStatus status;
	
	private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);
		
	/**
	 * @author 김준혁
	 * 1. Menu_Payment DB 등록
	 * 2. 방금 등록한 Menu_Payment_no을 검색
	 * 3. Menu_Order DB 등록
	 * 1~3번중 하나라도 예외가 발생한다면 rollback 
	 */
	@Override
	public boolean insertOrder(Menu_PaymentDTO menuPaymentDto, Menu_OrderDTO menuOrderDto) {
		transaction.setName("order_transaction");
		transaction.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		status = transactionManager.getTransaction(transaction);
		try {
			
			dao.insertMenu_Payment(menuPaymentDto);
			Menu_PaymentDTO recentMenuPayment_dto = dao.getNowInsert_Menu_Payment();
			Menu_OrderDTO orderDto = new Menu_OrderDTO();
			//MENU 파싱
			String[] parseMenu_no = menuOrderDto.getMenu_no().split(",");
			String[] parseMenu_count = menuOrderDto.getMenu_count().split(",");
			String[] parseMenu_option = menuOrderDto.getMenu_option().split(",");
			CartDTO cartDto = new CartDTO();
			cartDto.setMember_no(menuPaymentDto.getMember_no());
			for(int i=0; i<parseMenu_no.length; i++){
				logger.info("메뉴 번호들 : " + parseMenu_no[i]);
				cartDto.setMenu_num(Integer.parseInt(parseMenu_no[i]));
				cartDao.deleteCart(cartDto);
				orderDto.setMenu_payment_no(recentMenuPayment_dto.getMenu_payment_no());
				orderDto.setMenu_no(parseMenu_no[i]);
				orderDto.setMenu_count(parseMenu_count[i]);
				orderDto.setMenu_option(parseMenu_option[i]);
				dao.insertMenu_Order(orderDto);
			}
			transactionManager.commit(status);
			return true;
		} catch (Exception err) {
			transactionManager.rollback(status);
			return false;
		}
	}
	
	@Override
	public JSONObject getMemberMenuPaymentList(int member_no, int start_page, String date) {
		JSONObject jsonRoot = new JSONObject();
		jsonRoot.put("memberDrinkReservationList", dao.getMemberMenuPaymentList(member_no, start_page, date));
		return jsonRoot;
	}
}
