package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ReplyVo;

public interface ReplyMapper {
//	댓글삽입
	public int insertReply(HashMap map) throws Exception;

//	댓글불러오기
	public List<ReplyVo> selectReply(HashMap map) throws Exception;

//	댓글삭제
	public int deleteReply(HashMap map) throws Exception;
}
