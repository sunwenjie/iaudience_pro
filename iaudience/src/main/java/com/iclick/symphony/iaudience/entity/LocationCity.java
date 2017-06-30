package com.iclick.symphony.iaudience.entity;

import javax.persistence.*;

/**
 * Created by wenjie.sun on 2017/5/22.
 */
@Entity
@Table(name = "locations")
public class LocationCity {
    /**
     * id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 城市id
     */
    @Column(name = "city_id", nullable = false)
    private int cityId;

    /**
     * 城市中文名
     */
    @Column(name = "city_name_zh_cn", nullable = false)
    private String cityNameCn;

    /**
     * 城市英文名
     */
    @Column(name = "city_name_en_us", nullable = false)
    private String cityNameEn;

    /**
     * 城市级别
     */
    @Column(name = "tier_level", nullable = false)
    private String tierLevel;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    public String getCityNameCn() {
        return cityNameCn;
    }

    public void setCityNameCn(String cityNameCn) {
        this.cityNameCn = cityNameCn;
    }

    public String getCityNameEn() {
        return cityNameEn;
    }

    public void setCityNameEn(String cityNameEn) {
        this.cityNameEn = cityNameEn;
    }

    public String getTierLevel() {
        return tierLevel;
    }

    public void setTierLevel(String tierLevel) {
        this.tierLevel = tierLevel;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        LocationCity other = (LocationCity) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Location [id=" + id + ",cityId =" + cityId + ", cityNameCn=" + cityNameCn
            + ", cityNameEn=" + cityNameEn + "]";
    }

    public LocationCity() {
    }

    public LocationCity(int cityId, String cityNameCn, String cityNameEn) {
        super();
        this.cityId = cityId;
        this.cityNameCn = cityNameCn;
        this.cityNameEn = cityNameEn;
    }
}
