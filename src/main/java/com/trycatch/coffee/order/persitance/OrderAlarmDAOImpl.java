package com.trycatch.coffee.order.persitance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.order.domain.Order_AlarmDTO;
@Repository
public class OrderAlarmDAOImpl implements OrderAlarmDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.orderMapper";
	
	@Override
	public void insertAlarm(Order_AlarmDTO alarmDto) {
		sqlSession.insert(NAMESPACE+".insertOrder_Alarm",alarmDto);
	}

	@Override
	public List<Order_AlarmDTO> getAlarmList(int store_no) {
		// TODO Auto-generated method stub
		return null;
	}

}
