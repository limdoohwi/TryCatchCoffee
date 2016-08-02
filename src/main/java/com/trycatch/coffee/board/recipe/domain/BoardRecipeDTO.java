package com.trycatch.coffee.board.recipe.domain;

import java.util.Date;

public class BoardRecipeDTO {
	private String board_recipe_title;
	private String board_recipe_content;
	private String board_recipe_writer;
	private Date board_recipe_date;
	private int board_recipe_no,board_recipe_likes,board_recipe_count;
	private String board_recipe_file;
	
	private int totalpage;
	private int nowperpage;
	
	private int totalblock;
	private int nowblock;
	private int nowperblock;
	
	
	public int getTotalpage() {
		return totalpage;
	}
	public void setTotalpage(int totalpage) {
		this.totalpage = totalpage;
	}
	public int getNowperpage() {
		return nowperpage;
	}
	public void setNowperpage(int nowperpage) {
		this.nowperpage = nowperpage;
	}
	public int getTotalblock() {
		return totalblock;
	}
	public void setTotalblock(int totalblock) {
		this.totalblock = totalblock;
	}
	public int getNowblock() {
		return nowblock;
	}
	public void setNowblock(int nowblock) {
		this.nowblock = nowblock;
	}
	public int getNowperblock() {
		return nowperblock;
	}
	public void setNowperblock(int nowperblock) {
		this.nowperblock = nowperblock;
	}

	


	public String getBoard_recipe_file() {
		return board_recipe_file;
	}
	public void setBoard_recipe_file(String board_recipe_file) {
		this.board_recipe_file = board_recipe_file;
	}
	public int getBoard_recipe_no() {
		return board_recipe_no;
	}
	public void setBoard_recipe_no(int board_recipe_no) {
		this.board_recipe_no = board_recipe_no;
	}
	public String getBoard_recipe_title() {
		return board_recipe_title;
	}
	public void setBoard_recipe_title(String board_recipe_title) {
		this.board_recipe_title = board_recipe_title;
	}
	public String getBoard_recipe_content() {
		return board_recipe_content;
	}
	public void setBoard_recipe_content(String board_recipe_content) {
		this.board_recipe_content = board_recipe_content;
	}
	public String getBoard_recipe_writer() {
		return board_recipe_writer;
	}
	public void setBoard_recipe_writer(String board_recipe_writer) {
		this.board_recipe_writer = board_recipe_writer;
	}
	public Date getBoard_recipe_date() {
		return board_recipe_date;
	}
	public void setBoard_recipe_date(Date board_recipe_date) {
		this.board_recipe_date = board_recipe_date;
	}
	public int getBoard_recipe_likes() {
		return board_recipe_likes;
	}
	public void setBoard_recipe_likes(int board_recipe_likes) {
		this.board_recipe_likes = board_recipe_likes;
	}
	public int getBoard_recipe_count() {
		return board_recipe_count;
	}
	public void setBoard_recipe_count(int board_recipe_count) {
		this.board_recipe_count = board_recipe_count;
	}
	
	
}
