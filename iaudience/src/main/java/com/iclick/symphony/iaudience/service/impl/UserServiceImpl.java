package com.iclick.symphony.iaudience.service.impl;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.clients.UserLoginRestClient;
import com.iclick.symphony.iaudience.dao.UserRepository;
import com.iclick.symphony.iaudience.entity.User;
import com.iclick.symphony.iaudience.model.remote.AudienceLogin;
import com.iclick.symphony.iaudience.model.remote.AudienceRights;
import com.iclick.symphony.iaudience.service.UserSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserSerivce {
	@Value("${profile.name}")
	private String profileName;
	
	@Autowired
	private UserRepository userRepository;

	@Resource
	private UserLoginRestClient userLoginRestClient;
	
	@Transactional(readOnly=true)
	public List<User> getUserList(){
		return userRepository.findAll();
	}

	@Override
	public String getProfileName() {
		return profileName;
	}

	@Override
	public AudienceLogin verifyUser(String username, String password) {
		//lijiangna ljn0208@optaim
		String jsonStr = userLoginRestClient.verifyUser(username,password);
		if (jsonStr.indexOf("user not exists") > 0){
			jsonStr = jsonStr.replace("user not exists","");
		}
		AudienceLogin audienceLogin = JSON.parseObject(jsonStr, AudienceLogin.class);
		System.out.println("========audienceLogin:"+audienceLogin);
		return audienceLogin;
	}

	@Override
	public AudienceRights getClients(List<Integer> userIds) {
		List<Integer> ids = new ArrayList<>();
		String jsonStr = userLoginRestClient.clients(ids);
		if (jsonStr.indexOf("data not exist") > 0){
			jsonStr = jsonStr.replace("data not exist","");
		}
		AudienceRights audienceRights = JSON.parseObject(jsonStr, AudienceRights.class);
		System.out.println("========audienceRights:"+audienceRights);
		return audienceRights;
	}


}
