package com.trycatch.coffee.meeting_room.persitance;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomDTO;
import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.member.domain.MemberDTO;
@Repository
public class MeetingRoomDAOImpl implements MeetingRoomDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.meetingRoomMapper";

	@Override
	public List<MeetingRoomDTO> getMeetingRoomList_withStore_no(int store_no) {
		try {
			return sqlSession.selectList(NAMESPACE + ".getMeetingRoomList_withStore_no", store_no);
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public List<MeetingRoomReservationDTO> getMeetingRoomList_withReservation_date(MeetingRoomReservationDTO dto) {
		try {
			return sqlSession.selectList(NAMESPACE + ".getMeetingRoomList_withReservation_date", dto);
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public boolean insertMeetingRoomReservation(MeetingRoomReservationDTO dto) {
		try {
			sqlSession.insert(NAMESPACE + ".insertMeetingRoomReservation", dto);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
	
	@Override
	public MeetingRoomReservationDTO searchReservationOverlapMeetingRoom(MeetingRoomReservationDTO dto) {
		try {
			return sqlSession.selectOne(NAMESPACE + ".searchReservationOverlapMeetingRoom", dto);
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public List<MeetingRoomReservationDTO> getMember_MeetingRoom_ReservationList(int member_no, int start_page, String date) {
		Map map = new HashMap();
		map.put("member_no", member_no);
		map.put("date", date);
		int end_page = start_page + 5;
		RowBounds row = new RowBounds(start_page, end_page);
		try {
			return sqlSession.selectList(NAMESPACE + ".getMember_MeetingRoom_ReservationList", map, row);
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public List<MeetingRoomReservationDTO> getMember_MeetingRoom_ReservationList(int member_no,
			MeetingRoomReservationDTO dto) {
		try {
			System.out.println("입성 : " + member_no + "," + dto.getMeeting_order_date());
			Map map = new HashMap();
			map.put("member_no", member_no);
			map.put("meeting_order_date", dto.getMeeting_order_date());
			return sqlSession.selectList(NAMESPACE + ".getMember_MeetingRoom_ReservationList", map);
		} catch (Exception err) {
			err.printStackTrace();
		}
		return null;
	}
}
