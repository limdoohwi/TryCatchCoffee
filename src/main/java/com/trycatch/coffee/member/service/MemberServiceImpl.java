package com.trycatch.coffee.member.service;

import java.net.URLEncoder;
import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.persitance.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	private MemberDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	@Override
	public boolean register(MemberDTO dto) throws Exception {
		if(dto.getMember_code() == 0){
			dto.setMember_code(1);
		}
		return dao.insertMember(dto);
	}

	@Override
	public MemberDTO login(String member_email, String member_pw) throws Exception{
		MemberDTO dto =dao.getMember_email(member_email);
		if(dto!=null){
				if(dto.getMember_pw().equals(member_pw)){
					return dto;
				}
				else{
					return null;
				}
		}
		else{
			return null;
		}
	}

	@Override
	public List<MemberDTO> getMemberList(int start_page, String member_email_search) throws Exception {
		List<MemberDTO> memberList = dao.getMemberList(start_page, member_email_search);
		logger.info("memberList의 size : " + memberList.size());
		return memberList;
	}

	@Override
	public List<MemberDTO> getMember_email_like(String member_email) throws Exception {
		List<MemberDTO> memberList =  dao.getMember_email_like(member_email);
		return memberList;
	}
	
	/**
	 * @author 김준혁
	 * 매장 추가시 방금 생성한 점장의 정보를 DB에서 호출하는 메서드
	 */
	@Override
	public JSONObject getCreate_owner() throws Exception {
		JSONObject jsonRoot = new JSONObject();
		MemberDTO dto = dao.getCreate_owner();
		jsonRoot.put("flag", "true");
		jsonRoot.put("member_no", dto.getMember_no());
		jsonRoot.put("member_name", URLEncoder.encode(dto.getMember_name(), "utf-8"));
		return jsonRoot;
	}
	
	/**
	 * @author 김준혁
	 * 매장 추가에서 기존 점장 검색 후 List에 담긴 MemberDTO를 json 형태로 변환
	 */
	@Override
	public JSONObject getSearchOnwerList(String member_email) throws Exception {
		JSONObject jsonRoot = new JSONObject();
		JSONArray jsonAl = new JSONArray();
		JSONObject jsonTemp = null;
		MemberDTO dto = null;
		List<MemberDTO> ownerList = dao.getMember_email_like(member_email);
		for(int i=0; i<ownerList.size(); i++){
			dto = ownerList.get(i);
			jsonTemp = new JSONObject();
			jsonTemp.put("member_no", dto.getMember_no());
			jsonTemp.put("member_name", URLEncoder.encode(dto.getMember_name(), "utf-8"));
			jsonTemp.put("member_email", dto.getMember_email());
			jsonTemp.put("member_code", dto.getMember_code());
			jsonAl.add(jsonTemp);
		}
		jsonRoot.put("ownerList", jsonAl);
		return  jsonRoot;
	}
	
	/**
	 * @author 김준혁
	 * 매장 추가에서 점장 생성 시 사용자에게 이메일을 입력받아 중복되는 이메일이 없는지 확인
	 */
	@Override
	public boolean isExistEmail(String member_email) throws Exception {
		MemberDTO dto = dao.getMember_email(member_email);
		if(dto == null){
			return false;
		}
		else{
			return true;
		}
	}
	
	@Override
	public boolean updateMember_pw(MemberDTO dto) throws Exception {
		return dao.updateMember_pw(dto);
	}
}
