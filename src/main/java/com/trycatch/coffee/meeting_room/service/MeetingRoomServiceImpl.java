package com.trycatch.coffee.meeting_room.service;

import java.net.URLEncoder;
import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomDTO;
import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.meeting_room.persitance.MeetingRoomDAO;
import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.persitance.MemberDAO;
import com.trycatch.coffee.order.domain.Order_AlarmDTO;
import com.trycatch.coffee.order.service.OrderAlarmService;

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
	@Inject
	private MeetingRoomDAO dao;
	@Inject
	private OrderAlarmService alarmService;

	private static final Logger logger = LoggerFactory.getLogger(MeetingRoomServiceImpl.class);
	
	@Override
	public JSONObject getMeetingRoomList_withStore_no(int store_no) throws Exception {
		JSONObject jsonRoot = new JSONObject();
		JSONArray jsonArry = new JSONArray();
		List<MeetingRoomDTO> list = dao.getMeetingRoomList_withStore_no(store_no);
		
		for(int i=0; i<list.size(); i++){
			MeetingRoomDTO dto = list.get(i);
			JSONObject jsonTemp = new JSONObject();
			jsonTemp.put("meeting_no", dto.getMeeting_no());
			jsonArry.add(jsonTemp);
		}
		jsonRoot.put("meetingList", jsonArry);
		return jsonRoot;
	}
	
	@Override
	public JSONObject getMeetingRoomList_withRervaion_date(MeetingRoomReservationDTO dto) throws Exception {
		JSONObject jsonRoot = new JSONObject();
		JSONArray jsonArry = new JSONArray();
		List<MeetingRoomReservationDTO> list = dao.getMeetingRoomList_withReservation_date(dto);
		for(int i=0; i<list.size(); i++){
			MeetingRoomReservationDTO meetingDto = list.get(i);
			JSONObject jsonTemp = new JSONObject();
			jsonTemp.put("meeting_reservation_time", meetingDto.getMeeting_reservation_time());
			jsonArry.add(jsonTemp);
		}
		jsonRoot.put("meetingReservationTimeList", jsonArry);
		return jsonRoot;
	}
	/**
	 * @author LimDooHwi 2016-08-04
	 * 알람 테이블 저장 추가
	 */
	@Override
	public boolean insertMeetingRoomReservation(MeetingRoomReservationDTO dto) throws Exception {
		Order_AlarmDTO alarmDto = new Order_AlarmDTO();
		alarmDto.setOrder_category_no(2);
		alarmDto.setStore_no(dto.getStore_no());
		String meeting_content = "예약자 : " +dto.getMember_name()+"/" + dto.getMeeting_reservation_date() + "/" + dto.getMeeting_reservation_time() +"/" + dto.getMeeting_no() +"번 방"+ "/";
		alarmDto.setOrder_content(meeting_content);
		alarmService.insertAlarm(alarmDto);
		return dao.insertMeetingRoomReservation(dto);
	}
	
	@Override
	public boolean searchReservationOverlapMeetingRoom(MeetingRoomReservationDTO dto) throws Exception {
		MeetingRoomReservationDTO meetingDto = dao.searchReservationOverlapMeetingRoom(dto);
		if(meetingDto != null){
			return true;
		}
		else{
			return false;
		}
	}
	
	@Override
	public JSONObject getMember_MeetingRoom_ReservationList(int member_no, int start_page, String date) throws Exception {
		JSONObject jsonRoot = new JSONObject();
		logger.info(String.valueOf(dao.getMember_MeetingRoom_ReservationList(member_no, start_page, date).size()));
		jsonRoot.put("myPageMeetingRoomReservationList", dao.getMember_MeetingRoom_ReservationList(member_no, start_page, date));
		return jsonRoot;
	}
	
	@Override
	public List<MeetingRoomReservationDTO> getMember_MeetingRoom_ReservationList(int member_no,
			MeetingRoomReservationDTO dto) throws Exception {
		return dao.getMember_MeetingRoom_ReservationList(member_no, dto);
	}
}
