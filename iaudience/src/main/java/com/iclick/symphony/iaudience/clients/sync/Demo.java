package com.iclick.symphony.iaudience.clients.sync;

import java.util.HashMap;
import java.util.Map;

/**
 * 示例 示例仅仅是一个样板，无法运行 需要在web环境下运行，例如启动tomcat服务器并进行相关配置
 * 
 * @author liqqc
 *
 */
public class Demo {

    public static void main(String[] args) {
        ConcreateWapper wapper = new ConcreateWapper();

        Map<BaseRequest, Class<? extends BaseResponse>> request = new HashMap<BaseRequest, Class<? extends BaseResponse>>();
//        request.put(new UserRequest(), new UserResponse().getClass());
//        wapper.setParams(UserEnum.ADD, null, request);
//        wapper.setParams(UserEnum.DELETE, null, request);
//        wapper.setParams(UserEnum.UPDATE, null, request);
//        wapper.setParams(UserEnum.MODIFY, null, request);

        FutureTpDao futureTpDao = new FutureTpDao();
        Map<IEnum, Object> futureData = futureTpDao.getHttpData(wapper);
        for (IEnum ienum : futureData.keySet()) {
            System.err.println(ienum + "=" + futureData.get(ienum));
        }
    }
}