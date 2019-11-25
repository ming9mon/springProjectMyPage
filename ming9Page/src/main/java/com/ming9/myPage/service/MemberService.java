package com.ming9.myPage.service;

import javax.servlet.http.HttpSession;

import com.ming9.myPage.domain.MemberDTO;

public interface MemberService {

	//로그인 기능
	public boolean login(MemberDTO dto,HttpSession session);
	
	//로그아웃 기능
	public void logout(HttpSession session);
	
	//아이디 체크
	public int idCheck(String userId);
	
	//회원가입
	public int signUp(MemberDTO dto);
	
	//구글 로그인
	public String googleLogin(String param,HttpSession session);
	
}
