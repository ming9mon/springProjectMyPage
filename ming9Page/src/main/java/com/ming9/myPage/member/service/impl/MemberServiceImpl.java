package com.ming9.myPage.member.service.impl;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ming9.myPage.member.dao.MemberDAO;
import com.ming9.myPage.member.domain.MemberDTO;
import com.ming9.myPage.member.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO dao;
	
	//로그인 기능
	@Transactional
	public boolean login(MemberDTO dto,HttpSession session) {
		
		boolean result=dao.login(dto);
		
		if(result) {
			//true일경우 세션 변수 등록 및 로그인 정보 update 
			dto = dao.getUserInfo(dto);
			session.setAttribute("loginDto", dto);
			session.setAttribute("usrIdx", dto.getUsrIdx());
			
			int usrIdx = dto.getUsrIdx();
			dao.insertLoginInfo(usrIdx);
		}
		
		return result;
	}

	//로그아웃 기능
	public void logout(HttpSession session) {
		session.invalidate();
	}

	//아이디 체크
	public int idCheck(String userId) {
		return dao.idCheck(userId);
	}
	
	//닉네임 체크
	public int nickNmCheck(String nickNm) {
		return dao.nickNmCheck(nickNm);
	}

	/* 회원가입  */
	@Transactional
	public int signUp(MemberDTO dto) {

		int rst=1;
		
		try {
			MultipartFile uploadFile = dto.getImg(); 
			if (!uploadFile.isEmpty()) {
				String originalFileName = uploadFile.getOriginalFilename();
				String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
				UUID uuid = UUID.randomUUID();	//UUID 구하기
				String fileName=uuid+"."+ext;
				/* 로컬 */
				//uploadFile.transferTo(new File("D:\\upload\\" + fileName));
				/* 운영서버 */
				uploadFile.transferTo(new File("/usr/local/server/tomcat9/webapps/img/" + fileName));
	
				dto.setImgName(fileName);
			}
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		rst = dao.signUp(dto);
				
		return rst;
	}

	//구글 로그인
	@Transactional
	public String googleLogin(String param,HttpSession session) {
		MemberDTO dto = new MemberDTO();
		int rst;
		
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
			
			dto.setUserId(userId);
			
			//회원인지 검사 회원이 아니면 회원가입
			if(dao.idCheck(dto.getUserId()) == 0) {
				return "new";
			}else {
				dto = dao.getUserInfo(dto);
				session.setAttribute("loginDto", dto);
				session.setAttribute("usrIdx", dto.getUsrIdx());
				
				int usrIdx = dto.getUsrIdx();
				dao.insertLoginInfo(usrIdx);
			}
			
			return "success";
		}catch(Exception e) {
			System.out.println(e);
		}
		
		return "fail";
	}
	
	//구글 회원가입
	@Transactional
	public String googleSignUp(MemberDTO dto, HttpSession session) {
		int rst;
		
		BufferedReader in  = null;
		InputStream is = null;
		InputStreamReader isr = null;
		JSONParser jsonParser = new JSONParser();
		
		try {
			String idToken = dto.getId_token();
			
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
			
			//회원이라면 return;
			if(dao.idCheck(dto.getUserId()) != 0) {
				return "old";
			}
			
			rst = dao.signUp(dto);
			dto = dao.getUserInfo(dto);
			session.setAttribute("loginDto", dto);
			session.setAttribute("usrIdx", dto.getUsrIdx());
			
			int usrIdx = dto.getUsrIdx();
			dao.insertLoginInfo(usrIdx);
			
			return "success";
		}catch(Exception e) {
			System.out.println(e);
		}
		
		return "fail";
	}

}
