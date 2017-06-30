package com.iclick.symphony.iaudience.clients.sync;

import java.util.Map;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.concurrent.ListenableFuture;
import org.springframework.web.client.AsyncRestTemplate;

public abstract class AbstractTemplete implements Templete{
    public AsyncRestTemplate asyncRestTemplate;

    @Override
    public <T> ListenableFuture<ResponseEntity<T>> getAsyncForObject(BaseRequest baserequest, Class<T> responseType)
            throws Exception {
        String url = baserequest.build();
        try {
            ListenableFuture<ResponseEntity<T>> t = asyncRestTemplate.getForEntity(url, responseType);
            return t;
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public <T> ListenableFuture<ResponseEntity<T>> getAsyncForObject(BaseRequest baserequest,
            ParameterizedTypeReference<T> responseType) throws Exception {
        String url = baserequest.build();
        try {
            ListenableFuture<ResponseEntity<T>> t = asyncRestTemplate.exchange(url, HttpMethod.GET, null, responseType);
            return t;
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public <T> ListenableFuture<ResponseEntity<T>> getAsyncForObject(BaseRequest baserequest, Class<T> responseType,
            Map<String, ?> uriVariables) throws Exception {
        String url = baserequest.build();
        ListenableFuture<ResponseEntity<T>> t = null;
        try {
            t = asyncRestTemplate.exchange(url, HttpMethod.GET, null, responseType, uriVariables);
            return t;
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public <T> ListenableFuture<ResponseEntity<T>> getAsyncForObject(BaseRequest baserequest,
            ParameterizedTypeReference<T> responseType, Map<String, ?> uriVariables) throws Exception {
        String url = baserequest.build();
        ListenableFuture<ResponseEntity<T>> t = null;
        try {
            t = asyncRestTemplate.exchange(url, HttpMethod.GET, null, responseType, uriVariables);
            return t;
        } catch (Exception e) {
            throw e;
        }
    }

    abstract void setTemplete(AsyncRestTemplate asyncRestTemplate);

}
