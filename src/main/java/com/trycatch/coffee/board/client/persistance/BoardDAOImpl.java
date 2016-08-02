package com.trycatch.coffee.board.client.persistance;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.board.client.domain.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static String NAMESPACE = "com.trycatch.coffee.mappers.boardMapper";
	
	@Override
	public void insert(BoardDTO board, int member_no) throws Exception {
		board.setMember_no(member_no);
		sqlSession.update(NAMESPACE + ".pos_up");
		sqlSession.insert(NAMESPACE + ".insert", board);
	}

	@Override
	public BoardDTO read(BoardDTO board) throws Exception {
		sqlSession.update(NAMESPACE + ".hits_up", board);
		return sqlSession.selectOne(NAMESPACE +".read", board) ;
	}

	@Override
	public void update(BoardDTO board) throws Exception {
		sqlSession.update(NAMESPACE + ".update", board);
	}

	@Override
	public void delete(Integer board_num) throws Exception {
		sqlSession.delete(NAMESPACE + ".delete", board_num);
	}
	
	@Override
	public void delete_reply(BoardDTO board) throws Exception {
		sqlSession.delete(NAMESPACE+".delete_reply", board);
	}

	@Override
	public List<BoardDTO> listAll() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".listAll") ;
	}

	@Override
	public void reply(BoardDTO board, int member_no, int parent_board_num, int board_group) throws Exception {
		board.setMember_no(member_no);
		if(board_group ==0){
			board.setBoard_group(parent_board_num);
		}
		else if(board_group != 0){
			board.setBoard_group(board_group);
		}
		sqlSession.update(NAMESPACE + ".reply_pos_up", board);
		sqlSession.insert(NAMESPACE + ".reply", board);
	}
	
	@Override
	public BoardDTO check_password(String board_password, String board_num){
		Map<String, String> map = new HashMap<>();
		map.put("board_num", board_num);
		map.put("board_password", board_password);
		try{
			return sqlSession.selectOne(NAMESPACE + ".check_password", map);			
		}
		catch(Exception err){
			return null;
		}
	}

	@Override
	public List<BoardDTO> search(String keyValue, String keyWord) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("keyValue", keyValue);
		map.put("keyWord", keyWord);
		return sqlSession.selectList(NAMESPACE +".search", map);
	}
}