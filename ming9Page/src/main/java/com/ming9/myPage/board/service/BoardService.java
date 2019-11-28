package com.ming9.myPage.board.service;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.ming9.myPage.board.domain.BoardDTO;

public interface BoardService{

	public JSONObject getBoardList(String usrIdx) throws Exception;
	
	public boolean insertBoard(BoardDTO dto,HttpSession session) throws Exception;
}
