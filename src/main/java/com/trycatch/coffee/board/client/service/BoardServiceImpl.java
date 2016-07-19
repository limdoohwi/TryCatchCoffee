package com.trycatch.coffee.board.client.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.board.client.domain.BoardDTO;
import com.trycatch.coffee.board.client.persistance.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	BoardDAO dao; //member_dto.member_name
	
	@Override
	public void insert(BoardDTO board, int member_no) throws Exception {
		dao.insert(board, member_no);
	}

	@Override
	public BoardDTO read(Integer board_num) throws Exception {
		return dao.read(board_num);
	}

	@Override
	public void update(BoardDTO board) throws Exception {
		dao.update(board);
	}

	@Override
	public void delete(Integer board_num) throws Exception {
		dao.delete(board_num);
	}
	
	@Override
	public List<BoardDTO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public void reply(BoardDTO board, int member_no) throws Exception {
		dao.reply(board, member_no);
	}

	@Override
	public BoardDTO check_password(BoardDTO board) throws Exception{
		return dao.check_password(board);
	}

}
