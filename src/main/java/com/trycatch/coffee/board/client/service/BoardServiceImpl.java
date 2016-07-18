package com.trycatch.coffee.board.client.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.board.client.domain.BoardVO;
import com.trycatch.coffee.board.client.persistance.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	BoardDAO dao;
	
	@Override
	public void insert(BoardVO board) throws Exception {
		dao.insert(board);
	}

	@Override
	public BoardVO read(Integer board_num, String board_password) throws Exception {
		return dao.read(board_num, board_password);
	}

	@Override
	public void update(BoardVO board) throws Exception {
		dao.update(board);
	}

	@Override
	public void delete(Integer board_num) throws Exception {
		dao.delete(board_num);
	}
	
	@Override
	public List<BoardVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public void reply(BoardVO board) throws Exception {
		dao.reply(board);
	}

//	@Override
//	public BoardVO check_pass(Integer board_num, String board_password) throws Exception {
//		return dao.check_pass(board_num, board_password);
//	}

}
