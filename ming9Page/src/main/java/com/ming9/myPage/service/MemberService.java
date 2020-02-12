package com.ming9.myPage.service;

import javax.servlet.http.HttpSession;

import org.springframework.transaction.annotation.Transactional;

import com.ming9.myPage.domain.MemberDTO;

public interface MemberService {

	//로그인 기능
	@Transactional
	public boolean login(MemberDTO dto,HttpSession session);
	
	//로그아웃 기능
	public void logout(HttpSession session);

	//아이디 체크
	public int idCheck(String userId);
	
	//닉네임 체크
	public int nickNmCheck(String nickNm);
	
	//회원가입
	@Transactional
	public int signUp(MemberDTO dto);

	//구글 로그인
	@Transactional
	public String googleLogin(String param,HttpSession session);
	
	//구글 회원가입
	@Transactional
	public String googleSignUp(MemberDTO dto,HttpSession session);

}
