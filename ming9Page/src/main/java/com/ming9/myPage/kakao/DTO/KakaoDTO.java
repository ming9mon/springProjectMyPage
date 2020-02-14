package com.ming9.myPage.kakao.DTO;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class KakaoDTO {
	private String title;
	private String loc;
	private MultipartFile[] upImg;
}
