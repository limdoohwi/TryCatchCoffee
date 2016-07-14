package com.trycatch.coffee.member.persitance;

import java.util.List;

import com.trycatch.coffee.member.domain.MemberDTO;

public interface MemberDAO {
	public boolean insertMember(MemberDTO dto);
	public void deleteMember(int member_no);
	public void updateMember(MemberDTO dto);
	public List<MemberDTO> getMemberList();
	public MemberDTO getMember_no(int member_no);
	public MemberDTO getMember_email(String member_email);
}
