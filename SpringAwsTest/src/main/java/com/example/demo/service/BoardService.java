package com.example.demo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.BoardMapper;

@Service
public class BoardService {
	
	@Autowired
    BoardMapper boardMapper;
    
    public void insertBoard(HashMap map) throws Exception{
        boardMapper.insertBoard(map);
    }
    
    public List<HashMap> selectAll() throws Exception{
    	return boardMapper.selectAll();
    }
    
    public HashMap selectBoard(HashMap map) throws Exception{
    	return boardMapper.selectBoard(map);
    }
    
    public void deleteBoard(HashMap map) throws Exception{
    	boardMapper.deleteBoard(map);
    }
}
