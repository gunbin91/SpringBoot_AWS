package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

public interface MemberMapper {
//	회원가입
	public void insertMember(HashMap map) throws Exception;
//	아이디 체크
	public List<HashMap> checkMember(HashMap map) throws Exception;
	
}
