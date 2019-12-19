package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

public interface BoardMapper {
//	글작성
	public void insertBoard(HashMap map) throws Exception;
//	게시글 목록
	public List<HashMap> selectAll() throws Exception;
//	게시글 상세
	public HashMap selectBoard(HashMap map) throws Exception;
//	게시글 삭제
	public void deleteBoard(HashMap map) throws Exception;
}
