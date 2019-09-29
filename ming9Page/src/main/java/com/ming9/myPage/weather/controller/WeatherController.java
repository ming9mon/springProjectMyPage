package com.ming9.myPage.weather.controller;

import java.io.IOException;
import java.util.List;

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
	
	//동네예보 시 좌표 get
	@GetMapping(value="getCity.do",produces = "application/text; charset=utf8")
	public String getCity() throws IOException {
		
		return service.getCity();
	}
	
	//동네예보 구 좌표 get
	@GetMapping(value="getGu.do",produces = "application/text; charset=utf8")
	public String getGu(HttpServletRequest request)  throws IOException  {
		
		String cityCode = request.getParameter("cityCode");
		
		return service.getGu(cityCode);
	}
	
	//동네예보 동 좌표 get
	@GetMapping(value="getDong.do",produces = "application/text; charset=utf8")
	public String getDong(HttpServletRequest request) throws IOException {
		
		String guCode = request.getParameter("guCode");
		
		return service.getDong(guCode);
	}
	
	//중기 지역
	@GetMapping(value="getMidArea.do",produces = "application/json; charset=utf8")
	public List<String> getMidArea(HttpServletRequest request) throws IOException {
		return service.getMidArea();
	}
	
	//중기 도시
	@GetMapping(value="getMidCity.do",produces = "application/json; charset=utf8")
	public List<String> getMidCity(HttpServletRequest request) throws IOException {
		
		String area = request.getParameter("area");
		
		return service.getMidCity(area);
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
	
	//중기 예보
	@GetMapping(value="/weather/getMidTermForecast.do",produces = "application/json; charset=utf8")
	public String getMidTermForecast(HttpServletRequest request) throws IOException, ParseException {
		
		String area = request.getParameter("area");
		return service.getMidTermForecast(area);
	}
	
	//중기 기온
	@GetMapping(value="/weather/getMidTermTPT.do",produces = "application/json; charset=utf8")
	public String getMidTermTPT(HttpServletRequest request) throws IOException, ParseException {
		
		String city = request.getParameter("city");
		
		return service.getMidTermTPT(city);
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
	
	
	
	/*//중기예보(강수확률&날씨)
	@GetMapping(value="/weather/getWeather.do")
	public String getMidTermForecast(HttpServletRequest request) throws IOException, ParseException {
		
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
	
	//중기기온 (최저/최고)
	@GetMapping(value="/weather/getWeather.do")
	public String getMidTermTPT(HttpServletRequest request) throws IOException, ParseException {
		
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
		
	}*/
	
}
