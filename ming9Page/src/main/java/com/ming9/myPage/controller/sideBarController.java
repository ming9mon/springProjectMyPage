package com.ming9.myPage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
