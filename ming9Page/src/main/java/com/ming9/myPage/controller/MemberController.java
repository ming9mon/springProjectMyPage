package com.ming9.myPage.controller;

import java.io.File;
import java.util.Collections;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.ming9.myPage.domain.MemberDTO;
import com.ming9.myPage.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	Properties properties;
	
	//로그인 페이지 이동
	@RequestMapping(value = "/member/login.do")
	public ModelAndView login(Model model){
		ModelAndView mav = new ModelAndView("/member/login");
		mav.addObject("gClientId",properties.get("google.login.clientId"));
		return mav;
	}
	
	//회원가입 페이지 이동
	@RequestMapping(value="/member/signUpPage.do")
	public String signUpPage(){
		return "/member/signUp";
	}

	//아이디 중복 체크
	@RequestMapping(value="/member/idCheck.do")
	@ResponseBody
	public int idCheck(HttpServletRequest request) {
		String userId=request.getParameter("userId");
		int result = service.idCheck(userId);
		
		return result;
	}
	

	//닉네임 중복 체크
	@RequestMapping(value="/member/nickNmCheck.do")
	@ResponseBody
	public int nickNmCheck(HttpServletRequest request) {
		String nickNm = request.getParameter("nickNm");
		int result = service.nickNmCheck(nickNm);
		
		return result;
	}
	
	//회원가입 기능
	@RequestMapping(value="/member/signUp.do", method=RequestMethod.POST)
	public String signUp(MemberDTO dto,RedirectAttributes rttr){

		dto.setJoinInfo("l");
		int result = service.signUp(dto);
		
		if(result > 0) {
			rttr.addFlashAttribute("result","성공");
		}else {
			rttr.addFlashAttribute("result","실패");
		}
		
		return "redirect:login.do";
	}
	
	//로그인 기능
	@RequestMapping(value="/member/loginCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public boolean loginCheck(MemberDTO dto,HttpSession session) {
		
		boolean result = service.login(dto,session);
		
		return result;
	}
	
	//구글 로그인 기능
	@PostMapping(value="/member/googleLogin.do", produces="application/x-www-form-urlencoded")
	@ResponseBody
	public String googleLogin(@RequestBody String param,HttpSession session) {
		
		String result = service.googleLogin(param,session);
		
		return result;
	}
	
	//구글 회원가입
	@PostMapping(value="/member/googleSignUp.do", produces="application/x-www-form-urlencoded")
	@ResponseBody
	public String googleSignUp(MemberDTO dto,HttpSession session) {
		
		String result = service.googleSignUp(dto,session);
		
		return result;
	}
	
	//로그아웃
	@RequestMapping(value="/member/logout.do")
	public String logout(HttpSession session) {
		service.logout(session);
		return "redirect:/";
	}
	

}