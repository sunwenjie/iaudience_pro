package com.iclick.symphony.iaudience.controller;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration("example/src/main/webapp")
@ContextConfiguration({
	"classpath:spring-mvc.xml",
	"classpath:applicationContext.xml"
})
public class PropertiesDemoTest {

}
