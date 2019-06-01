package com.ming9.myPage.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ming9.myPage.domain.MemberDTO;

@Repository
public class MemberDAO {

	@Autowired
	SqlSessionTemplate session;
	
	public boolean login(MemberDTO dto) {
		
		boolean result =session.selectOne("memberMapper.login", dto);
		System.out.println("다오 : "+result +" "+dto.getUserId()+" "+dto.getPasswd());
		return result;
	}
	
}
