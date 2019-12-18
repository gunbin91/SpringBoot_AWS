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

@Controller
public class HomeController {

	@Autowired
	MemberService memberService;

	@RequestMapping(value = { "/", "/index", "/home", "/main" })
	public String main() {
		return "main";
	}

//	회원가입
	@RequestMapping(value = { "join" }, method = RequestMethod.POST)
	public ModelAndView join(@RequestParam Map paramMap) throws Exception {
		System.out.println("path= /join / param=" + paramMap);
		ModelAndView mav = new ModelAndView("main");
		memberService.insertMember((HashMap) paramMap);
		mav.addObject("join","Y");
		return mav;
	}
	
//	로그인
	@RequestMapping(value = { "login" }, method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		System.out.println("path= /login / param=" + paramMap);
		ModelAndView mav = new ModelAndView("main");
		List<HashMap> list = memberService.checkMember((HashMap) paramMap);
		if(list.size() < 1) {
			System.out.println("로그인실패");
			mav.addObject("login","F");
		}else {
			System.out.println("로그인성공");
			System.out.println(request.getParameter("id"));
			HttpSession session =  request.getSession();
			session.setAttribute("login_id", list.get(0).get("ID"));
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	/*
	 * @RequestMapping("/query") public @ResponseBody List<HashMap> query() throws
	 * Exception { return testService.getAll(); }
	 * 
	 * @RequestMapping("/mav") public ModelAndView mav() { ModelAndView mav = new
	 * ModelAndView("mavSample");
	 * 
	 * mav.addObject("key", "fruits"); List<String> fruitList = new
	 * ArrayList<String>();
	 * 
	 * fruitList.add("apple"); fruitList.add("orange"); fruitList.add("banana");
	 * 
	 * mav.addObject("value", fruitList);
	 * 
	 * return mav; }
	 */
}
