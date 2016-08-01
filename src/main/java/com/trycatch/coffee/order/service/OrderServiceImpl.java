package com.trycatch.coffee.order.service;

import javax.inject.Inject;

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
	 * @author 김준혁 1. Menu_Payment DB 등록 2. 방금 등록한 Menu_Payment_no을 검색 3.
	 *         Menu_Order DB 등록 1~3번중 하나라도 예외가 발생한다면 rollback
	 */
	@Override
	public boolean insertMenuPayment(Menu_PaymentDTO menuPaymentDto,  Menu_OrderDTO menuOrderDto) {
		transaction.setName("payment_transaction");
		transaction.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		status = transactionManager.getTransaction(transaction);
		try {
			dao.insertMenu_Payment(menuPaymentDto);
			Menu_PaymentDTO dto = dao.getNowInsert_Menu_Payment();
			menuOrderDto.setMenu_payment_no(dto.getMenu_payment_no());
			CartDTO cartDto = new CartDTO();
			cartDto.setMember_no(dto.getMember_no());
			String[] menu_nums = menuOrderDto.getMenu_no().split(",");
			String[] menu_counts = menuOrderDto.getMenu_count().split(",");
			String[] menu_options = menuOrderDto.getMenu_option().split(",");
			for(int i=0; i<menu_nums.length; i++){
				cartDto.setMenu_num(Integer.parseInt(menu_nums[i]));
				cartDao.deleteCart(cartDto);
				menuOrderDto.setMenu_no(menu_nums[i]);
				menuOrderDto.setMenu_count(menu_counts[i]);
				menuOrderDto.setMenu_option(menu_options[i]);
				dao.insertMenu_Order(menuOrderDto);
			}
			transactionManager.commit(status);
			return true;
		} catch (Exception err) {
			transactionManager.rollback(status);
			return false;
		}
	}
}
