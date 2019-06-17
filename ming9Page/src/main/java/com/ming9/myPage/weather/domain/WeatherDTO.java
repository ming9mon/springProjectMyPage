package com.ming9.myPage.weather.domain;

import lombok.Data;

@Data
public class WeatherDTO {
	String x;
	String y;
	int baseDate;
	int xySeq;
	int dateSeq;
	String fcstDate;
	String fcstTime;
	String temperature;
}
