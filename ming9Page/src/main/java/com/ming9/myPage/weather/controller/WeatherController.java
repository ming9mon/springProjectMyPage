package com.ming9.myPage.weather.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ming9.myPage.weather.domain.WeatherDTO;
import com.ming9.myPage.weather.service.WeatherService;

@RestController
public class WeatherController {

	@Autowired 
	WeatherService service;
	
	//시 좌표 get
	@GetMapping(value="getCity",produces = "application/text; charset=utf8")
	public String getCity() throws IOException {
		
		return service.getCity();
	}
	
	//구 좌표 get
	@GetMapping(value="getGu",produces = "application/text; charset=utf8")
	public String getGu(HttpServletRequest request)  throws IOException  {
		
		String cityCode = request.getParameter("cityCode");
		
		return service.getGu(cityCode);
	}
	
	//동 좌표 get
	@GetMapping(value="getDong",produces = "application/text; charset=utf8")
	public String getDong(HttpServletRequest request) throws IOException {
		
		String guCode = request.getParameter("guCode");
		
		return service.getDong(guCode);
	}
	
	
	
	//날씨 정보 얻기
	@GetMapping(value="getWeather")
	public List<WeatherDTO> getWeather(HttpServletRequest request) throws IOException, ParseException {
		
		String guCode=request.getParameter("guCode");	//구 코드 받아오기
		String dongCode=request.getParameter("dongCode");	//동 코드 받아오기
		
		return service.getWeather(guCode, dongCode);
	}
	
}
