package com.ming9.myPage.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberDTO {
	
	private int usrIdx;
	private String userId;
	private String passwd;
	private String name;
	private String nickName;
	private int phonNumber;
	private String email;
	private int rating;
	private String imgName;
	private MultipartFile img;
	private String joinInfo;	//g 구글,	l 일반 회원가입
	private String lastLogin;
	private String instDate;
	
}
