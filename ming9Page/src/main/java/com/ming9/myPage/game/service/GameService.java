package com.ming9.myPage.game.service;

import java.util.List;

import com.ming9.myPage.game.domain.GameDTO;

public interface GameService {
	
	public int insertScore(GameDTO dto);
	
	public List<GameDTO> getRank(GameDTO dto);
}
