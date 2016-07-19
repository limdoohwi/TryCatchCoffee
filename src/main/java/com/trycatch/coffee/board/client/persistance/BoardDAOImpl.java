package com.trycatch.coffee.board.client.persistance;

import java.util.List;

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
	public BoardDTO read(Integer board_num) throws Exception {
		sqlSession.update(NAMESPACE + ".hits_up", board_num);
		return sqlSession.selectOne(NAMESPACE +".read", board_num) ;
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

}