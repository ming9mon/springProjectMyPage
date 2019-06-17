package com.ming9.myPage.weather.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ming9.myPage.weather.dao.WeaderDAO;
import com.ming9.myPage.weather.domain.WeatherDTO;
import com.ming9.myPage.weather.service.WeatherService;

@Service
public class WeatherServiceImpl implements WeatherService {

	@Autowired
	WeaderDAO dao;
	
	//시 좌표
	public String getCity() throws IOException {
		
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/top.json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		result = URLDecoder.decode(result, "UTF-8");
		
		return result;
	}

	//구 좌표
	public String getGu(String cityCode) throws IOException {
		
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/mdl."+cityCode+".json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		
		return result;
	}

	//동 좌표
	public String getDong(String guCode) throws IOException {
		return getLeaf(guCode);
	}

	//날씨 정보 얻기
	public List<WeatherDTO> getWeather(String guCode, String dongCode) throws IOException, ParseException {

		WeatherDTO dto = new WeatherDTO();

		//동 리스트 Json형식으로 받아오기
		String dongList = getLeaf(guCode);
		//X, Y 좌표 받아오기
		setXY(dongList,dongCode,dto);
		setBaseDate(dto);
		//
		/*  x,y좌표가 등록되어 있는지 조회 없으면 추가
		 *  있으면 최근 조회일 확인해서 최근에 조회했으면 0 안했으면 1 리턴
		 */
		boolean result = dao.lookup(dto);
		
		//dateSeq값 세팅
		dto.setDateSeq(dao.getDateSeq(dto));
		
		//true일 경우 날씨 조회해서 디비에 넣기
		if(result) {
			ArrayList<WeatherDTO> list = getWeaderInfo(dto);
			dao.insertWeather(list);
		}
		
		return dao.getWeather(dto.getDateSeq());
	}
	
	private void setBaseDate(WeatherDTO dto) {
		//년월일로 날짜 포맷 후 -1
		SimpleDateFormat f = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String day = f.format(date);
		int intDay = Integer.parseInt(day)-1;
		day = Integer.toString(intDay);
		dto.setBaseDate(Integer.parseInt(day));
	}
	
	private ArrayList<WeatherDTO> getWeaderInfo(WeatherDTO dto) throws IOException, ParseException {
		
		ArrayList<WeatherDTO> list = new ArrayList<WeatherDTO>();
	
		///날씨 정보를 얻기 위해 필요한 값 세팅
		String apiUrl = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData";
		// 홈페이지에서 받은 키
		String serviceKey = "HeczJdNPgPuFSyaZHxwLvi8aTJpiw8N0MuZYw2WP0MzAtnquzAcgjzuwy8PUZGd1Mc01lmWEycSzA6WElvzX9A%3D%3D";
		String nx = dto.getX();	//x좌표
		String ny = dto.getY();	//y좌표
		String baseDate = Integer.toString(dto.getBaseDate());	//조회하고싶은 날짜 오늘 날짜-1
		String baseTime = "2300";	//API 제공 시간을 입력하면 됨
		String type = "json";	//타입 xml, json 등등 ..
		String numOfRows = "153";	//한 페이지 결과 수 
		
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey);
		urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); //경도
		urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")); //위도
		urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /* 조회하고싶은 날짜*/
		urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(baseTime, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode(type, "UTF-8"));	/* 타입 */
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));	/* 한 페이지 결과 수 */
		
		/*
		 * GET방식으로 전송해서 파라미터 받아오기
		 */
		URL url = new URL(urlBuilder.toString());
		//어떻게 넘어가는지 확인하고 싶으면 아래 출력분 주석 해제
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		String urlResult= sb.toString();
		
		// Json parser를 만들어 만들어진 문자열 데이터를 객체화 
		JSONParser parser = new JSONParser(); 
		JSONObject obj = (JSONObject) parser.parse(urlResult); 
		// response 키를 가지고 데이터를 파싱 
		JSONObject parse_response = (JSONObject) obj.get("response"); 
		// response 로 부터 body 찾기
		JSONObject parse_body = (JSONObject) parse_response.get("body"); 
		// body 로 부터 items 찾기 
		JSONObject parse_items = (JSONObject) parse_body.get("items");

		// items로 부터 itemlist 를 받기 
		JSONArray parse_item = (JSONArray) parse_items.get("item");
		
		JSONObject weather;
		
		//dto 값 세팅
		for(int i=0;i<parse_item.size();i++) {
			weather=(JSONObject) parse_item.get(i);
			String category = weather.get("category").toString();
			if(category.equals("T3H")) {
				
				WeatherDTO wdto = new WeatherDTO();
				
				String fcstDate = weather.get("fcstDate").toString();
				String fcstTime = weather.get("fcstTime").toString().substring(0,2);				
				String fcstValue = weather.get("fcstValue").toString();
				
				wdto.setBaseDate(dto.getBaseDate());
				wdto.setDateSeq(dto.getDateSeq());
				wdto.setFcstDate(fcstDate);
				wdto.setFcstTime(fcstTime);
				wdto.setTemperature(fcstValue);
				
				list.add(wdto);
			}
		}
		
		return list;
	}
	
	private String getLeaf(String guCode) throws IOException {
		
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/leaf."+guCode+".json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		return result;
	}
	
	
	public void setXY(String dongList,String dongCode, WeatherDTO dto) throws ParseException{
		
		// Json parser를 만들어 만들어진 문자열 데이터를 객체화 
		JSONParser parser = new JSONParser(); 
		JSONArray dataArr = (JSONArray) parser.parse(dongList); 
		String x,y;
		
		//x, y값 찾기
		for(int i = 0 ; i < dataArr.size(); i++) {
			JSONObject item = (JSONObject)dataArr.get(i);
			String code = item.get("code").toString();
			if(code.equals(dongCode)) {
				x=item.get("x").toString();
				y=item.get("y").toString();
				
				dto.setX(x);
				dto.setY(y);
				break;
			}
		}
		
		
	}

	
}
