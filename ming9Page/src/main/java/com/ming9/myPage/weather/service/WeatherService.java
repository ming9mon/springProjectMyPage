package com.ming9.myPage.weather.service;

import java.io.IOException;

import org.json.simple.parser.ParseException;

public interface WeatherService {
	
	//시 좌표 얻기
	public String getCity() throws IOException;
	
	//구 좌표 얻기
	public String getGu(String cityCode)  throws IOException;
	
	//동 좌표 얻기
	public String getDong(String guCode) throws IOException;
	
	//날씨 정보 얻기
	public String getWeather(String guCode,String dongCode) throws IOException, ParseException;
	
}
