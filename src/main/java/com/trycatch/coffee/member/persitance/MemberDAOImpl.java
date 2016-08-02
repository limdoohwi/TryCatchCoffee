package com.trycatch.coffee.member.persitance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.member.domain.MemberDTO;
@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.memberMapper";
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
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
	public List<MemberDTO> getMemberList(int start_page, String member_email_search) {
		Map<String, String> map = new HashMap<>();
		map.put("member_email_search", member_email_search);
		RowBounds row = new RowBounds(start_page, 5);
		try{
			return sqlSession.selectList(NAMESPACE + ".getMemberList", map, row);
		}catch(Exception err){
			err.printStackTrace();
			return null;
		}
	}

	@Override
	public MemberDTO getMember_no(int member_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberDTO getMember_email(String member_email) {
		try{
			return sqlSession.selectOne(NAMESPACE + ".getMember_email", member_email);
		}
		catch(Exception err){
			return null;
		}
		
	}

	@Override
	public MemberDTO getMember_WithPW(String member_email, String member_pw) {
		try{
			Map<String, Object> map = new HashMap<>();
			map.put("member_email", member_email);
			map.put("member_pw", member_pw);
			return sqlSession.selectOne("getMember_WithPW",map);
		}
		catch(Exception err){
			return null;
		}
	}

	@Override
	public List<MemberDTO> getMember_email_like(String member_email) {
		try {
			return sqlSession.selectList(NAMESPACE + ".getMember_email_like", member_email);
		}
		catch (Exception err) {
			return null;
		}
	}

	@Override
	public MemberDTO getCreate_owner() {
		try {
			List<MemberDTO> list = sqlSession.selectList(NAMESPACE + ".getCreate_owner");
			MemberDTO dto = list.get(0);
			return dto;
		} 
		catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public boolean updateMember_pw(MemberDTO dto) {
		try {
			sqlSession.update(NAMESPACE + ".updateMeber_Pw", dto);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
}
