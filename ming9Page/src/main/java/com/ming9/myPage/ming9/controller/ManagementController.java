package com.ming9.myPage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ming9.myPage.domain.MemberDTO;
import com.ming9.myPage.service.ManagementService;

@Controller
public class ManagementController {
	
	@Autowired
	ManagementService service;
	
	@RequestMapping(value="managementPage")
	public String managementPage(Model model) {
		
		List<MemberDTO> memberList = service.getMemberList();
		
		model.addAttribute("memberList", memberList);
		
		return "/ming9/management";
	}
}
