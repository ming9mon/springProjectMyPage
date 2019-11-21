package com.ming9.myPage.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ming9.myPage.dao.MemberDAO;
import com.ming9.myPage.domain.MemberDTO;
import com.ming9.myPage.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO dao;
	
	//로그인 기능
	public boolean login(MemberDTO dto,HttpSession session) {
		
		boolean result=dao.login(dto);
		
		if(result) {
			//true일경우 세션 변수 등록
			session.setAttribute("userId",dto.getUserId());
		}
		
		return result;
	}

	//로그아웃 기능
	public void logout(HttpSession session) {
		System.out.println(session.getAttribute("userId")+" 로그아웃");
		session.invalidate();
	}

	@Override
	public int idCheck(String userId) {
		return dao.idCheck(userId);
	}

	@Override
	public int signUp(MemberDTO dto) {

		try {
			MultipartFile uploadFile = dto.getImg(); 
			if (!uploadFile.isEmpty()) {
				String originalFileName = uploadFile.getOriginalFilename();
				String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
				UUID uuid = UUID.randomUUID();	//UUID 구하기
				String fileName=uuid+"."+ext;
					uploadFile.transferTo(new File("D:\\upload\\" + fileName));
				
	
				dto.setImgName(fileName);
			}
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		dao.signUp(dto);
		return dao.signUp2(dto);
	}

}
