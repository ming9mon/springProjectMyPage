package com.ming9.myPage.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	//로그아웃
	
	//아이디 중복 체크
	public int idCheck(String userId) {
		System.out.println("====> 다오 아이디 체크");
		return session.selectOne("memberMapper.idCheck",userId);
	}
	
	//회원가입
	public int signUp(MemberDTO dto) {
		System.out.println("====> 다오 회원가입");
		return session.insert("memberMapper.signUp",dto);
	}
	
}
