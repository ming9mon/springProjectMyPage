package com.ming9.myPage.game.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GameDTO {

	int rank;
	int usrIdx;
	String nickName;
	String gameType;
	int score;
	Date dte;
}
