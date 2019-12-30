package com.example.demo.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVo {
	private int num;
	private String board_writer;
	private String board_title;
	private int board_no;
	private Date board_date;
	private String board_content;
}
