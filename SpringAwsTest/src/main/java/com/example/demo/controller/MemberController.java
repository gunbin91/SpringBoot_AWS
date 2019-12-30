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

import com.example.demo.service.MemberService;
import com.example.demo.vo.MemberVo;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;

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
		List<MemberVo> list = memberService.checkMember((HashMap) paramMap);
		if (list.size() < 1) {
			System.out.println("로그인실패");
			mav.addObject("login", "F");
		} else {
			System.out.println("로그인성공");
			System.out.println(request.getParameter("id"));
			HttpSession session = request.getSession();
			session.setAttribute("login_id", list.get(0).getId());
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
}
