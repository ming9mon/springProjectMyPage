package com.ming9.myPage.kakao.Controller;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ming9.myPage.kakao.Service.KakaoMapService;

@RestController
public class KakaoMapController {

	@Autowired
	KakaoMapService service;
	
	@GetMapping(value="/kakao/getCCTVData.do")
	public JSONObject getCCtvData(HttpServletRequest request) {

		String minX=request.getParameter("minX");
		String maxX=request.getParameter("maxX");
		String minY=request.getParameter("minY");
		String maxY=request.getParameter("maxY");
		
		return service.getCCTVData(minX, maxX, minY, maxY);
		
	}
	
}
