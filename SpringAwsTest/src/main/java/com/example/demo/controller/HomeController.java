package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.service.BoardService;

@Controller
public class HomeController {

	@Autowired
	BoardService boardService;

	@RequestMapping(value = { "/", "/index", "/home", "/main" })
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("board_list", boardService.selectAll());
		return mav;
	}

}
