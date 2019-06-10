package com.ming9.myPage.domain;

import lombok.Data;

@Data
public class MemberDTO {
	
	private String userId;
	private String passwd;
	private String name;
	private String nickName;
	private char sex;
	private String birthday;
	private int phonNumber;
	private String email;
	private int rating;
	
}
