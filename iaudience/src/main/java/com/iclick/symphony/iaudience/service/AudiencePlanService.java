package com.iclick.symphony.iaudience.service;

import com.iclick.symphony.iaudience.entity.AudiencePlan;
import com.iclick.symphony.iaudience.entity.Product;
import com.iclick.symphony.iaudience.model.view.AudiencePlanModel;
import com.iclick.symphony.iaudience.model.view.City;
import com.iclick.symphony.iaudience.model.view.Province;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Created by wenjie.sun on 2017/5/17.
 */
public interface AudiencePlanService {

     List<AudiencePlan> getAudiencePlanList(List<Integer> clientIds);
     List<AudiencePlan> getAudiencePlanList(int clientId);
     List<AudiencePlan> getAudiencePlanList();

     List<AudiencePlanModel> getAudienceModelList(int clientId);

     AudiencePlan getAudiencePlanById(Integer id);

     void save(AudiencePlan audiencePlan);

     boolean saveOrUpdate(AudiencePlanModel entity);

     List<Province> getProvinceNameCnList();

     List<Province> getProvinceNameEnList();

     List<City> getCityNameCnList();

     List<City> getCityNameEnList();

     String getInterestName(Integer id, Locale locale);

     String getInterestList(Locale locale);

     AudiencePlanModel getAudiencePlanModel(Integer id);
     List<Product> getProductList(Integer id, String type);
     Map<String, String> getInterestMaping(Locale locale);

     void deleteBrands(String[] deleteBrandIds);
     void deleteProducts(String[] deleteProductIds);

     void deleteAudiencePlan(Integer id);

     List<String> getSelectCategoryNames(Integer id,Locale locale);

     Map<String,Object> getClientsShow(Integer userId,Integer currentClientId);

     Page<AudiencePlan> getAllByPage(int pageNumber,int pageSize);
     
     public List<Product> getProductsByBrandId(int id);
}
