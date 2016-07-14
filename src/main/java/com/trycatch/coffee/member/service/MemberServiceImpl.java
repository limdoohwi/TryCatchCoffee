package com.trycatch.coffee.member.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.persitance.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	private MemberDAO dao;
	@Override
	public boolean register(MemberDTO dto) throws Exception {
		dto.setMember_code(1);
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

}
