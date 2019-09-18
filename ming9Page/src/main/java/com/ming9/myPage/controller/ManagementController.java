package com.ming9.myPage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ming9.myPage.domain.MemberDTO;
import com.ming9.myPage.service.ManagementService;

@Controller
public class ManagementController {
	
	@Autowired
	ManagementService service;
	
	//회원 리스트
	@RequestMapping(value="managementPage.do")
	public String managementPage(Model model) {
		
		List<MemberDTO> memberList = service.getMemberList();
		
		model.addAttribute("memberList", memberList);
		
		return "/ming9/management";
	}
	
	//회원 삭제
	@RequestMapping(value="memdel.do")
	@ResponseBody
	public int memdel(HttpServletRequest request) {
		String userId = request.getParameter("userId");
		return service.memdel(userId);
	}
	
	
}
