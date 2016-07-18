package com.trycatch.coffee.board.client.service;

import java.util.List;

import com.trycatch.coffee.board.client.domain.BoardVO;


public interface BoardService {
	  public void insert(BoardVO board) throws Exception;
	  public BoardVO read(Integer board_num, String board_password) throws Exception;
	  public void update(BoardVO board) throws Exception;
	  public void delete(Integer board_num) throws Exception;
	  public List<BoardVO> listAll() throws Exception;
//	  public BoardVO check_pass(Integer board_num, String board_password) throws Exception;
	  public void reply(BoardVO board) throws Exception;
}
