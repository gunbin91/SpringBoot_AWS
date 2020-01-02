package com.example.demo.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVo {
	private int reply_no;
	private int board_no;
	private String reply_writer;
	private String reply_content;
	private Date reply_date;
}
