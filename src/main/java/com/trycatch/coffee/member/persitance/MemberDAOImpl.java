package com.trycatch.coffee.member.persitance;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.member.domain.MemberDTO;
@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.memberMapper";
	@Override
	public boolean insertMember(MemberDTO dto) {
		// TODO 회원 가입 DB연결
		try{
			sqlSession.insert(NAMESPACE+".insertMember", dto);
			return true;
		}
		catch(Exception err){
			return false;
		}
		
	}

	@Override
	public void deleteMember(int member_no) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateMember(MemberDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<MemberDTO> getMemberList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberDTO getMember_no(int member_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberDTO getMember_email(String member_email) {
		try{
			return sqlSession.selectOne("getMember_email",member_email);
		}
		catch(Exception err){
			return null;
		}
		
	}

}
