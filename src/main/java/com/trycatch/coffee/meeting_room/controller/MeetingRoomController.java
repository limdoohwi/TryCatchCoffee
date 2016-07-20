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
public class MeetingRoomController {
	@Inject
	private MeetingRoomService service;
	
	private static final Logger logger = LoggerFactory.getLogger(MeetingRoomController.class);
	/**
	 * @author 김준혁
	 * 메인 화면에서 미팅룸 예약을 누르면 팝업창 호출
	 */
	@RequestMapping("/meeting_room.order")
	public String meetingRoomGet() throws Exception{
		return "reservation/MeetingRoom";
	}
}
