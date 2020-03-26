package com.ming9.myPage.weather.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

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

	@Autowired
	Properties properties;
	
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
		
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/leaf."+guCode+".json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		
		return result;
	}

	//중기 지역
	public List<String> getMidArea() {
		return dao.getMidArea();
	}

	//중기 도시
	public List<String> getMidCity(String area) {
		return dao.getMidCity(area);
	}

	//초단기 예보
	@Override
	public JSONArray getSTurmWeather(String x, String y) throws IOException, ParseException {
		
		JSONObject jResult = new JSONObject();
		JSONArray jDataArr = new JSONArray();
			
			
		String date = getBaseTime(0);
		String apiUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst";
		// 홈페이지에서 받은 키
		String serviceKey = properties.getProperty("weatherKey");
		String nx = x;	//위도
		String ny = y;	//경도
		String baseDate = date.substring(0,8);	//조회하고싶은 날짜
		String baseTime = date.substring(8);	//API 제공 시간
		String dataType = "json";	//타입 xml, json 등등 ..
		String numOfRows = "250";	//한 페이지 결과 수 

		//동네예보 -- 전날 05시 부터 225개의 데이터를 조회하면 모레까지의 날씨를 알 수 있음
		
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey);
		urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); //경도
		urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")); //위도
		urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /* 조회하고싶은 날짜*/
		urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(baseTime, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
		urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(dataType, "UTF-8"));	/* 타입 */
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));	/* 한 페이지 결과 수 */
		
		/*
		 * GET방식으로 전송해서 파라미터 받아오기
		 */
		URL url = new URL(urlBuilder.toString());
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
		String data= sb.toString();
		
		// Json parser를 만들어 만들어진 문자열 데이터를 객체화 
		JSONParser parser = new JSONParser(); 
		JSONObject obj = (JSONObject) parser.parse(data); 
		// response 키를 가지고 데이터를 파싱 
		JSONObject parse_response = (JSONObject) obj.get("response"); 
		// response 로 부터 body 찾기
		JSONObject parse_body = (JSONObject) parse_response.get("body"); 
		// body 로 부터 items 찾기 
		JSONObject parse_items = (JSONObject) parse_body.get("items");
		JSONArray parse_item = (JSONArray) parse_items.get("item");

		JSONObject jdata = new JSONObject();
		JSONObject weather = new JSONObject();
		Object category;
		Object value;
		Object jDate = new Object();
		Object jTime = new Object();
		
		/**
		 * j+dataSize*1 : PTY
		 * j+dataSize*2 : SKY
		 * j+dataSize*4 : T1H	--TPT로 저장
		 * j+dataSize*5 : REH
		 * 
		 * 카테고리당 parse_item.size()/10만큼의 데이터를 줌
		 */
		int dataSize = parse_item.size()/10;
		
		//시간당 카테고리 1개씩
		for(int j = 0 ; j < dataSize; j++) {
			jdata = new JSONObject();
			//jDataArr = new JSONArray();
			//PTY, SKY, T1H, REH 총 4개의 데이터를 가져오기
			for(int k=1;k<=4;k++) {
				if (k==2) k++;
				weather = (JSONObject) parse_item.get(dataSize*k+j);
				category = weather.get("category");
				value = weather.get("fcstValue");
				jTime = weather.get("fcstTime");
				jDate = weather.get("fcstDate");
				
				if(category.equals("T1H")){
					jdata.put("TPT", value);

				}
				else
					jdata.put(category, value);
				
			}
			jdata.put("time", jTime);
			jdata.put("date", jDate);
			
			jDataArr.add(jdata);
			
		}
				
			//jResult.put(key, jDataArr);
		
		return jDataArr;
	}

	//초단기 실황
	@Override
	public JSONArray getSTurmLiveWeather(String x, String y) throws IOException, ParseException {
		
		return null;
	}

	//동네 예보
	@Override
	public JSONArray getTownWeather(String x, String y) throws IOException, ParseException {
		JSONArray jDataArr = new JSONArray();
		
		String apiUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst";

		String date = getBaseTime(1);
		// 홈페이지에서 받은 키
		String serviceKey = properties.getProperty("weatherKey");
		String nx = x;	//위도
		String ny = y;	//경도
		String baseDate = date.substring(0,8);	//조회하고싶은 날짜
		String baseTime = date.substring(8);	//API 제공 시간
		String dataType = "json";	//타입 xml, json 등등 ..
		String numOfRows = "250";	//한 페이지 결과 수 

		//동네예보 -- 전날 05시 부터 225개의 데이터를 조회하면 모레까지의 날씨를 알 수 있음
		
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey);
		urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); //경도
		urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")); //위도
		urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /* 조회하고싶은 날짜*/
		urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(baseTime, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
		urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(dataType, "UTF-8"));	/* 타입 */
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));	/* 한 페이지 결과 수 */
		
		/*
		 * GET방식으로 전송해서 파라미터 받아오기
		 */
		URL url = new URL(urlBuilder.toString());
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
		String data= sb.toString();
		
		// Json parser를 만들어 만들어진 문자열 데이터를 객체화 
		JSONParser parser = new JSONParser(); 
		JSONObject obj = (JSONObject) parser.parse(data); 
		// response 키를 가지고 데이터를 파싱 
		JSONObject parse_response = (JSONObject) obj.get("response"); 
		// response 로 부터 body 찾기
		JSONObject parse_body = (JSONObject) parse_response.get("body"); 
		// body 로 부터 items 찾기 
		JSONObject parse_items = (JSONObject) parse_body.get("items");
		JSONArray parse_item = (JSONArray) parse_items.get("item");
		
		JSONObject jdata = new JSONObject();
		JSONObject weather = new JSONObject();
		Object category;
		Object value;
		Object jDate = new Object();
		Object jTime = new Object();
		Object minMax = new Object();
		
		Date tmpDate = new Date();
		int min=50;
		int max=0;

		//JSON데이터 삽입
		for(int j=0; j < parse_item.size(); j++) {
			weather = (JSONObject) parse_item.get(j);
			category = weather.get("category");

			jDate = weather.get("fcstDate");
			jTime = weather.get("fcstTime");
			
			if(category.equals("PTY")){
				value = weather.get("fcstValue");
				jdata.put(category, value);
			}else if(category.equals("SKY")){
				value = weather.get("fcstValue");
				jdata.put(category, value);
			}else if(category.equals("T3H")){
				value = weather.get("fcstValue");
				jdata.put("TPT", value);
				jdata.put("time", jTime);
				jdata.put("date", jDate);
				jDataArr.add(jdata);
				jdata = new JSONObject();
			}
		}
		return jDataArr;
	}
	
	/**
	 * @throws ParseException 
	 * @throws IOException 
	 * 
	 * 중기예보조회
	 * 강수확률과 하늘 상태를 리턴
	 */
	public String getMidTermForecast(String area) throws ParseException, IOException{
		
		String code = dao.getMidForecastCode(area);

		String date = getBaseTime(2);
		String apiUrl = "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst";
		String serviceKey = properties.getProperty("weatherKey");
		String regId = code;	//예보 구역 코드
		String tmFc = date;	//발표시간 입력
		String numOfRows = "1";	//한 페이지 결과 수
		String dataType = "json";	//타입 xml, json 등등 ..
		HashMap<String, String> sky = new HashMap<String, String>();
		HashMap<String, String> pop = new HashMap<String, String>();
		
		try{
		
			StringBuilder urlBuilder = new StringBuilder(apiUrl);
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey);
			urlBuilder.append("&" + URLEncoder.encode("regId","UTF-8") + "=" + URLEncoder.encode(regId, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("tmFc","UTF-8") + "=" + URLEncoder.encode(tmFc, "UTF-8")); /* 조회하고싶은 날짜*/
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
			urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(dataType, "UTF-8"));	/* 타입 */
			
			/*
			 * GET방식으로 전송해서 파라미터 받아오기
			 */
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "text/plain");
			
			BufferedReader rd;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"utf-8"));
			}
			
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
	
				byte[] bb = line.toString().getBytes();
			}
			rd.close();
			conn.disconnect();
			byte[] b = sb.toString().getBytes();
			String result= new String(b);
			
		 	// Json parser를 만들어 만들어진 문자열 데이터를 객체화 
	 		JSONParser parser = new JSONParser(); 
	 		JSONObject obj = (JSONObject) parser.parse(result); 
	 		// response 키를 가지고 데이터를 파싱 
	 		JSONObject parse_response = (JSONObject) obj.get("response"); 
	 		// response 로 부터 body 찾기
	 		JSONObject parse_body = (JSONObject) parse_response.get("body"); 
	 		// body 로 부터 items 찾기 
	 		JSONObject parse_items = (JSONObject) parse_body.get("items");
	 		JSONArray parse_item = (JSONArray) parse_items.get("item");
	 		
	 		return parse_item.get(0).toString();
		}catch(Exception e){
			return null;
		}
 		
	}
	
	/**
	 * 중기 기온조회
	 * @throws ParseException 
	 * @throws IOException 
	 */
	public String getMidTermTPT(String city) throws ParseException, IOException{

		
		String code = dao.getMidTPTCode(city);
		
		JSONObject jrst = new JSONObject();
		String date = getBaseTime(2);
		
		try{
			JSONObject data = new JSONObject();
			
			String apiUrl = "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa";
			// 홈페이지에서 받은 키
			String serviceKey = properties.getProperty("weatherKey");
			String regId = code;	//예보 구역 코드
			String tmFc = date;	//발표시간 입력
			String numOfRows = "1";	//한 페이지 결과 수
			String dataType = "json";	//타입 xml, json 등등 ..
			HashMap<String, String> sky = new HashMap<String, String>();
			HashMap<String, String> pop = new HashMap<String, String>();
			
			StringBuilder urlBuilder = new StringBuilder(apiUrl);
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey);
			urlBuilder.append("&" + URLEncoder.encode("regId","UTF-8") + "=" + URLEncoder.encode(regId, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("tmFc","UTF-8") + "=" + URLEncoder.encode(tmFc, "UTF-8")); /* 조회하고싶은 날짜*/
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
			urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(dataType, "UTF-8"));	/* 타입 */
			
			/*
			 * GET방식으로 전송해서 파라미터 받아오기
			 */
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "text/plain");
			
			BufferedReader rd;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"utf-8"));
			}
			
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
	
				byte[] bb = line.toString().getBytes();
			}
			rd.close();
			conn.disconnect();
			byte[] b = sb.toString().getBytes();
			String result= new String(b);
			
		 	// Json parser를 만들어 만들어진 문자열 데이터를 객체화 
	 		JSONParser parser = new JSONParser(); 
	 		JSONObject obj = (JSONObject) parser.parse(result); 
	 		// response 키를 가지고 데이터를 파싱 
	 		JSONObject parse_response = (JSONObject) obj.get("response"); 
	 		// response 로 부터 body 찾기
	 		JSONObject parse_body = (JSONObject) parse_response.get("body"); 
	 		// body 로 부터 items 찾기 
	 		JSONObject parse_items = (JSONObject) parse_body.get("items");
	 		// items로 부터 itemlist 를 받기 
	 		JSONArray parse_item = (JSONArray) parse_items.get("item");
	 		JSONObject item = (JSONObject) parse_item.get(0);

			for(int j=3;j<=10;j++) {
				data.put("max"+j, item.get("taMax"+j));
				data.put("min"+j, item.get("taMin"+j));
			}
			
			jrst.put("rst",data);
		}catch(Exception e){
			System.out.println("getMidTermTPT error");
		}
		
		return jrst.toString();
	}
	
	private String getBaseTime(int idx){
		
		Date date = new Date();
		
		SimpleDateFormat rstFormat = new SimpleDateFormat("yyyyMMddHHmm");
		SimpleDateFormat hmFormat = new SimpleDateFormat("HHmm");
		
		int hm = Integer.parseInt(hmFormat.format(date));
		
		int[] apiTime = new int[] {210,510,810,1110,1410,1710,2010,2310};
		/**
		 * baseTime 맞추기
		 * 
		 * 초단기에보--
		 * API제공 시간은 H시+45분
		 * 30분 단위 제공
		 * baseTime : H시
		 * 
		 * 동네예보 --
		 * baseTime = 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300
		 * API 제공시간 = baseTime+10
		 * API 제공시간인 0210분 이전시간이면 전날 23시로 세팅
		 * 
		 * 중기기온 & 중기육상예보
		 * 제공 시간 06시 18시 하루 2번 제공
		 * baseDate : 년월일시분
		 * 
		 */
		if(idx == 0){
			if(hm%100 < 45){
				date.setHours(date.getHours()-1);
			}
		}else if(idx == 1){
			for(int i=0;i<apiTime.length;i++) {
				if(hm < apiTime[i]) {
					
					int apiHour = apiTime[i]/100;
					
					if(i==0) {
						date.setDate(date.getDate()-1);
						date.setHours(23);
					}
					else
						date.setHours(apiHour-3);
					
					break;
				}
			}
		}else if(idx == 2){
			if (hm < 600){	//6시 이전이면 전날 18시
				date.setDate(date.getDate()-1);
				date.setHours(18);
			}else if (hm < 1800) //18시 이전
				date.setHours(6);
			else
				date.setHours(18);
		}
		
		date.setMinutes(0);
		
		return rstFormat.format(date);
	}

	
}
