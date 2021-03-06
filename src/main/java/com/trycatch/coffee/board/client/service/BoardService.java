package com.trycatch.coffee.board.client.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.trycatch.coffee.board.client.domain.BoardDTO;

public interface BoardService {
	  public void insert(BoardDTO board, int member_no) throws Exception;
	  public BoardDTO read(BoardDTO board) throws Exception;
	  public void update(BoardDTO board) throws Exception;
	  public void delete(Integer board_num) throws Exception;
	  public void delete_reply(BoardDTO board) throws Exception;
	  public List<BoardDTO> listAll() throws Exception;
	  public BoardDTO check_password(String board_password, String board_num) throws Exception;
	  public void reply(BoardDTO board, int member_no, int parent_board_num, int board_group) throws Exception;
	  public List<BoardDTO> search(String keyValue, String keyWord) throws Exception;
	  public List<BoardDTO> listAll_withMember_no_Date(int member_no, int start_page, String date) throws Exception;
}
