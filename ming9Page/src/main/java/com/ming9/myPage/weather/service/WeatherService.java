package com.ming9.myPage.weather.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

import com.ming9.myPage.weather.domain.WeatherDTO;

public interface WeatherService {
	
	//시 좌표 얻기
	public String getCity() throws IOException;
	
	//구 좌표 얻기
	public String getGu(String cityCode)  throws IOException;
	
	//동 좌표 얻기
	public String getDong(String guCode) throws IOException;
	
	//초단기 예보
	public JSONArray getSTurmWeather(String x, String y) throws IOException, ParseException;

	//초단기 실황
	public JSONArray getSTurmLiveWeather(String x, String y) throws IOException, ParseException;

	//동네 예보
	public JSONArray getTownWeather(String x, String ys) throws IOException, ParseException;
	
	
	
	
}
