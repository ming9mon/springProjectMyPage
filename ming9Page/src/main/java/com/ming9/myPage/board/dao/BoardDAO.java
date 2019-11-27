package com.ming9.myPage.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ming9.myPage.board.domain.BoardDTO;

@Repository
public class BoardDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	public List<BoardDTO> getBoardList(String usrIdx){
		return sql.selectList("boardMapper.selectBoardList",usrIdx);
	}
}
