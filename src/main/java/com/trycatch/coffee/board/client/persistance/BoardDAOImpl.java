package com.trycatch.coffee.board.client.persistance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.board.client.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static String NAMESPACE = "com.trycatch.coffee.mappers.boardMapper";
	
	@Override
	public void insert(BoardVO board) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert", board);
	}

	@Override
	public BoardVO read(Integer board_num, String board_password) throws Exception {
		return sqlSession.selectOne(NAMESPACE +".read", board_num) ;
	}

	@Override
	public void update(BoardVO board) throws Exception {
		sqlSession.update(NAMESPACE + ".update", board);
	}

	@Override
	public void delete(Integer board_num) throws Exception {
		sqlSession.delete(NAMESPACE + ".delete", board_num);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".listAll") ;
	}

	@Override
	public void reply(BoardVO board) throws Exception {
		sqlSession.insert(NAMESPACE + ".reply", board);
	}

//	@Override
//	public BoardVO check_pass(Integer board_num, String board_password) throws Exception {
//		return sqlSession.select(NAMESPACE + ".pass", board_num, board_password);
//	}

}