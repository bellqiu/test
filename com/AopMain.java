package com.ms.aop;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ms.aop.bean.TestBean;

public class AopMain {

	public static void main(String[] args_) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"/com/ms/aop/applicationContext.xml");
		TestBean tb = context.getBean("testBean", TestBean.class);
		tb.test();
		System.out.println("Main End");
	}
}
