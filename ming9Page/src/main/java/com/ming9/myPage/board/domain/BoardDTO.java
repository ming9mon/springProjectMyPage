package com.ming9.myPage.board.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private int bIdx;
	private int usrIdx;
	private String nickName;
	private Date writeDte;
	private String title;
	private String content;
	private char secret;
}
