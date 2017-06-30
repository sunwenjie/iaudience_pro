package com.iclick.symphony.iaudience.service;

import com.iclick.symphony.iaudience.entity.LocationProvince;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.iclick.symphony.iaudience.entity.Brand;
import com.iclick.symphony.iaudience.entity.Product;
import com.iclick.symphony.iaudience.model.Interest;
import com.iclick.symphony.iaudience.model.common.Option;

/**
 * Created by steven.sun on 2017/3/28.
 */
public interface CommonService {

    public List<LocationProvince> getProvinceList();

    public List<Option> getRegionOptionList(Locale locale);

    public List<Option> getAgeGroupOptionList(Locale locale);

    public Map<String, String> getInterestMaping(Locale locale);

    public List<Interest> getInterestList(Locale locale);

    
    public Brand getBrandById(int id);
    
    public Product getProductById(int id);
    
}
