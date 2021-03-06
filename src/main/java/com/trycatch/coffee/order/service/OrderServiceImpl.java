package com.trycatch.coffee.order.service;

import javax.inject.Inject;

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
import com.trycatch.coffee.order.domain.Order_AlarmDTO;
import com.trycatch.coffee.order.persitance.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {
	@Inject
	private OrderDAO dao;
	@Inject
	private CartDAO cartDao;
	@Inject
	private OrderAlarmService alarmService;

	private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);

	/**
	 * @author 김준혁 1. Menu_Payment DB 등록 2. 방금 등록한 Menu_Payment_no을 검색 3.
	 *         Menu_Order DB 등록 1~3번중 하나라도 예외가 발생한다면 rollback
	 * @author LimDooHwi
	 * 		Alarm 정보 저장 추가 2016-08-04
	 */
	@Override
	public boolean insertMenuPayment(Menu_PaymentDTO menuPaymentDto,  Menu_OrderDTO menuOrderDto) {
		try {
			dao.insertMenu_Payment(menuPaymentDto);
			Menu_PaymentDTO dto = dao.getNowInsert_Menu_Payment();
			menuOrderDto.setMenu_payment_no(dto.getMenu_payment_no());
			//Menu_PaymentDTO recentMenuPayment_dto = dao.getNowInsert_Menu_Payment();
			//Menu_OrderDTO orderDto = new Menu_OrderDTO();
			//MENU 파싱
			CartDTO cartDto = new CartDTO();
			cartDto.setMember_no(dto.getMember_no());
			String[] menu_nums = menuOrderDto.getMenu_no().split(",");
			String[] menu_names = menuOrderDto.getMenu_name().split(",");
			String[] menu_counts = menuOrderDto.getMenu_count().split(",");
			String[] menu_options = menuOrderDto.getMenu_option().split(",");
			
			//order_Alarm 생성
			Order_AlarmDTO alarmDto = new Order_AlarmDTO();
			alarmDto.setOrder_category_no(1);
			alarmDto.setStore_no(menuPaymentDto.getStore_no());
			String order_content = "";
			for(int i=0; i<menu_nums.length; i++){
				cartDto.setMenu_num(Integer.parseInt(menu_nums[i]));
				cartDao.deleteCart(cartDto);
				menuOrderDto.setMenu_no(menu_nums[i]);
				menuOrderDto.setMenu_count(menu_counts[i]);
				menuOrderDto.setMenu_option(menu_options[i]);
				dao.insertMenu_Order(menuOrderDto);
				order_content += "음료명 : " + menu_names[i]+"/" + menu_counts[i] + "잔/옵션:" + menu_options[i] + ", ";
			}
			alarmDto.setOrder_content(order_content);
			alarmService.insertAlarm(alarmDto);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
	
	@Override
	public JSONObject getMenu_Payment_withMember_no(int member_no, int start_page, String date) {
		JSONObject jsonRoot = new JSONObject();
		try {
			jsonRoot.put("menuPaymentList", dao.getMenu_Payment_withMember_no(member_no, start_page, date));
			return jsonRoot;
		} catch (Exception e) {
			return null;
		}
	}
	
	@Override
	public JSONObject getMenu_DetailList_withMenu_Payment_no(int menu_payment_no) {
		JSONObject jsonRoot = new JSONObject();
		try {
			jsonRoot.put("menuDetailList", dao.getMenu_DetailList_withMenu_Payment_no(menu_payment_no));
			return jsonRoot;
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public JSONObject getMemberMenuPaymentList(int member_no, int start_page, String date) {
		JSONObject jsonRoot = new JSONObject();
		jsonRoot.put("memberDrinkReservationList", dao.getMemberMenuPaymentList(member_no, start_page, date));
		return jsonRoot;
	}
}
