package com.ming9.myPage.weather;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class getLocation {

	//시 좌표 get
	@GetMapping(value="getCity",produces = "application/text; charset=utf8")
	public String getCity() throws IOException {
	
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/top.json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		result = URLDecoder.decode(result, "UTF-8");
		
		return result;
	}
	
	//구 좌표 get
	@GetMapping(value="getGu",produces = "application/text; charset=utf8")
	public String getGu(HttpServletRequest request)  throws IOException  {
		
		String cityCode = request.getParameter("cityCode");
		
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/mdl."+cityCode+".json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		
		return result;
	}
	
	//동 좌표 get
	@GetMapping(value="getDong",produces = "application/text; charset=utf8")
	public String getDong(HttpServletRequest request) throws IOException {
		/*
		String guCode = request.getParameter("guCode");
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/leaf."+guCode+".json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();*/
		String guCode = request.getParameter("guCode");
		return getLeaf(guCode);
	}
	
	
	
	//날씨 정보 얻기
	@GetMapping(value="getWeather")
	public String getWeather(HttpServletRequest request) throws IOException, ParseException {
		
		HashMap<String, String> xy = new HashMap<>();
		String guCode=request.getParameter("guCode");	//구 코드 받아오기
		String dongCode=request.getParameter("dongCode");	//동 코드 받아오기

		//동 리스트 Json형식으로 받아오기
		String dongList = getLeaf(guCode);
		//X, Y 좌표 받아오기
		xy.putAll(getXY(dongList,dongCode));
		//날씨 정보 얻기
		String result=getWeaderInfo(xy);
		
		
		
		
		return result;
	}
	
	private String getWeaderInfo(HashMap<String, String> hm) throws IOException, ParseException {
		
		//년월일로 날짜 포맷 후 -1
		SimpleDateFormat f = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String day = f.format(date);
		int intDay = Integer.parseInt(day)-1;
		day = Integer.toString(intDay);
		
		
		
		///날씨 정보를 얻기 위해 필요한 값 세팅
		String apiUrl = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData";
		// 홈페이지에서 받은 키
		String serviceKey = "HeczJdNPgPuFSyaZHxwLvi8aTJpiw8N0MuZYw2WP0MzAtnquzAcgjzuwy8PUZGd1Mc01lmWEycSzA6WElvzX9A%3D%3D";
		String nx = hm.get("x");	//x좌표
		String ny = hm.get("y");	//y좌표
		String baseDate = day;	//조회하고싶은 날짜 오늘 날짜-1
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
		
		return parse_item.toString();
	}
	
	private String getLeaf(String guCode) throws IOException {
		
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/leaf."+guCode+".json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		return result;
	}
	
	public HashMap<String, String> getXY(String dongList,String dongCode) throws ParseException{
		
		HashMap<String, String> result = new HashMap<>();
		
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
				System.out.println(x+" "+y);
				result.put("x", x);
				result.put("y", y);
				break;
			}
		}
		
		return result;
	}
	
	
}
