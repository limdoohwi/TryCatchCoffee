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

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
	@Inject
	private MeetingRoomDAO dao;

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
	
	@Override
	public boolean insertMeetingRoomReservation(MeetingRoomReservationDTO dto) throws Exception {
		return dao.insertMeetingRoomReservation(dto);
	}
}
