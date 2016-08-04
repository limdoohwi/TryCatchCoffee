package com.trycatch.coffee.order.persitance;

import java.util.List;

import com.trycatch.coffee.order.domain.Order_AlarmDTO;

public interface OrderAlarmDAO {
	public void insertAlarm(Order_AlarmDTO alarmDto);
	public List<Order_AlarmDTO> getAlarmList(int store_no);
	
}
