package com.iclick.symphony.iaudience.clients.sync;


public class UserRequest implements BaseRequest {
    private static final String REQ_URL = "http://www.126.com";

    @Override
    public String build() {
        return REQ_URL;
    }

}