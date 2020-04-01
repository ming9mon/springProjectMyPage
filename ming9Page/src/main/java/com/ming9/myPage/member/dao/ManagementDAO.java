package com.ming9.myPage.member.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ming9.myPage.member.domain.MemberDTO;

@Repository
public class ManagementDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	//회원 목록 조회
	public List<MemberDTO> getMemberList() {
		return sql.selectList("mgmtMapper.memberList");
	}
	
	//회원 삭제
	public int memdel(String userId) {
		return sql.delete("memdel",userId);
	}
	
}
