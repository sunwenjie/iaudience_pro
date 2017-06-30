package com.iclick.symphony.iaudience.clients;

import com.alibaba.fastjson.JSONObject;
import com.iclick.symphony.iaudience.util.Digests;
import com.iclick.symphony.iaudience.util.Encodes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wenjie.sun on 2017/6/27.
 */
@Component
public class UserLoginRestClient {
    @Autowired
    private RestTemplate restTemplate;

    private static final Logger log = LoggerFactory.getLogger(UserLoginRestClient.class);
    static private final String IAUDIENCE_LOGIN_URL = "http://iaccess.optimix.asia/api/audience/login";
    static private final String IAUDIENCE_RIGHT_URL = "http://iaccess.optimix.asia/api/audience/rights";
    static private final String SIGNATURE_KEY= "46c4f409ef8524c1e0b46bf87566909a";



    /**
     * 验证用户是否合法
     *
     * @param username
     * @param passwd
     * @return userId
     */
    public String verifyUser(String username,String passwd) {
        HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));
        String result = "";
        Map<String, Object> map = new HashMap<>();
        map.put("name",username);
        map.put("passwd",encyptPassword(passwd));
        Long timestamp =  (new Date()).getTime();
        String signature = encryptSignature(timestamp);
        String url = IAUDIENCE_LOGIN_URL + "?timestamp="+timestamp+"&signature="+signature;
        try {
            HttpEntity<String> strEntity = new HttpEntity<String>(JSONObject.toJSON(map).toString(), headers);
            result = restTemplate.postForObject(url, strEntity, String.class);
        } catch (Exception e) {
            log.error("verifyUser-error:{}", e);
        }
        return result;
    }

    /**
     * 用户权限
     *
     * @param
     * @return userId
     */
    public String clients(List<Integer> userIds) {
        HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));
        String result = "";
        Map<String, Object> map = new HashMap<>();
        map.put("userid",userIds.toArray());
        Long timestamp =  (new Date()).getTime();
        String signature = encryptSignature(timestamp);
        String url = IAUDIENCE_RIGHT_URL + "?timestamp="+timestamp+"&signature="+signature;
        try {
            HttpEntity<String> strEntity = new HttpEntity<String>(JSONObject.toJSON(map).toString(), headers);

            result = restTemplate.postForObject(url, strEntity, String.class);
        } catch (Exception e) {
            log.error("verifyUser-error:{}", e);
        }
        return result;
    }




    private String encryptSignature(Long timestamp){
        String sha1Str = SIGNATURE_KEY + "&" + timestamp;
        byte[] sha1Byte = sha1Str.getBytes();
        byte[] hashSingature = Digests.sha1(sha1Byte,null);
        return Encodes.encodeHex(hashSingature);
    }

    private String encyptPassword(String password){
        byte[] passwdBytes = {};
        try {
            passwdBytes = Digests.md5(password.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Encodes.encodeHex(passwdBytes);
    }






}
