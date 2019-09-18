package com.ming9.myPage.weather.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ming9.myPage.weather.service.WeatherService;

@RestController
public class WeatherController {

	@Autowired 
	WeatherService service;
	
	//시 좌표 get
	@GetMapping(value="getCity.do",produces = "application/text; charset=utf8")
	public String getCity() throws IOException {
		
		return service.getCity();
	}
	
	//구 좌표 get
	@GetMapping(value="getGu.do",produces = "application/text; charset=utf8")
	public String getGu(HttpServletRequest request)  throws IOException  {
		
		String cityCode = request.getParameter("cityCode");
		
		return service.getGu(cityCode);
	}
	
	//동 좌표 get
	@GetMapping(value="getDong.do",produces = "application/text; charset=utf8")
	public String getDong(HttpServletRequest request) throws IOException {
		
		String guCode = request.getParameter("guCode");
		
		return service.getDong(guCode);
	}
	
	//날씨 정보
	@GetMapping(value="/weather/getWeather.do")
	public String getWeathers(HttpServletRequest request) throws IOException, ParseException {
		
		String param = request.getParameter("param");
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		
		
		
		if(param.equals("str"))	//초단기 예보
			return getSTurmWeather(x, y).toJSONString();
		else if(param.equals("stlw"))	//초단기 실황
			return getSTurmLiveWeather(x, y).toJSONString();
		else if(param.equals("tw"))	//동네 예보
			return getTownWeather(x, y).toJSONString();
		else
			return null;
		
	}
	
	//초단기 예보
	private JSONArray getSTurmWeather(String x, String y) throws IOException, ParseException{
		JSONArray str = service.getSTurmWeather(x, y);
		return str;
	}
	
	//초단기 실황
	private JSONArray getSTurmLiveWeather(String x, String y) throws IOException, ParseException{
		JSONArray stlw = service.getSTurmLiveWeather(x, y);
		return stlw;
	}
	
	//동네에보
	private JSONArray getTownWeather(String x, String y) throws IOException, ParseException {
		JSONArray tw = service.getTownWeather(x, y);
		return tw;
	}
	
}
