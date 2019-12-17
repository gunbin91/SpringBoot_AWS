package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

public interface UserMapper {
	public void insertUser(HashMap user);

	public void updateUser(HashMap user);

	public void deleteUser(String userId);

	public HashMap selectOneUser(String userId);

	public List<HashMap> selectAllUser();
}
