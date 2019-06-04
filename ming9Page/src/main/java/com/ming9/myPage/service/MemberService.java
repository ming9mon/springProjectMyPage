package com.ming9.myPage.service;

import javax.servlet.http.HttpSession;

import com.ming9.myPage.domain.MemberDTO;

public interface MemberService {

	//로그인 기능
	public boolean login(MemberDTO dto,HttpSession session);
	
	//로그아웃 기능
	public void logout();
	
	//아이디 체크
	public int idCheck(String userId);
	//회원가입
	
}
