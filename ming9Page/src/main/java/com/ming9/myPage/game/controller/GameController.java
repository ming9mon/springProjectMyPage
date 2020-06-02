package com.ming9.myPage.game.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ming9.myPage.game.domain.GameDTO;
import com.ming9.myPage.game.service.GameService;

@RestController
public class GameController {
	
	@Autowired
	private GameService gameService;

	@GetMapping(value="/game/insertScore.do")
	public int insertScore(GameDTO dto) {
		return gameService.insertScore(dto);
	}

	@GetMapping(value="/game/getRank.do")
	public List<GameDTO> getRank(GameDTO dto){
		return gameService.getRank(dto);
	}
}
