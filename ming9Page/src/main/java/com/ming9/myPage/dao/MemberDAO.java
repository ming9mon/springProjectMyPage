package com.ming9.myPage.dao;

import java.sql.SQLDataException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ming9.myPage.domain.MemberDTO;

@Repository
public class MemberDAO {

	@Autowired
	SqlSessionTemplate session;
	
	//로그인 기능
	public boolean login(MemberDTO dto) {
		
		boolean result =session.selectOne("memberMapper.login", dto);
		System.out.println("====> 다오 로그인 기능");
		return result;
	}
	
	//유저 정보
	public MemberDTO getUserInfo(MemberDTO dto) {
		return session.selectOne("memberMapper.getUserInfo", dto);
	}
	
	//아이디 중복 체크
	public int idCheck(String userId) {
		System.out.println("====> 다오 아이디 체크");
		return session.selectOne("memberMapper.idCheck",userId);
	}
	
	//아이디 중복 체크
	public int nickNmCheck(String nickNm) {
		System.out.println("====> 다오 닉네임 체크");
		return session.selectOne("memberMapper.nickNmCheck",nickNm);
	}
	
	//회원가입
	@Transactional
	public int signUp(MemberDTO dto) {
		System.out.println("====> 다오 회원가입");
		int rst = session.insert("memberMapper.signUp",dto);
		rst *= session.insert("memberMapper.signUp2",dto);
		return rst;
	}

	public void insertLoginInfo(int usrIdx) {
		session.insert("memberMapper.insertLoginHis",usrIdx);
	}

}
