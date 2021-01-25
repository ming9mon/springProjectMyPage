package com.ming9.myPage.game.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ming9.myPage.game.domain.GameDTO;

@Repository
public class GameDao {

	@Autowired
	private SqlSessionTemplate sql;
	
	public GameDTO getScore(GameDTO dto) {
		return sql.selectOne("gameMapper.getScore",dto);
	}
	
	public GameDTO getLandMineScore(GameDTO dto) {
		return sql.selectOne("gameMapper.getLandMineScore",dto);
	}
	
	public int insertScore(GameDTO dto) {
		return sql.insert("gameMapper.insertScore",dto);
	}
	
	public int updateScore(GameDTO dto) {
		return sql.update("gameMapper.updateScore",dto);
	}
	
	public List<GameDTO> getRank(GameDTO dto){
		return sql.selectList("gameMapper.getRank", dto);
	}
}
