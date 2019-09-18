package com.ming9.myPage.controller;

import java.util.Date;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CommonController {

	//서버 시간
	@GetMapping(value="getDate.do")
	public Date getDate(){
		Date date = new Date();
		return date;
	}
}
