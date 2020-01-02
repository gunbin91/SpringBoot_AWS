package com.example.demo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.ReplyMapper;
import com.example.demo.vo.ReplyVo;

@Service
public class ReplyService {
	
	@Autowired
    ReplyMapper replyMapper;
    
    public int insertReply(HashMap map) throws Exception{
        return replyMapper.insertReply(map);
    }
    
    public List<ReplyVo> selectReply(HashMap map) throws Exception{
    	return replyMapper.selectReply(map);
    }
    
    public int deleteReply(HashMap map) throws Exception{
    	return replyMapper.deleteReply(map);
    }
}
