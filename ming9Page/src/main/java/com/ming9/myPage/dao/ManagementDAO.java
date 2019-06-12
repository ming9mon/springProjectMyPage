package com.ming9.myPage.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ming9.myPage.domain.MemberDTO;

@Repository
public class ManagementDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	//회원 목록 조회
	public List<MemberDTO> getMemberList() {
		System.out.println("다오 -----> 멤버 리스트 조회");
		return sql.selectList("mgmtMapper.memberList");
	}
	
	//회원 삭제
	public int memdel(String userId) {
		System.out.println(userId + "회원 삭제");
		return sql.delete("memdel",userId);
	}
	
}
