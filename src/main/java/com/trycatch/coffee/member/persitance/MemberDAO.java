package com.trycatch.coffee.member.persitance;

import java.util.List;

import org.json.simple.JSONObject;

import com.trycatch.coffee.meeting_room.domain.MeetingRoomReservationDTO;
import com.trycatch.coffee.member.domain.MemberDTO;

public interface MemberDAO {
	public boolean insertMember(MemberDTO dto);
	public void deleteMember(int member_no);
	public void updateMember(MemberDTO dto);
	public List<MemberDTO> getMemberList();
	public MemberDTO getMember_no(int member_no);
	public MemberDTO getMember_email(String member_email);
	public List<MemberDTO> getMember_email_like(String member_email);
	public MemberDTO getCreate_owner();
	public MemberDTO getMember_WithPW(String member_email,String member_pw);
	public boolean updateMember_pw(MemberDTO dto);

}
