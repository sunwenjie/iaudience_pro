package com.iclick.symphony.iaudience.service;

import com.iclick.symphony.iaudience.entity.User;
import com.iclick.symphony.iaudience.model.remote.AudienceLogin;
import com.iclick.symphony.iaudience.model.remote.AudienceRights;

import java.util.List;

/**
 * @author iclick
 *
 */
public interface UserSerivce {
	
	/**
	 * get all user list
	 * @return
	 */
	 List<User> getUserList();
	
	 String getProfileName();

	 AudienceLogin verifyUser(String username, String password);

	 AudienceRights getClients(List<Integer> userIds);


}
