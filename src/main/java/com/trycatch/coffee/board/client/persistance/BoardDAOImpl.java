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
		sqlSession.update(NAMESPACE + ".pos_up");
		sqlSession.insert(NAMESPACE + ".insert", board);
	}

	@Override
	public BoardDTO read(BoardDTO board) throws Exception {
		System.out.println("조회수:"+board.getBoard_hits());
		System.out.println("글번호:"+board.getBoard_num());
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
	public List<BoardDTO> listAll() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".listAll") ;
	}

	@Override
	public void reply(BoardDTO board, int member_no) throws Exception {
		sqlSession.update(NAMESPACE + ".reply_pos_up", board);
		sqlSession.insert(NAMESPACE + ".reply", board);
	}
	
	@Override
	public BoardDTO check_password(BoardDTO board){
		try{
			
			return sqlSession.selectOne(NAMESPACE + ".check_password", board);			
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
		System.out.println(keyValue + "," +keyWord);
		return sqlSession.selectList(NAMESPACE +".search", map);
	}
}