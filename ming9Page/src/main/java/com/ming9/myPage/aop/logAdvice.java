package com.ming9.myPage.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


@Aspect
@Component
public class logAdvice {

	private Logger log = LoggerFactory.getLogger(logAdvice.class);
	//private Logger log = null;
	
	@Before("within (com.ming9.myPage..*Controller)")
	public void beforeAdvice(JoinPoint jp) {
		log.info(jp.toString());
	}
}
