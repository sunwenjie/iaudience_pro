package com.iclick.symphony.iaudience.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"classpath:applicationContext.xml"
})
public class UserServiceTest {
	@Test
	public void test(){
		System.out.println("---------AudienceRecordServiceTest.test---------111 值= " + 111);
	}
}
