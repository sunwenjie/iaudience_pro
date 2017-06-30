package com.iclick.symphony.iaudience.entity;

import com.alibaba.fastjson.JSON;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Created by wenjie.sun on 2017/5/17.
 */
@Entity
@Table(name = "iau_brand")
@NamedQuery(name = "Brand.findAll",query = "SELECT i FROM Brand i")
public class Brand implements Serializable{
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "is_competitor")
    private boolean isCompetitor;

    @ManyToOne
    @JoinColumn(name = "audience_plan_id")
    private AudiencePlan audiencePlan;

    @Column(name = "key_words")
    private String keyWords;

    @OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.EAGER, mappedBy = "brand")
    private List<Product> products;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public AudiencePlan getAudiencePlan() {
        return audiencePlan;
    }

    public void setAudiencePlan(AudiencePlan audiencePlan) {
        this.audiencePlan = audiencePlan;
    }


    public String getKeyWords() {
        return keyWords;
    }

    public void setKeyWords(String keyWords) {
        this.keyWords = keyWords;
    }

    public boolean isCompetitor() {
        return isCompetitor;
    }

    public void setCompetitor(boolean competitor) {
        isCompetitor = competitor;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Brand brand = (Brand) o;
        return isCompetitor == brand.isCompetitor && Objects.equals(id, brand.id) && Objects.equals(name, brand.name) && Objects.equals(audiencePlan, brand.audiencePlan) && Objects.equals(keyWords, brand.keyWords);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, isCompetitor, audiencePlan, keyWords);
    }

    public Product addProduct(Product product){
        if (getProducts() == null){
            setProducts(new ArrayList<>());
        }
        getProducts().add(product);
        product.setBrand(this);
        return product;
    }

    public Product removeProduct(Product product){
        getProducts().remove(product);
        product.setBrand(null);
        return product;
    }

}
