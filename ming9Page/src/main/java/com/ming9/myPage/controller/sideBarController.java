package com.ming9.myPage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class sideBarController {

	@RequestMapping(value="/weather.do")
	public String weather() {
		return "/weather/weather";
	}
	
	@GetMapping(value="/kakao/kakaoMap.do")
	public String kakaoMapView() {
		return "/kakaoMap/kakaoMap";
	}
}