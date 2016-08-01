package com.trycatch.coffee.member.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.meeting_room.service.MeetingRoomService;
import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.service.MemberService;

@Controller
public class MyPageController {
	@Inject
	private MemberService memberService;
	@Inject
	private MeetingRoomService meetingService;
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	/**
	 * @author 김준혁
	 * 회원이 로그인 후 my page에 들어가면 해당 회원의 구매 내역 및 미팅룸 예약 내역을 DB에서 호출
	 */
	@RequestMapping(value= "/my_page.member")
	public String reqeustGet(Model model, HttpServletRequest req, MeetingRoomReservationDTO meetingRoomDto) throws Exception{
		return "mypage/My_Page";
	}
	
	@RequestMapping(value= "/my_page.chage_pw.member", method=RequestMethod.POST)
	public @ResponseBody boolean changePwPOST(MemberDTO dto, HttpServletRequest req) throws Exception{
		boolean isSuccessUpdateMemberPw = memberService.updateMember_pw(dto);
		if(isSuccessUpdateMemberPw){
			req.getSession().removeAttribute("member_dto");
			req.getSession().removeAttribute("store_dto");
			return isSuccessUpdateMemberPw;
		}
		return false;
	}
	
	@RequestMapping("/my_page.meetingRoomReservationList.member")
	public @ResponseBody Object myPageMeetingRoomReservationList(HttpServletRequest req, int start_page, String date) throws Exception{
		logger.info(date);
		MemberDTO memberDto = (MemberDTO)req.getSession().getAttribute("member_dto");
		JSONObject jsonRoot = meetingService.getMember_MeetingRoom_ReservationList(memberDto.getMember_no(), start_page, date);
		return jsonRoot;
	}
	
	

}
