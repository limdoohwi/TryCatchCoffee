package com.trycatch.coffee.member.service;


import java.util.List;

import org.json.simple.JSONObject;

import com.trycatch.coffee.member.domain.MemberDTO;

public interface MemberService {
	public boolean register(MemberDTO dto) throws Exception;
	public MemberDTO login(String member_email,String member_pw) throws Exception;
	public List<MemberDTO> getMemberList() throws Exception;
	public List<MemberDTO> getMember_email_like(String member_email) throws Exception;
	public JSONObject getCreate_owner() throws Exception;
	public JSONObject getSearchOnwerList(String member_email) throws Exception;
	public boolean isExistEmail(String member_email) throws Exception;
}
