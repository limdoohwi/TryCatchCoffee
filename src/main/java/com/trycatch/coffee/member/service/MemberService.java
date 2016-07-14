package com.trycatch.coffee.member.service;


import com.trycatch.coffee.member.domain.MemberDTO;

public interface MemberService {
	public boolean register(MemberDTO dto) throws Exception;
	public MemberDTO login(String member_email,String member_pw) throws Exception;
}
