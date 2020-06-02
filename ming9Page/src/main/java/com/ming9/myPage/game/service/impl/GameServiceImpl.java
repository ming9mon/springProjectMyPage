package com.ming9.myPage.game.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ming9.myPage.game.dao.GameDao;
import com.ming9.myPage.game.domain.GameDTO;
import com.ming9.myPage.game.service.GameService;

@Service
public class GameServiceImpl implements GameService{

	@Autowired
	private GameDao dao;
	
	@Override
	public int insertScore(GameDTO dto) {
		GameDTO rst = dao.getScore(dto);
		if(rst == null)
			return dao.insertScore(dto);
		else if(rst.getScore() < dto.getScore())
			return dao.updateScore(dto);
		else 
			return 1;	
	}

	@Override
	public List<GameDTO> getRank(GameDTO dto) {
		return dao.getRank(dto);
	}

}
