package com.ming9.myPage.board.service;

import org.json.simple.JSONObject;

public interface BoardService{

	public JSONObject getBoardList(String usrIdx) throws Exception;
}
