package com.ming9.myPage.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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
			//session.setAttribute("userId",dto.getUserId());
			dto = dao.getUserInfo(dto);
			session.setAttribute("userInfo",dto);
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

		int rst=1;
		
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
		rst *= dao.signUp(dto);
		rst *= dao.signUp2(dto);
				
		return rst;
	}

	//구글 로그인
	public String googleLogin(String param,HttpSession session) {
		MemberDTO dto = new MemberDTO();
		int rst = 1;
		
		BufferedReader in  = null;
		InputStream is = null;
		InputStreamReader isr = null;
		JSONParser jsonParser = new JSONParser();
		
		try {
			String idToken = param.split("=")[1];
			
			String url = "https://oauth2.googleapis.com/tokeninfo";
			url += "?id_token="+idToken;
			
			URL gUrl = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) gUrl.openConnection();

			is = conn.getInputStream();
			isr = new InputStreamReader(is, "UTF-8");
			in = new BufferedReader(isr);
			

			JSONObject jsonObj = (JSONObject)jsonParser.parse(in);

			String userId = jsonObj.get("sub").toString();
			String name = jsonObj.get("name").toString();
			String email = jsonObj.get("email").toString();
			String imgName = jsonObj.get("picture").toString();
			
			Date d = new Date();
			SimpleDateFormat f = new SimpleDateFormat("HHmmss");
			String date = f.format(d);
			
			dto.setUserId(userId);
			dto.setName(name);
			dto.setJoinInfo("g");
			dto.setEmail(email);
			dto.setImgName(imgName);
			dto.setNickName(userId.substring(0,2)+date);
			
			//회원인지 검사 회원이 아니면 회원가입
			if(dao.idCheck(dto.getUserId()) == 0) {
				rst *= dao.signUp(dto);
				rst *= dao.signUp2(dto);
			}
			
			dto = dao.getUserInfo(dto);
			session.setAttribute("userInfo",dto);
			
			if (rst==1)
				return "success";
		}catch(Exception e) {
			System.out.println(e);
		}
		
		return "fail";
	}

}
