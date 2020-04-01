package com.ming9.myPage.member.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ming9.myPage.member.dao.ManagementDAO;
import com.ming9.myPage.member.domain.MemberDTO;
import com.ming9.myPage.member.service.ManagementService;

@Service
public class ManagementServiceImpl implements ManagementService {

	@Autowired
	ManagementDAO dao;
	
	//회원 목록 조회
	@Override
	public List<MemberDTO> getMemberList() {
		return dao.getMemberList();
	}

	//회원 삭제
	@Override
	public int memdel(String userId) {
		return dao.memdel(userId);
	}
}
