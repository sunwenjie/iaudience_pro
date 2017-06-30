package com.iclick.symphony.iaudience.clients;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.RestTemplate;

/**
 * 批量任务的限时 invokeAll(tasks) 批量提交不限时任务
 * 
 * invokeAll(tasks, timeout, unit) 批量提交限时任务
 * 
 * InvokeAll方法处理一个任务的容器（collection），并返回一个Future的容器。两个容器具有相同的结构：
 * invokeAll将Future添加到返回的容器中，这样可以使用任务容器的迭代器，从而调用者可以将它表现的Callable与Future 关联起来。
 * 当所有任务都完成时、调用线程被中断时或者超过时限时，限时版本的invokeAll都会返回结果。 超过时限后，任务尚未完成的任务都会被取消。
 * 
 * @author hadoop
 * 
 */
public class InvokeAllThread {
    private static final Logger log = LoggerFactory.getLogger(InvokeAllThread.class);
    // 固定大小的线程池，同时只能接受5个任务
    static ExecutorService mExecutor = Executors.newSingleThreadExecutor();

    static private final long REST_WAIT_TIME = 1000 * 60 * 4;

    private class RestTask implements Callable<String> {
        public final String parame;
        public final RestTemplate restTemplate;
        public final String url;
        public String result;

        public RestTask(String parame, RestTemplate restTemplate, String url) {
            this.parame = parame;
            this.restTemplate = restTemplate;
            this.url = url;
        }

        @Override
        public String call() throws Exception {
            HttpHeaders headers = new HttpHeaders();
            HttpEntity<String> strEntity = new HttpEntity<String>(parame, headers);
            this.result = restTemplate.postForObject(url, strEntity, String.class);
            return result;
        }
    }

    public List<String> invokAudienceTasks(List<String> parames, RestTemplate restTemplate, String url)
            throws InterruptedException {
        List<RestTask> tasks = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        for (String parame : parames) {
            tasks.add(new RestTask(parame, restTemplate, url));
        }

        List<Future<String>> futures = mExecutor.invokeAll(tasks, REST_WAIT_TIME, TimeUnit.MILLISECONDS);

//        Iterator<RestTask> taskIter = tasks.iterator();

        String result = null;
        for (Future<String> future : futures) {
//            RestTask task = taskIter.next();
            try {
                result = future.get();
                resultList.add(result);
//                if (!task.result.equals(result)) {
//                    System.out.println("call-audience-error");
//                }
            } catch (ExecutionException e) {
                log.error("call-audience-error={},url=" + url, e);
            } catch (CancellationException e) {
                log.error("call-audience-error={},url=" + url, e);
            }
        }
        // mExecutor.shutdown();
        return resultList;
    }
}
