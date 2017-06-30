package com.iclick.symphony.iaudience.model.view;

/**
 * Created by wenjie.sun on 2017/5/23.
 */
public class ProductModel {
    private Integer productId;
    private String category;
    private String name;
    private String keyWords;

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKeyWords() {
        return keyWords;
    }

    public void setKeyWords(String keyWords) {
        this.keyWords = keyWords;
    }
}
