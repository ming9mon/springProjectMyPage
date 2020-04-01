package com.ming9.myPage.member.service;

import java.util.List;

import com.ming9.myPage.member.domain.MemberDTO;

public interface ManagementService {

	//회원 목록 조회
	public List<MemberDTO> getMemberList();
	
	//회원 삭제
	public int memdel(String userId);
}
