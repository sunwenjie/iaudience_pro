package com.iclick.symphony.iaudience.clients;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.concurrent.ListenableFuture;
import org.springframework.util.concurrent.ListenableFutureCallback;
import org.springframework.web.client.AsyncRestTemplate;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Joiner;
import com.google.common.base.Stopwatch;
import com.iclick.symphony.iaudience.constants.AudienceTypeEnum;
import com.iclick.symphony.iaudience.model.remote.AudienceComposition;
import com.iclick.symphony.iaudience.model.remote.RetargetingComposition;
import com.iclick.symphony.iaudience.model.remote.SuggestionComposition;
import com.iclick.symphony.iaudience.util.AudienceRestUtil;

@Component
public class AudienceRestClient {
    private static final Logger log = LoggerFactory.getLogger(AudienceRestClient.class);

    @Autowired
    private AsyncRestTemplate asyncRestTemplate;

    @Autowired
    private RestTemplate restTemplate;

    private static ExecutorService EXECUTOR = Executors.newSingleThreadExecutor();
   
    //
    static private final String IAUDIENCE_AUDIENCE_URL = "http://api.data.optimix.asia/iclick/iaudience/audience/v1.0/composition";
    //
    static private final String IAUDIENCE_RETARGETING_URL = "http://api.data.optimix.asia/iclick/iaudience/retargeting/v1.0/composition";
    //
    static private final String IAUDIENCE_SUGGESTION_URL = "http://api.data.optimix.asia/iclick/iaudience/suggestion/v1.0/composition";
    //
    static private final String IAUDIENCE_SUGGESTION_ARTICLE_URL = "http://api.data.optimix.asia/iclick/iaudience/suggestion/v1.0/article";
    //
    static private final String IAUDIENCE_ANALYSIS_VECTOR_URL = "http://api.data.optimix.asia/iclick/iaudience/analysis/v1.0/vector";
    //
    static private final String IAUDIENCE_ANALYSIS_OPINION_URL = "http://api.data.optimix.asia/iclick/iaudience/analysis/v1.0/opinion";
    //
    static private final String IAUDIENCE_COMPARE_URL = "http://api.data.optimix.asia/iclick/iaudience/comparison/v1.0/composition";
    //查询All market 的人群
    static private final String IAUDIENCE_COMPOUND_URL = "http://api.data.optimix.asia/iclick/iaudience/compound/v1.0/composition";
    //
    static private final String IAUDIENCE_LBS_URL = "http://api.data.optimix.asia/iclick/iaudience/lbs/v1.0/composition";
    //
    static private final String IAUDIENCE_MAPPING_GET_URL = "http://api.data.optimix.asia/iclick/iaudience/mapping/v1.0/composition/get";
    //
    static private final String IAUDIENCE_MAPPING_COMMIT_URL = "http://api.data.optimix.asia/iclick/iaudience/mapping/v1.0/composition/commit";
   
    
   
    
    
    //
    //static private final String IAUDIENCE_COMPARISON_URL = "http://api.data.optimix.asia/iclick/iaudience/comparison/v1.0/composition";
    //
    //static private final String IAUDIENCE_RETARGETING_URL = "http://api.data.optimix.asia/iclick/report/retargetingAudience/v1.0/info";

    static private final String IAUDIENCE_SEARCH_RETARGETING_URL = "";

    static private final long REST_WAIT_TIME = 1000 * 60 * 4;

    static public final String INTERROGATION = "?";

    public List<String> getIaudienceComparesionAsync(List<String> parames) {
        HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        // headers.setContentType(MediaType.TEXT_PLAIN);
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));
        final CountDownLatch latch = new CountDownLatch(parames.size());
        List<String> resultList = new ArrayList<String>();
        try {
            for (String parame : parames) {
                HttpEntity<String> strEntity = new HttpEntity<String>(parame, headers);
                ListenableFuture<ResponseEntity<String>> listenableFuture = asyncRestTemplate
                        .postForEntity(IAUDIENCE_COMPARE_URL, strEntity, String.class);
                try {
                    listenableFuture.get(REST_WAIT_TIME, TimeUnit.MILLISECONDS);
                    listenableFuture.addCallback(new ListenableFutureCallback<ResponseEntity<String>>() {
                        @Override
                        public void onSuccess(ResponseEntity<String> result) {
                            resultList.add(result.getBody());
                            latch.countDown();
                        }

                        @Override
                        public void onFailure(Throwable t) {
                            latch.countDown();
                            log.error("call-audience-camparesion-error={}", t.getMessage());
                        }
                    });
                } catch (InterruptedException e) {
                    latch.countDown();
                    log.error("call-audience-error={}", e);
                } catch (ExecutionException e) {
                    latch.countDown();
                    log.error("call-audience-error={}", e);
                } catch (TimeoutException e) {
                    latch.countDown();
                    log.error("call-audience-error={}", e);
                }

            }

            try {
                latch.await();
                if (resultList.size() < parames.size()) {
                    log.error("call-audience-error={}", "result not corret");
                }
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        } catch (Exception e) {
            log.error("call-audience-error={}", e);
        }
        return resultList;
    }

    /**
     * 单次调用接口
     * 
     * @param parame
     * @return
     */
    public String getIaudienceAudience(String parames) {
        HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));
        String result = "";
        try {
            HttpEntity<String> strEntity = new HttpEntity<String>(parames.toString(), headers);
            result = restTemplate.postForObject(IAUDIENCE_AUDIENCE_URL, strEntity, String.class);
        } catch (Exception e) {
            log.error("getIaudienceComparesion-error:{}", e);
        }
        return result;
    }

    public JSONObject getIaudiencesuggestion(String parame) {

        JSONObject json = null;
        try {
            String url = IAUDIENCE_SUGGESTION_URL + "?wq=" + parame;
            json = restTemplate.getForObject(url, JSONObject.class);
        } catch (Exception e) {
            log.error("getIaudiencesuggestion-error:{}", e);
        }
        return json;
    }
    

    public JSON getIaudienceKeyWord(String parame) {

    	JSON json = null;
        try {
            String url = IAUDIENCE_SUGGESTION_URL + "?wq=" + parame;
            json = restTemplate.getForObject(url, JSONObject.class);
        } catch (Exception e) {
            log.error("getIaudiencesuggestion-error:{}", e);
        }
        return json;
    }
   

    public JSONObject getIaudienceArticleSuggestion(String parame, int num) {

        JSONObject json = null;
        try {
            String url = IAUDIENCE_SUGGESTION_ARTICLE_URL + "?wq=" + parame + "&num=" + num + "&fs=true";
            json = restTemplate.getForObject(url, JSONObject.class);
        } catch (Exception e) {
            log.error("getIaudiencesuggestion-error:{}", e);
        }
        return json;
    }
    

    public JSONObject getIaudienceAnalysisVector(String parame) {

        JSONObject json = null;
        try {
            String url = IAUDIENCE_ANALYSIS_VECTOR_URL + "?wq=" + parame;
            json = restTemplate.getForObject(url, JSONObject.class);
        } catch (Exception e) {
            log.error("getIaudiencesuggestion-error:{}", e);
        }
        return json;
    }
    

    public JSONObject getIaudienceAnalysisOpinion(String parame) {

        JSONObject json = null;
        try {
            String url = IAUDIENCE_ANALYSIS_OPINION_URL + "?wq=" + parame;
            json = restTemplate.getForObject(url, JSONObject.class);
        } catch (Exception e) {
            log.error("getIaudiencesuggestion-error:{}", e);
        }
        return json;
    }

    public AudienceComposition getInterestAudience(final String[] interest, Boolean needAggs) {
        String parames = AudienceRestUtil.getInterestParame(interest, needAggs);
        System.out.println("---------AudienceRestClient.getInterestAudience---------parames 值= " + parames);
        String result = this.getIaudienceAudience(parames);
        AudienceComposition audienceComposition = JSON.parseObject(result, AudienceComposition.class);
        return audienceComposition;
    }

    // retargeting 和 search retargeting audience api调用
    public List<RetargetingComposition> getRetargetingComposition(int eventId, AudienceTypeEnum type) {
        List<RetargetingComposition> retargetingCompositions = new ArrayList<>();
        try {

            String url = null;
            if (type.equals(AudienceTypeEnum.SEARCH_RETARGETING)) {
                url = Joiner.on(INTERROGATION).join(IAUDIENCE_SEARCH_RETARGETING_URL, eventId);
            } else if (type.equals(AudienceTypeEnum.SEARCH_RETARGETING)) {
                url = Joiner.on(INTERROGATION).join(IAUDIENCE_RETARGETING_URL, eventId);
            }
            JSONArray jsonArray = restTemplate.getForObject(url, JSONArray.class);
            retargetingCompositions = JSONArray.parseArray(jsonArray.toJSONString(), RetargetingComposition.class);
        } catch (Exception e) {
            log.error("getRetargetingComposition-error:{}", e);
        }
        return retargetingCompositions;
    }

    public List<String> getAudiences(List<String> parames, String url) {
        InvokeAllThread it = new InvokeAllThread();
        List<String> resultList = null;
        try {
            resultList = it.invokAudienceTasks(parames, restTemplate, url);
        } catch (InterruptedException e) {
            log.error("call-audience-error={},url=" + url, e);
        }
        return resultList;
    }

    /**
     * 批量调动，使用异步调用接口
     * 
     * @param parames
     * @return
     */
    public List<String> getAudienceBatch(List<String> parames, String url) {
        HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        // headers.setContentType(MediaType.TEXT_PLAIN);
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));
        List<String> resultList = new ArrayList<String>();
        // 初始化
        for (int i = 0; i < parames.size(); i++) {
            resultList.add(null);
        }
        final CountDownLatch latch = new CountDownLatch(parames.size());
        Future<String> future = null;
        try {
            // 用于保证返回数据的顺序
            int index = 0;
            for (String parame : parames) {
                index++;
                HttpEntity<String> strEntity = new HttpEntity<String>(parame.toString(), headers);
                future = EXECUTOR.submit(new Callable<String>() {
                    @Override
                    public String call() {
                        try {
                            String result = restTemplate.postForObject(url, strEntity, String.class);
                            return result;
                        } catch (Exception e) {
                            latch.countDown();
                            log.error("call-audience-error={},url=" + url, e);
                            return null;
                        }
                    }
                });
                try {
                    resultList.set(index - 1, future.get(REST_WAIT_TIME, TimeUnit.MILLISECONDS));
                    latch.countDown();
                } catch (InterruptedException e) {
                    latch.countDown();
                } catch (ExecutionException e) {
                    latch.countDown();
                } catch (TimeoutException e) {
                    latch.countDown();
                }
            }
            try {
                latch.await();
                if (resultList.size() < parames.size()) {
                    log.error("call-audience-error={},url=" + url, "result not corret");
                }
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        } catch (Exception e) {
            log.error("getIaudienceComparesion-error:{},url=" + url, e);
        }
        return resultList;
    }

    public List<String> getAudienceComparesion(List<String> parames) {
        Stopwatch stopwatch = new Stopwatch();
        List<String> result = null;
        result = this.getAudiences(parames, IAUDIENCE_COMPARE_URL);
        log.error("getAudienceComparesion:{},cost=" + stopwatch.elapsedTime(TimeUnit.MILLISECONDS));
        return result;
    }

    public List<String> getAudienceCustom(List<String> parames) {
        return this.getAudiences(parames, IAUDIENCE_AUDIENCE_URL);
    }
    

    public JSONObject getAnalysisOpinion(String parame) {

        JSONObject json = null;
        try {
            String url = IAUDIENCE_ANALYSIS_OPINION_URL + "?wq=" + parame;
            json = restTemplate.getForObject(url, JSONObject.class);
        } catch (Exception e) {
            log.error("getIaudiencesuggestion-error:{}", e);
        }
        return json;
    }
    
    
    /**
     * Lbs 接口调用
     * 
     * @param parames 
     * @return 返回指定区域关键词的LBS信息
     */
    public String getLbsComparesion(String parames) {
        HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));
        String result = "";
        try {
            HttpEntity<String> strEntity = new HttpEntity<String>(parames.toString(), headers);
            result = restTemplate.postForObject(IAUDIENCE_LBS_URL, strEntity, String.class);
        } catch (Exception e) {
            log.error("getIaudienceComparesion-error:{}", e);
        }
        return result;
    }
    
    /**
     * 查询相关品牌的市场人群
     * 
     * @param parames 
     * @return 返回指定品牌关键词的人群总数
     */
    public String getAllMarketComparesion(String parames) {
        HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));
        String result = "";
        try {
            HttpEntity<String> strEntity = new HttpEntity<String>(parames.toString(), headers);
            result = restTemplate.postForObject(IAUDIENCE_COMPOUND_URL, strEntity, String.class);
        } catch (Exception e) {
            log.error("getIaudienceComparesion-error:{}", e);
        }
        return result;
    }
        
    public String brandAnalysis(String brandKeyWords,Boolean isOnlyTotal){//, List<String> productKeyWords
    	HttpHeaders headers = new HttpHeaders();// 创建一个头部对象
        // 设置contentType
        // headers.setContentType(MediaType.TEXT_PLAIN);
        headers.setContentType(MediaType.valueOf("text/plain;charset=UTF-8"));

        String result = "";
        List<Map<String, String>> keyMapList = string2keyMapList(brandKeyWords);
        Map<String, Object> map = new HashMap<>();
        if (!isOnlyTotal){
            String[] aggsFields = {"age", "gender", "province", "raw_interest"};
            map.put("aggs_fields", aggsFields);
        }
        map.put("keyword", keyMapList);

        try {
            HttpEntity<String> strEntity = new HttpEntity<String>(JSONObject.toJSON(map).toString(), headers);
            result = restTemplate.postForObject(IAUDIENCE_AUDIENCE_URL, strEntity, String.class);
        } catch (Exception e) {
            log.error("getIaudienceComparesion-error:{}", e);
        }
        System.out.println(result);
        return result;
        
//        List<String> productResult = new ArrayList<>();
//        for(int i = 0; i < productKeyWords.size(); i++){
//        	List<Map<String, String>> productKeyMapList = string2keyMapList(productKeyWords.get(i));
//        	Map<String, Object> productMap = new HashMap<>();
//        	map.put("keyword", productKeyMapList);
//        	try {
//        		HttpEntity<String> strEntity = new HttpEntity<String>(JSONObject.toJSON(productMap).toString(), headers);
//        		productResult.add(restTemplate.postForObject(IAUDIENCE_AUDIENCE_URL, strEntity, String.class));
//        	} catch (Exception e) {
//        		log.error("getIaudienceComparesion-error:{}", e);
//        	}
//        }
//        System.out.println(productResult);
    }
    
    public SuggestionComposition getKeyWords(String parame, String cnEn, int num){
    	SuggestionComposition json = null;
        try {
            String url = IAUDIENCE_SUGGESTION_URL + "?wq=" + parame + "&num=" + num + "&type=" + cnEn + "&fs=true";
            json = restTemplate.getForObject(url, SuggestionComposition.class);
        } catch (Exception e) {
            log.error("getIaudiencesuggestion-error:{}", e);
        }
        return json;
    }
    
    private List<Map<String, String>> string2keyMapList(String keyWords){
    	List<Map<String, String>> keyMapList = new ArrayList<>();
    	String[] keyArray = keyWords.split(",");
    	for(int i = 0; i < keyArray.length; i++){
        	Map<String, String> keyMap = new HashMap<>();
        	keyMap.put("key", keyArray[i]);
        	keyMapList.add(keyMap);
        }
    	return keyMapList;
    }

}
