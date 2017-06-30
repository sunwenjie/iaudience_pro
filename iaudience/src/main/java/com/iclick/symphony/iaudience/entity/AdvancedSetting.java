package com.iclick.symphony.iaudience.entity;

import javax.persistence.*;
import javax.print.DocFlavor;
import java.io.Serializable;

/**
 * Created by wenjie.sun on 2017/5/18.
 */
@Entity
@Table(name = "iau_advanced_setting")
@NamedQuery(name = "AdvancedSetting.findAll",query = "SELECT i FROM AdvancedSetting i")
public class AdvancedSetting implements Serializable{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

//    @OneToOne(mappedBy="advancedSetting")
//    private AudiencePlan audiencePlan;

    @Column(name = "key_words")
    private String keyWords;

    @Column(name = "city")
    private String city;

    @Column(name = "location")
    private String location;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

//    public AudiencePlan getAudiencePlan() {
//        return audiencePlan;
//    }
//
//    public void setAudiencePlan(AudiencePlan audiencePlan) {
//        this.audiencePlan = audiencePlan;
//    }

    public String getKeyWords() {
        return keyWords;
    }

    public void setKeyWords(String keyWords) {
        this.keyWords = keyWords;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
