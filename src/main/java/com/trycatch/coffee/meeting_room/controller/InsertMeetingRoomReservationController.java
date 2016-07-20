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
public class InsertMeetingRoomReservationController {
	@Inject
	private MeetingRoomService service;
	
	private static final Logger logger = LoggerFactory.getLogger(InsertMeetingRoomReservationController.class);
	/**
	 * @author 김준혁
	 * 미팅룸 예약 페이지에서 클라이언트가 해당 time의 버튼을 누르면 해당 날짜, 해당 시간, 해당 매장, 해당 회원의 정보가 DB에 저장
	 */
	@RequestMapping(value="/insert.meeting_room.order", method=RequestMethod.POST)
	public void insertMeetingRoomReservationPOST(MeetingRoomReservationDTO dto, HttpServletResponse resp) throws Exception{
		PrintWriter out = resp.getWriter();
		out.println(service.insertMeetingRoomReservation(dto));
	}
}
