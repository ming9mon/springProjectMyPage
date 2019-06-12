package com.ming9.myPage.weather;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.text.ParseException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class getLocation {

	//시 좌표 get
	@GetMapping(value="getCity",produces = "application/text; charset=utf8")
	public String getCity() throws IOException, ParseException {
	
		URL url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/top.json.txt");
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String result = br.readLine().toString();
		br.close();
		result = URLDecoder.decode(result, "UTF-8");
		
		return result;
	}
}
