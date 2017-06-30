package com.iclick.symphony.iaudience.controller;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.htmlunit.MockMvcWebClientBuilder;
import org.springframework.test.web.servlet.htmlunit.webdriver.MockMvcHtmlUnitDriverBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.gargoylesoftware.htmlunit.WebClient;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration("example/src/main/webapp")
@ContextConfiguration({
	"classpath:spring-mvc.xml",
	"classpath:applicationContext.xml"
})
public class UserControllerTest {
	@Resource
	private WebApplicationContext wac;

	MockMvc mockMvc;
	WebClient webClient;
//	WebDriver webDriver;
	
	@Before  
	public void setup() throws Exception {  
	    mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();  
	    webClient = MockMvcWebClientBuilder.webAppContextSetup(wac).build();
//	    webDriver = MockMvcHtmlUnitDriverBuilder.webAppContextSetup(wac).build();
	}
	
	@Test
	public void userListTest() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/user/list"))
				.andExpect(MockMvcResultMatchers.view().name("user/list"))
				.andExpect(MockMvcResultMatchers.model().attributeExists("users"))
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		
		Assert.assertNotNull(result.getModelAndView().getModel().get("users"));
	}
	
	@Test
	public void userLoginTest(){
		
	}
	
	@After  
	public void tearDown() {  
//	    webDriver.close();  
	} 
}
