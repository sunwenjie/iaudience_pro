package com.iclick.symphony.iaudience.clients.sync;

import java.util.Map;
import java.util.concurrent.CountDownLatch;

import org.springframework.http.ResponseEntity;
import org.springframework.util.concurrent.ListenableFutureCallback;

public class CommonListenableCallBack<T> implements ListenableFutureCallback<T> {
    private IEnum type;
    private Map<IEnum, Object> resultValue;
    private volatile CountDownLatch latch;

    public CommonListenableCallBack(IEnum type, Map<IEnum, Object> resultValue, CountDownLatch latch) {
        this.type = type;
        this.resultValue = resultValue;
        this.latch = latch;
    }

    @Override
    public void onSuccess(T result) {
        ResponseEntity<T> re = (ResponseEntity<T>) result;
        if (re != null && re.getBody() != null) {
            T body = re.getBody();
            if (type != null) {
                resultValue.put(type, body);
            }
        }
        latch.countDown();
    }

    @Override
    public void onFailure(Throwable ex) {
        latch.countDown();
    }

}
