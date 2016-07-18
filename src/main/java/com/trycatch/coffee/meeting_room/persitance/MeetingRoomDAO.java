package com.trycatch.coffee.meeting_room.persitance;

import java.util.List;

import org.json.simple.JSONObject;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomDTO;
import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.member.domain.MemberDTO;

public interface MeetingRoomDAO {
	public List<MeetingRoomDTO> getMeetingRoomList_withStore_no(int store_no);
	public List<MeetingRoomReservationDTO> getMeetingRoomList_withReservation_date(MeetingRoomReservationDTO dto);
	public boolean insertMeetingRoomReservation(MeetingRoomReservationDTO dto);
}
