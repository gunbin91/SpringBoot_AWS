package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

//	글쓰기
	@RequestMapping(value = { "write" }, method = RequestMethod.POST)
	public ModelAndView write(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		System.out.println("path= /write / param=" + paramMap);
		ModelAndView mav = new ModelAndView("main");
		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("login_id"));
		if (session.getAttribute("login_id") == null) {
			System.out.println("글쓰기실패 : 미 로그인");
			mav.addObject("write", "F");
		} else {
			paramMap.put("id", session.getAttribute("login_id"));
			boardService.insertBoard((HashMap) paramMap);
			mav.setViewName("redirect:/");
		}

		return mav;
	}

//	게시글 상세
	@RequestMapping(value = { "board" })
	public ModelAndView board(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		System.out.println("path= /board / param=" + paramMap);
		ModelAndView mav = new ModelAndView("board");
		mav.addObject("board", boardService.selectBoard((HashMap) paramMap));

		return mav;
	}

//	게시글 삭제
	@RequestMapping(value = { "delete_board" })
	public ModelAndView delete_board(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		System.out.println("path= /delete_board / param=" + paramMap);
		ModelAndView mav = new ModelAndView("redirect:/");
		boardService.deleteBoard((HashMap) paramMap);
		return mav;
	}
}
