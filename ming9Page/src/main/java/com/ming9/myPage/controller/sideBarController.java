package com.ming9.myPage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class sideBarController {

	@GetMapping(value="/weather.do")
	public String weather() {
		return "weather/weather";
	}
	
	@GetMapping(value="/kakao/kakaoMap.do")
	public String kakaoMapView() {
		return "kakaoMap/kakaoMap";
	}
	
	@GetMapping(value="/boardList.do")
	public String boardList() {
		return "board/boardList";
	}
	
	@GetMapping(value="/blog.do")
	public String blog() {
		return "blog";
	}
	
	@GetMapping(value="/calendar.do")
	public String calendar() {
		return "calendar/calendar";
	}
	
	@GetMapping(value="/etc/upAndLow.do")
	public String upAndLow() {
		return "etc/upAndLow";
	}

	@GetMapping(value="/game/wormGame.do")
	public String wormGame() {
		return "game/wormGame";
	}
	
	@GetMapping(value="/game/tetris.do")
	public String tetris() {
		return "game/tetris";
	}
	
	@GetMapping(value="/game/game2048.do")
	public String game2048() {
		return "game/game2048";
	}
	
	@GetMapping(value="/test")
	public String test() {
		return "test";
	}

	@GetMapping(value="/test2")
	public String test2() {
		return "test2";
	}
}
