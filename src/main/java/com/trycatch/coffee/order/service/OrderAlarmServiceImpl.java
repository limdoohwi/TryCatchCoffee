package com.trycatch.coffee.order.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.order.domain.Order_AlarmDTO;
import com.trycatch.coffee.order.persitance.OrderAlarmDAO;
@Service
public class OrderAlarmServiceImpl implements OrderAlarmService {
	@Inject
	private OrderAlarmDAO dao;
	@Override
	public void insertAlarm(Order_AlarmDTO alarmDto) {
		dao.insertAlarm(alarmDto);

	}

	@Override
	public List<Order_AlarmDTO> getAlarmList(int store_no) {
		// TODO Auto-generated method stub
		return null;
	}

}
