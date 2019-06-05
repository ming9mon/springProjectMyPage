package com.ming9.myPage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Management {
	
	@RequestMapping(value="managementPage")
	public String managementPage() {
		return "/ming9/management";
	}
}
