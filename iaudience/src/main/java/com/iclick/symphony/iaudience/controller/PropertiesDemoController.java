package com.iclick.symphony.iaudience.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/properties")
public class PropertiesDemoController {
	
	@Value("${profile.name}")
	private String profileName;
	
	@ResponseBody
	@RequestMapping("/profile-name")
	public String getProfileName(){
		return profileName;
	}
}
