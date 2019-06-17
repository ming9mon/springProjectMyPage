package com.ming9.myPage.weather.service;

import java.io.IOException;
import java.util.List;

import org.json.simple.parser.ParseException;

import com.ming9.myPage.weather.domain.WeatherDTO;

public interface WeatherService {
	
	//시 좌표 얻기
	public String getCity() throws IOException;
	
	//구 좌표 얻기
	public String getGu(String cityCode)  throws IOException;
	
	//동 좌표 얻기
	public String getDong(String guCode) throws IOException;
	
	//날씨 정보 얻기
	public List<WeatherDTO> getWeather(String guCode,String dongCode) throws IOException, ParseException;
	
}
