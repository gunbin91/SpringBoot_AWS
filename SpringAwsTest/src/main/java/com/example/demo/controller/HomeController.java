package com.example.demo.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.example.demo.service.BoardService;
import com.example.demo.vo.BoardVo;

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

	@RequestMapping(value = {"/aws_test"}, method = RequestMethod.POST)
	public ModelAndView aws_test(HttpServletRequest request) throws Exception {
		System.out.println("path= /aws_test");
		ModelAndView mav = new ModelAndView("main");
		String BUCKET_NAME = "gunbin-bucket";
		String ACCESS_KEY ="AKIA5O25UOCXKQYLJKTV";
		String SCRET_KEY ="rh6W7x4fVvpS8MBqVNRHkzSARrthDEAuCd55xKNA";
		
		AWSCredentials awsCredentials = new BasicAWSCredentials(ACCESS_KEY, SCRET_KEY);
		AmazonS3 amazonS3 = new AmazonS3Client();
		
		if(amazonS3 != null) {
			try {
				List<BoardVo> list =  boardService.selectAll();
				
				SimpleDateFormat  formatter = new SimpleDateFormat("yyyyMMddhhss");
				Date date = new Date();
				String s_today =  formatter.format(date);
				String scvFileName = request.getRealPath("/UPLOAD") + "/AWS_S3_"+s_today+".csv";
				
				BufferedWriter writer;
				writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(scvFileName), "MS949"));
				writer.write("No, 제목, 작성자, 작성일 \r\n");
				for(BoardVo board : list){
					writer.write(board.getNum() + ", " 
							+ board.getBoard_title() + ", " 
							+ board.getBoard_writer() + ", " 
							+ board.getBoard_date() + ", \r\n");
				}
				writer.close();
				
				File file = new File(scvFileName);
				com.amazonaws.services.s3.model.PutObjectRequest putObjectRequest 
				= new com.amazonaws.services.s3.model.PutObjectRequest(BUCKET_NAME, file.getName(), file);
				amazonS3.putObject(putObjectRequest);
				mav.addObject("S3", file.getName());
				file.delete();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				amazonS3 = null;
			}
		}
		return mav;
	}

}
