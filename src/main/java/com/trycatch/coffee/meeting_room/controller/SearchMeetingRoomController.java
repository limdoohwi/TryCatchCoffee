package com.trycatch.coffee.meeting_room.controller;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomDTO;
import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.meeting_room.service.MeetingRoomService;

@Controller
public class SearchMeetingRoomController {
	@Inject
	private MeetingRoomService service;
	
	private static final Logger logger = LoggerFactory.getLogger(SearchMeetingRoomController.class);
	
	/**
	 * @author 김준혁
	 * 미팅룸 예약 페이지에서 미팅룸을 선택했을 시 해당 날짜에 해당 미팅룸의 예약 내역을 DB에서 호출
	 */
	@RequestMapping(value="/search.reservation.meeting_room.order", method=RequestMethod.POST)
	public void searchReservationmeetingRoomPOST(MeetingRoomReservationDTO dto, HttpServletResponse resp) throws Exception{
		JSONObject jsonRoot = service.getMeetingRoomList_withRervaion_date(dto);
		PrintWriter out = resp.getWriter();
		out.println(jsonRoot);
	}
	
	/**
	 * @author 김준혁
	 * 미팅룸을 예약하는 회원이 당일 중복 예약인지 아닌지 체크
	 */
	@RequestMapping(value="/search.overlap.meeting_room.order", method=RequestMethod.POST)
	public void searchReservationOverlapmeetingRoomPOST(MeetingRoomReservationDTO dto, HttpServletResponse resp) throws Exception{
		PrintWriter out = resp.getWriter();
		out.println(service.searchReservationOverlapMeetingRoom(dto));
	}
	
	/**
	 * @author 김준혁
	 * GPS로 잡힌 매장의 미팅룸 List를 미팅룸 예약 페이지에 전달
	 *
	 */
	@RequestMapping("/meeting_room.store.meeting_room.order")
	public void searchStoreMeetingRoomPOST(int store_no, HttpServletResponse resp) throws Exception{
		JSONObject jsonRoot = service.getMeetingRoomList_withStore_no(store_no);
		PrintWriter out = resp.getWriter();
		out.println(jsonRoot);
	}
}
