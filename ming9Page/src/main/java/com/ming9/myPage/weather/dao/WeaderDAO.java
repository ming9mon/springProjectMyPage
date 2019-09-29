package com.ming9.myPage.weather.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class WeaderDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	//중기 지역 정보
	public List<String> getMidArea(){
		return sql.selectList("weatherMapper.getMidArea");
	}
	
	//중기 도시 정보
	public List<String> getMidCity(String area){
		return sql.selectList("weatherMapper.getMidCity",area);
	}
	
	//중기 예보 코드
	public String getMidForecastCode(String area) {
		return sql.selectOne("weatherMapper.getMidForecastCode",area);
	}
	
	//중기 기온 코드
	public String getMidTPTCode(String city) {
		return sql.selectOne("weatherMapper.getMidTPTCode",city);
	}
}
