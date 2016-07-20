package com.trycatch.coffee.meeting_room.service;


import java.util.List;

import org.json.simple.JSONObject;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomDTO;
import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.member.domain.MemberDTO;

public interface MeetingRoomService {
	public JSONObject getMeetingRoomList_withStore_no(int store_no) throws Exception;
	public JSONObject getMeetingRoomList_withRervaion_date(MeetingRoomReservationDTO dto) throws Exception;
	public boolean insertMeetingRoomReservation(MeetingRoomReservationDTO dto) throws Exception;
	public boolean searchReservationOverlapMeetingRoom(MeetingRoomReservationDTO dto) throws Exception;
	public List<MeetingRoomReservationDTO> getMember_MeetingRoom_ReservationList(int member_no) throws Exception;
	public List<MeetingRoomReservationDTO> getMember_MeetingRoom_ReservationList(int member_no, MeetingRoomReservationDTO dto) throws Exception;
}
