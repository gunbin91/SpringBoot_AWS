package com.example.demo.db.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
 

public interface TestMapper {
 
    public List<HashMap> getAll() throws Exception;
    
}