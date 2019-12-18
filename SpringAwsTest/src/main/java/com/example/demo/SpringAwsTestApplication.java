package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class SpringAwsTestApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringAwsTestApplication.class, args);
		System.out.println("세팅완료");
	}


}
