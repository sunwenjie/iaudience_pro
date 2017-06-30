package com.iclick.symphony.iaudience.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.iclick.symphony.iaudience.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {

}
