package com.ming9.myPage.kakao.Service;

import org.json.simple.JSONObject;

public interface KakaoMapService {
	public JSONObject getCCTVData(String minX,String maxX,String minY,String maxY);
}
