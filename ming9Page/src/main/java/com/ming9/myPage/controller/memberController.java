package com.ming9.myPage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ming9.myPage.domain.MemberDTO;
import com.ming9.myPage.service.MemberService;

@Controller
public class memberController {
	
	@Autowired
	MemberService service;
	
	//로그인 페이지 이동
	@RequestMapping(value = "/member/login")
	public String login(){
		return "/member/login";
	}
	
	//회원가입 페이지 이동
	@RequestMapping(value="/member/signUpPage")
	public String signUpPage(){
		return "/member/signUp";
	}
	
	//로그인 기능
	@RequestMapping(value="/member/loginCheck", method=RequestMethod.POST)
	@ResponseBody
	public boolean loginCheck(MemberDTO dto,HttpSession session) {
		
		boolean result = service.login(dto,session);
		
		return result;
	}
	
	//로그아웃
	@RequestMapping(value="/member/logout", method=RequestMethod.POST)
	public String logout() {
		
		return "index";
	}
	
	
}