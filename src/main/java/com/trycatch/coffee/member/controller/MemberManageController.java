package com.trycatch.coffee.member.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.board.client.service.BoardService;
import com.trycatch.coffee.board.recipe.service.BoardRecipeService;
import com.trycatch.coffee.meeting_room.service.MeetingRoomService;
import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.service.MemberService;
import com.trycatch.coffee.order.service.OrderService;

@Controller
public class MemberManageController {
	@Inject
	private MemberService service;
	@Inject
	private MeetingRoomService meetingRoomService;
	@Inject
	private OrderService orderService;
	@Inject
	private BoardRecipeService recipeService;
	@Inject
	private BoardService boardClientService;
	
	@RequestMapping("/member.manager")
	public String managerGet(Model model) throws Exception{
		//model.addAttribute("memberList", service.getMemberList());
		model.addAttribute("check", "member");
		return "manager/Manager";
	}
	
	@RequestMapping("/member.list.manager")
	public @ResponseBody Object managerList(int start_page, String member_email_search) throws Exception{
		JSONObject jsonRoot = new JSONObject();
		jsonRoot.put("memberList", service.getMemberList(start_page, member_email_search));
		return jsonRoot;
	}
	
	@RequestMapping("/find.meetingRoomReservationList.member.manage")
	public @ResponseBody Object findMemberDrinkReservationList(int member_no, int start_page, String date) throws Exception{
		System.out.println(date + "*(#&$@(*$&@(#*$&@#(*$&@#(*$&@#(*$&@#(*$&@#(*$&(*#&@#(*$&@(#*$&");
		JSONObject jsonRoot = meetingRoomService.getMember_MeetingRoom_ReservationList(member_no, start_page, date);
		return jsonRoot;
	}
	
	@RequestMapping("/find.drinkReservationList.member.manage")
	public @ResponseBody Object findMemberMeetingRoomReservationList(int member_no, int start_page, String date) throws Exception{
		JSONObject jsonRoot = orderService.getMemberMenuPaymentList(member_no, start_page, date);
		return jsonRoot;
	}
	
	@RequestMapping("/find.boardHistoryList.member.manage")
	public @ResponseBody Object findMemberBoardHistoryReservationList(int member_no, int start_page, String date) throws Exception{
		JSONObject jsonRoot = new JSONObject();
		jsonRoot.put("memberBoardRecipeHistoryList", recipeService.boardrecipelistall_with_memberNo_date(member_no, start_page, date));
		jsonRoot.put("memberBoardClientHistroyList", boardClientService.listAll_withMember_no_Date(member_no, start_page, date));
		return jsonRoot;
	}
	
	
	/*
	@RequestMapping("/search.member.manager")
	public String searchMember(Model model, String member_email) throws Exception{
		model.addAttribute("memberList", service.getMember_email_like(member_email));
		model.addAttribute("check", "member");
		return "manager/Manager";
	}
	*/
}
