package com.ming9.myPage.weather.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ming9.myPage.weather.domain.WeatherDTO;

@Repository
public class WeaderDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	public boolean lookup(WeatherDTO dto) {

		//XY 좌표값이 DB에 있는지 조회 없으면 생성	
		boolean xyResult=sql.selectOne("weatherMapper.lookup",dto);
		
		//검색 결과가 없으면 삽입 후 seq 값 받아오기
		if(!xyResult) {
			sql.insert("weatherMapper.insertXY", dto);
		}

		//xy_seq값 세팅
		int seq = (Integer)sql.selectOne("weatherMapper.lookupSeq",dto);
		dto.setXySeq(seq);
		
		/*
		 * 최근에 조회한 데이터가 있는지 검사하여 있으면 false 없으면 true리턴
		 * 없으면 데이터 추가
		 */
		boolean dateResult = sql.selectOne("weatherMapper.lookupBaseDate",dto);
		if(dateResult) {
			return false;
		}
		sql.insert("weatherMapper.insertDate",dto);
		
		return true;
	}
	
	//date_seq값 얻기
	public int getDateSeq(WeatherDTO dto) {
		return sql.selectOne("weatherMapper.selectDateSeq",dto);
	}
	
	//날씨 정보 입력
	public int insertWeather(ArrayList<WeatherDTO> dataList){
		return sql.insert("weatherMapper.insertWeather",dataList);
	}
	
	//날씨 정보 얻기
	public List<WeatherDTO> getWeather(int dataSeq){
		return sql.selectList("weatherMapper.getWeather",dataSeq);
	}
}
