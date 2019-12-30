package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.demo.vo.BoardVo;

public interface BoardMapper {
//	글작성
	public void insertBoard(HashMap map) throws Exception;

//	게시글 목록
	public List<BoardVo> selectAll() throws Exception;

//	게시글 상세
	public BoardVo selectBoard(HashMap map) throws Exception;

//	게시글 삭제
	public void deleteBoard(HashMap map) throws Exception;
}
