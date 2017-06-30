package com.iclick.symphony.iaudience.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iclick.symphony.iaudience.entity.User;
import com.iclick.symphony.iaudience.service.UserSerivce;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserSerivce userSerivce;
	
//	@Autowired
//	private RestUserClient restUserClient;
	
	
	@Value("${profile.name}")
	private String profileName;
	
	@Value("${profile.num}")
	private int profileNum;
	
	
	@RequestMapping("/list")
	public String listUsers(Model model){
		List<User> users = userSerivce.getUserList();
		model.addAttribute("users", users);
		return "user/list";
	}
	
	
	@ResponseBody
	@RequestMapping("/profile-name")
	public Map<String, Object> getProfileName(){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("controller", profileName);
		map.put("service", userSerivce.getProfileName());
		map.put("profileNum", profileNum);
		return map;
	}

}
