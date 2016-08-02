package com.trycatch.coffee.order.persitance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.cart.domain.CartDTO;
import com.trycatch.coffee.order.domain.Menu_OrderDTO;
import com.trycatch.coffee.order.domain.Menu_PaymentDTO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.orderMapper";
	private static final Logger logger = LoggerFactory.getLogger(OrderDAOImpl.class);
	@Override
	public void insertMenu_Payment(Menu_PaymentDTO dto) {
		logger.info("결제 추가 시작 ");
		try {
			sqlSession.insert(NAMESPACE + ".insertMenu_Payment", dto);
			logger.info("성공");
		} catch (Exception err) {
			logger.info("실패");
			err.printStackTrace();
		}
	}
	
	@Override
	public void insertMenu_Order(Menu_OrderDTO dto) {
		try {
			sqlSession.insert(NAMESPACE + ".insertMenu_Order", dto);
			logger.info("주문 내역 성공 ");
		} catch (Exception err) {
			logger.info("주문 내역 실패");
			err.printStackTrace();
		}
	}
	
	@Override
	public Menu_PaymentDTO getNowInsert_Menu_Payment() {
		logger.info("결제 번호 찾기 시작 ");
		try {
			List<Menu_PaymentDTO> list = sqlSession.selectList(NAMESPACE + ".getNowInsert_Menu_Payment");
			logger.info("서치 성공 : " + list.size());
			return list.get(0);
		} catch (Exception err) {
			logger.info("서치 실패");
			err.printStackTrace();
			return null;
		}
	}
	
	@Override
	public void deleteCart(int member_no, int menu_no) {
		Map<String, Integer> map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("menu_no", menu_no);
		try {
			sqlSession.delete(NAMESPACE + ".deleteCart", map);
		} catch (Exception err) {
			err.printStackTrace();
		}
	}
	
	@Override
	public List<Menu_PaymentDTO> getMenu_Payment_withMember_no(int member_no, int start_page, String date) {
		Map map = new HashMap();
		map.put("member_no", member_no);
		map.put("date", date);
		int end_page = start_page + 3;
		RowBounds row = new RowBounds(start_page, end_page);
		try {
			return sqlSession.selectList(NAMESPACE + ".getMenu_Payment_withMember_no", map, row);
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public List<Menu_PaymentDTO> getMenu_DetailList_withMenu_Payment_no(int menu_payment_no) {
		try {
			return sqlSession.selectList(NAMESPACE + ".getMenu_DetailList_withMenu_Payment_no", menu_payment_no);
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public List<Menu_PaymentDTO> getMemberMenuPaymentList(int member_no, int start_page, String date) {
		RowBounds row = new RowBounds(start_page, 3);
		Map map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("date", date);
		try {
			return sqlSession.selectList(NAMESPACE + ".getMemberMenuPaymentList", map, row);
		} catch (Exception err) {
			return null;
		}
	}
}