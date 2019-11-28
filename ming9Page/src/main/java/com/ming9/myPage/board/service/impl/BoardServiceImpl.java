package com.ming9.myPage.board.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ming9.myPage.board.dao.BoardDAO;
import com.ming9.myPage.board.domain.BoardDTO;
import com.ming9.myPage.board.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardDAO dao;

	// 글 리스트
	public JSONObject getBoardList(String usrIdx) throws Exception {
		JSONObject rstObj = new JSONObject();
		int rtnCd=0;
		
		try {
			List<BoardDTO> list = dao.getBoardList(usrIdx);
			rstObj.put("RST", list);
		}catch(Exception e) {
			rtnCd=-1;
		}
		
		rstObj.put("RTNCD", rtnCd);
		return rstObj;
	}

	//글 쓰기
	public boolean insertBoard(BoardDTO dto,HttpSession session) throws Exception {
		//글쓴놈이 보낸 usrIdx랑 세션 usrIdx랑 같지 않으면 false 리턴
		if(Integer.parseInt(session.getAttribute("usrIdx").toString()) != dto.getUsrIdx()) return false;
		//널 값 체크
		if(dto.getTitle() == null || dto.getContent() == null)
			return false;
		
		return dao.insertBoard(dto);
	}

}
