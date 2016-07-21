package com.trycatch.coffee.board.client.persistance;

import java.util.List;

import com.trycatch.coffee.board.client.domain.BoardDTO;

public interface BoardDAO {
	  public void insert(BoardDTO board, int member_no) throws Exception;
	  public BoardDTO read(BoardDTO board) throws Exception;
	  public void update(BoardDTO board) throws Exception;
	  public void delete(Integer board_num) throws Exception;
	  public void delete_reply(BoardDTO board) throws Exception;
	  public List<BoardDTO> listAll() throws Exception;
	  public BoardDTO check_password(String board_password, String board_num) throws Exception;
	  public void reply(BoardDTO board, int member_no) throws Exception;
	  public List<BoardDTO> search(String keyValue, String keyWord) throws Exception;
}