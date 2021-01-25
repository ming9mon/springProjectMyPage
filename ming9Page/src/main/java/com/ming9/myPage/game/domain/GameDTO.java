package com.ming9.myPage.game.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GameDTO {

	int rank;
	int usrIdx;
	String nickName;
	String gameType;
	int score;	//게임 점수 - 지뢰 찾기는 지뢰의 갯수
	int size;	// 지뢰 찾기의 맵 크기
	Date dte;
	int playTime;
}
