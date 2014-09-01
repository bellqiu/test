package com.ms.aop.bean;

import com.ms.aop.aspect.TestAspectAnnotation;

public class TestBean {

	@TestAspectAnnotation
	public void test() {
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
}
