package com.ming9.myPage.controller;

import javax.servlet.http.HttpServletRequest;
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
	
	//아이디 중복 체크
	@RequestMapping(value="/member/idCheck")
	@ResponseBody
	public int idCheck(HttpServletRequest request) {
		String userId=request.getParameter("userId");
		int result = service.idCheck(userId);
		
		return result;
	}
	
	//회원가입 기능
	@RequestMapping(value="/member/signUp", method=RequestMethod.POST)
	public String signUp(MemberDTO dto){
		
		/*
		 * 
		 * 여기 만들장
		 */
		return "/member/login";
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