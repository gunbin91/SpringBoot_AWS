package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
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
import com.example.demo.service.MemberService;

import lombok.Setter;

@Controller
public class HomeController {

	@Autowired
	MemberService memberService;

	@Autowired
	BoardService boardService;

	@RequestMapping(value = { "/", "/index", "/home", "/main" })
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("board_list", boardService.selectAll());
		return mav;
	}

//	회원가입
	@RequestMapping(value = { "join" }, method = RequestMethod.POST)
	public ModelAndView join(@RequestParam Map paramMap) throws Exception {
		System.out.println("path= /join / param=" + paramMap);
		ModelAndView mav = new ModelAndView("main");
		memberService.insertMember((HashMap) paramMap);
		mav.addObject("join", "Y");
		return mav;
	}

//	로그인
	@RequestMapping(value = { "login" }, method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		System.out.println("path= /login / param=" + paramMap);
		ModelAndView mav = new ModelAndView("main");
		List<HashMap> list = memberService.checkMember((HashMap) paramMap);
		if (list.size() < 1) {
			System.out.println("로그인실패");
			mav.addObject("login", "F");
		} else {
			System.out.println("로그인성공");
			System.out.println(request.getParameter("id"));
			HttpSession session = request.getSession();
			session.setAttribute("login_id", list.get(0).get("ID"));
			mav.setViewName("redirect:/");
		}
		return mav;
	}

//	로그아웃
	@RequestMapping(value = { "logout" })
	public ModelAndView logout(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		System.out.println("path= /logout / param=" + paramMap);
		ModelAndView mav = new ModelAndView("redirect:/");
		HttpSession session = request.getSession();
		session.removeAttribute("login_id");
		return mav;
	}

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
		mav.addObject("board",boardService.selectBoard((HashMap) paramMap));

		return mav;
	}
	
//	게시글 삭제
	@RequestMapping(value = { "delete_board" })
	public ModelAndView delete_board(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		System.out.println("path= /delete_board / param=" + paramMap);
		ModelAndView mav = new ModelAndView("redirect:/");
		boardService.deleteBoard((HashMap)paramMap);
		return mav;
	}
	
}
