package com.iclick.symphony.iaudience.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "locations")
public class LocationProvince {

    /**
     * id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 省份id
     */
    @Column(name = "province_id", nullable = false)
    private int provinceId;

    /**
     * 省份中文名
     */
    @Column(name = "province_name_zh_cn", nullable = false)
    private String provinceNameCn;

    /**
     * 省份英文名
     */
    @Column(name = "province_name_en_us", nullable = false)
    private String provinceNameEn;

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

    public LocationProvince() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    public String getProvinceNameCn() {
        return provinceNameCn;
    }

    public void setProvinceNameCn(String provinceNameCn) {
        this.provinceNameCn = provinceNameCn;
    }

    public String getProvinceNameEn() {
        return provinceNameEn;
    }

    public void setProvinceNameEn(String provinceNameEn) {
        this.provinceNameEn = provinceNameEn;
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
        LocationProvince other = (LocationProvince) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Location [id=" + id + ", provinceId=" + provinceId + ", provinceNameCn=" + provinceNameCn
                + ", provinceNameEn=" + provinceNameEn + ", cityId =" + cityId + ", cityNameCn=" + cityNameCn
                + ", cityNameEn=" + cityNameEn + "]";
    }

    public LocationProvince(int provinceId, String provinceNameCn, String provinceNameEn) {
        super();
        this.provinceId = provinceId;
        this.provinceNameCn = provinceNameCn;
        this.provinceNameEn = provinceNameEn;
    }

}
