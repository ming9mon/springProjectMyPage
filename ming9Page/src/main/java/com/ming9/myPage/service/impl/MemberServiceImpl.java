package com.ming9.myPage.service.impl;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ming9.myPage.DAO.MemberDAO;
import com.ming9.myPage.domain.MemberDTO;
import com.ming9.myPage.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO dao;
	
	//로그인 기능
	public boolean login(MemberDTO dto,HttpSession session) {
		
		boolean result=dao.login(dto);
		
		if(result) {
			//true일경우 세션 변수 등록
			session.setAttribute("userId",dto.getUserId());
		}
		
		return result;
	}

	//로그아웃 기능
	public void logout() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int idCheck(String userId) {
		return dao.idCheck(userId);
	}

}
