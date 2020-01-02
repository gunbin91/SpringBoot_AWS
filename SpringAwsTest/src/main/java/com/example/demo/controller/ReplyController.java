package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReplyService;
import com.google.gson.Gson;

@Controller
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	ReplyService replyService;

//	댓글등록
	@ResponseBody
	@RequestMapping(value = { "/insert" }, method = RequestMethod.POST)
	public int reply_insert(@RequestParam Map paramMap) throws Exception {
		System.out.println("path= /reply/insert / param=" + paramMap);
		return replyService.insertReply((HashMap) paramMap);
	}

//	댓글리스트
	@ResponseBody
	@RequestMapping(value = { "/list" }, method = RequestMethod.POST)
	public String reply_list(@RequestParam Map paramMap, HttpServletResponse response) throws Exception {
		System.out.println("path= /reply/list / param=" + paramMap);
		Gson gson = new Gson();
		response.setContentType("application/json");
		return gson.toJson(replyService.selectReply((HashMap) paramMap));
	}

//	댓글삭제
	@ResponseBody
	@RequestMapping(value = { "/delete" }, method = RequestMethod.POST)
	public int reply_delete(@RequestParam Map paramMap) throws Exception {
		System.out.println("path= /reply/delete / param=" + paramMap);
		return replyService.deleteReply((HashMap) paramMap);
	}

}
