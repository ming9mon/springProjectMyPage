package com.ming9.myPage.board.controller;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ming9.myPage.board.domain.BoardDTO;
import com.ming9.myPage.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService service;
	
	@GetMapping(value="/getBoardList.do")
	@ResponseBody
	public JSONObject getBoardList(HttpSession session) throws Exception{
		String usrIdx=null;
		if(session.getAttribute("usrIdx") != null) {
			usrIdx = session.getAttribute("usrIdx").toString();
		}
		return service.getBoardList(usrIdx);
	}
	
	@GetMapping(value="/board/writeFrm.do")
	public String writeFrm() {
		return "/board/writeBoard";
	}
	
	@PostMapping(value="/board/write.do")
	@ResponseBody
	public boolean write(BoardDTO dto, HttpSession session) throws Exception{
		if(dto.getSecret() != 'Y') dto.setSecret('N');
		return service.insertBoard(dto,session);
	}
}
