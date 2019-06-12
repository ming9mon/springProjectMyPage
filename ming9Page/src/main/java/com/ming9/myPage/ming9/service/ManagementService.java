package com.ming9.myPage.service;

import java.util.List;

import com.ming9.myPage.domain.MemberDTO;

public interface ManagementService {

	//회원 목록 조회
	public List<MemberDTO> getMemberList();
}
