package com.trycatch.coffee.member.persitance;


import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.trycatch.coffee.member.domain.MemberDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MemberDAOImplTest {
	@Inject
	private MemberDAO dao;
	@Test
	public void testInsertMember() {
		MemberDTO dto = new MemberDTO();
		dto.setMember_email("admin@co.kr");
		dto.setMember_pw("1111");
		dto.setMember_name("관리자");
		dto.setMember_birth("88/02/09");
		dto.setMember_tel("01020406977");
		dto.setMember_code(3);
		
		System.out.println(dao.insertMember(dto));
	}

}
