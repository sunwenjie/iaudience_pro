package com.iclick.symphony.iaudience.clients.sync;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ConcreateWapper {
    private List<Concreate> wrapper = new ArrayList<Concreate>();

    public ConcreateWapper() {
    }

    public void setParams(IEnum baseEnum, Map<String, ?> variables, Map<BaseRequest, ?> request) {
        wrapper.add(new Concreate(baseEnum, variables, request));
    }

    public List<Concreate> getWrapper() {
        return wrapper;
    }

    public static class Concreate {
        private IEnum baseEnum;
        private Map<String, ?> variables;
        private Map<BaseRequest, ?> request;

        public Concreate(IEnum baseEnum, Map<String, ?> variables, Map<BaseRequest, ?> request) {
            this.baseEnum = baseEnum;
            this.variables = variables;
            this.request = request;
        }

        public IEnum getBaseEnum() {
            return baseEnum;
        }

        public void setBaseEnum(IEnum baseEnum) {
            this.baseEnum = baseEnum;
        }

        public Map<String, ?> getVariables() {
            return variables;
        }

        public void setVariables(Map<String, ?> variables) {
            this.variables = variables;
        }

        public Map<BaseRequest, ?> getRequest() {
            return request;
        }

        public void setRequest(Map<BaseRequest, ?> request) {
            this.request = request;
        }
    }
}
