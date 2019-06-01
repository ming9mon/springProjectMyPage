package com.ming9.myPage.service;

import javax.servlet.http.HttpSession;

import com.ming9.myPage.domain.MemberDTO;

public interface MemberService {

	public boolean login(MemberDTO dto,HttpSession session);
	
	public void logout();
	
}
