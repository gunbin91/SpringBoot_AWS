package com.example.demo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.MemberMapper;
import com.example.demo.vo.MemberVo;

@Service
public class MemberService {
	
	@Autowired
    MemberMapper memberMapper;
    
    public void insertMember(HashMap map) throws Exception{
        memberMapper.insertMember(map);
    }
    
    public List<MemberVo> checkMember(HashMap map) throws Exception{
        return memberMapper.checkMember(map);
    }
}
