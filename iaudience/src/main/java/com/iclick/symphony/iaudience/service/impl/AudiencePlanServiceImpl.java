package com.iclick.symphony.iaudience.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.iclick.symphony.iaudience.dao.*;
import com.iclick.symphony.iaudience.entity.*;
import com.iclick.symphony.iaudience.model.Interest;
import com.iclick.symphony.iaudience.model.remote.Advertiser;
import com.iclick.symphony.iaudience.model.remote.AudienceRightRetMsg;
import com.iclick.symphony.iaudience.model.remote.AudienceRights;
import com.iclick.symphony.iaudience.model.remote.ClientAttributes;
import com.iclick.symphony.iaudience.model.view.*;
import com.iclick.symphony.iaudience.service.AudiencePlanService;
import com.iclick.symphony.iaudience.service.BaseService;
import com.iclick.symphony.iaudience.service.UserSerivce;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by wenjie.sun on 2017/5/17.
 */
@Service
public class AudiencePlanServiceImpl extends BaseService implements AudiencePlanService {
    @Resource
    private AudiencePlanRepository  audiencePlanRepository;

    @Resource
    private LocationRepository locationRepository;

    @Resource
    private LocationCityRepository locationCityRepository;

    @Resource
    private InterestStructureRepository interestRepository;

    @Resource
    private BrandRepository brandRepository;

    @Resource
    private ProductRepository productRepository;

    @Resource
    private AdvancedSettingRepository advancedSettingRepository;

    @Resource
    private UserSerivce userSerivce;

    @Override
    public void save(AudiencePlan audiencePlan) {
       audiencePlanRepository.save(audiencePlan);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public boolean saveOrUpdate(AudiencePlanModel audiencePlanModel) {
        AudiencePlan audiencePlan = null;
        try {
            //新增
            if (audiencePlanModel.getPlanId() == null){
                audiencePlan = new AudiencePlan();
//                audiencePlan.setCreateBy(UserUtil.getLoginUserId());
//                audiencePlan.setUpdateBy(UserUtil.getLoginUserId());
                audiencePlan.setCreateBy(1206);
                audiencePlan.setCreateTime(new Date());
                audiencePlan.setUpdateBy(1206);
                audiencePlan.setUpdateTime(new Date());
            }else {
            //修改之前先删除
                this.deleteBrands(audiencePlanModel.getDeleteBrandIds());
                this.deleteProducts(audiencePlanModel.getDeleteProductIds());
            //修改
                audiencePlan = this.getAudiencePlanById(audiencePlanModel.getPlanId());
                //audiencePlan.setUpdateBy(UserUtil.getLoginUserId());
                audiencePlan.setUpdateBy(1208);
                audiencePlan.setUpdateTime(new Date());
            }
            audiencePlan.setClientId(audiencePlanModel.getClientId());
            audiencePlan.setCategoryId(audiencePlanModel.getCategoryId());
            audiencePlan.setName(audiencePlanModel.getName());
            //新增或修改高级设置
            AdvancedSettingModel advancedSettingModel = audiencePlanModel.getAdvancedSettingModel();
            AdvancedSetting advancedSetting = new AdvancedSetting();
            if ( advancedSettingModel.getAdvancedSettingId() != null ){
                advancedSetting = advancedSettingRepository.findOne(advancedSettingModel.getAdvancedSettingId());
            }
            setAdvancedSettingProperty(advancedSetting,advancedSettingModel);
            audiencePlan.setAdvancedSetting(advancedSetting);

            //新增或修改品牌
            List<BrandModel> brandModelList = audiencePlanModel.getBrandModelList();
            removeNullBrandAndProduct(brandModelList);
            for (BrandModel brandModel : brandModelList) {
                Brand brand = null;
                if (brandModel.getBrandId() == null){
                    brand = new Brand();
                    setBrandProperty(brand,brandModel);
                    List<ProductModel> productModelList = brandModel.getProductModelList();
                    for (ProductModel productModel : productModelList) {
                        Product product = new Product();
                        setProductProperty(product,productModel);
                        brand.addProduct(product);
                    }
                    audiencePlan.addBrand(brand);
                }else {
                    brand = brandRepository.findOne(brandModel.getBrandId());
                    setBrandProperty(brand,brandModel);
                    List<ProductModel> productModelList = brandModel.getProductModelList();
             //新增或修改产品
                    for (ProductModel productModel : productModelList) {
                        Product product = null;
                        if (productModel.getProductId() == null){
                             product = new Product();
                        }else {
                            product = productRepository.findOne(productModel.getProductId());
                        }
                        setProductProperty(product,productModel);
                        brand.addProduct(product);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        this.save(audiencePlan);
        return true;
    }

    private void removeNullBrandAndProduct(List<BrandModel> brandModelList){
        //先去除空brand
        List<BrandModel> removeBrandModelList = new ArrayList<>();
        for (BrandModel brandModel : brandModelList){
            if (brandModel.getBrandId() == null && StringUtils.isBlank(brandModel.getName()) && StringUtils.isBlank(brandModel.getKeyWords()))
                removeBrandModelList.add(brandModel);
        }
        brandModelList.removeAll(removeBrandModelList);
        //再去除空product
        for (BrandModel brandModel : brandModelList){
            List<ProductModel> productModelList = brandModel.getProductModelList();
            List<ProductModel> removeProductModelList = new ArrayList<>();
            for (ProductModel productModel : productModelList){
                if (productModel.getProductId() == null && StringUtils.isBlank(productModel.getName())  && StringUtils.isBlank(productModel.getCategory()) && StringUtils.isBlank(productModel.getKeyWords())){
                    removeProductModelList.add(productModel);
                }
            }
            productModelList.removeAll(removeProductModelList);
            brandModel.setProductModelList(productModelList);
        }

    }

    private void setAdvancedSettingProperty(AdvancedSetting advancedSetting,AdvancedSettingModel advancedSettingModel){
        advancedSetting.setCity(advancedSettingModel.getCity());
        advancedSetting.setLocation(advancedSettingModel.getLocation());
        advancedSetting.setKeyWords(advancedSettingModel.getKeyWords());
    }

    private void  setBrandProperty(Brand brand,BrandModel brandModel){
        brand.setName(brandModel.getName());
        brand.setKeyWords(brandModel.getKeyWords());
        brand.setCompetitor(brandModel.getCompetitor().equals("true") ? true :false);
    }

    private void setProductProperty(Product product,ProductModel productModel){
        product.setCategory(productModel.getCategory());
        product.setName(productModel.getName());
        product.setKeyWords(productModel.getKeyWords());
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteBrands(String[] deleteBrandIds){
        if (deleteBrandIds != null && deleteBrandIds.length > 0) {
            List<Brand> brandList = new ArrayList<>();
            for (String brandId : deleteBrandIds) {
                if (StringUtils.isNotBlank(brandId)) {
                    Brand brand = brandRepository.findOne(Integer.parseInt(brandId));
                    List<Product> productList = brand.getProducts();
                    productRepository.deleteInBatch(productList);
                    brand.setAudiencePlan(null);
                    brandList.add(brand);
                }
            }
            brandRepository.deleteInBatch(brandList);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteProducts(String[] deleteProductIds){
        if (deleteProductIds != null && deleteProductIds.length >0){
            List<Product> productList = new ArrayList<>();
            for (String productId : deleteProductIds){
                if (StringUtils.isNotBlank(productId)) {
                    Product product = productRepository.findOne(Integer.parseInt(productId));
                    if (product != null) {
                        product.setBrand(null);
                        productList.add(product);
                    }
                }
            }
            if (productList.size() > 0)
            productRepository.deleteInBatch(productList);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteAudiencePlan(Integer id){
        AudiencePlan audiencePlan = this.getAudiencePlanById(id);
        if (audiencePlan != null){
            audiencePlan.setDeleted(true);
            audiencePlanRepository.save(audiencePlan);
        }
    }

    @Transactional(readOnly = true)
    public List<String> getSelectCategoryNames(Integer id,Locale locale) {
        String interestLab = this.getInterestList(locale);
        List<Interest> interestList = JSON.parseArray(interestLab,Interest.class);
        Interest interest = new Interest();
        for (Interest temp : interestList){
            if (temp.getAudienceId().equals(id)){
                interest = temp;
                break;
            }
        }
        List<String> initList = new ArrayList<>();
        initList.add(interest.getName());
        return this.getChildrenInterestList(interest,initList);
    }








    @Transactional(readOnly = true)
//    递归方法查询字interest
    public List<String> getChildrenInterestList(Interest interest,List<String> interestNameList) {
        List<Interest> interestListChildren = interest.getChildren();
        if (interest == null && interestListChildren.size() == 0){
           return interestNameList;
        }else {
          for (Interest tmp : interestListChildren){
              interestNameList.add(tmp.getName());
              getChildrenInterestList(tmp,interestNameList);
          }
        }
        return interestNameList;
    }


    @Transactional(propagation = Propagation.REQUIRED)
    public List<Province> getProvinceNameCnList() {
        List<Province> provinceList = new ArrayList<Province>();
        List<LocationProvince> rows = locationRepository.findProvinceList();
        for (LocationProvince row : rows) {
            Province pro = new Province();
            pro.setProvinceId(row.getProvinceId() + "");
            pro.setProvinceName(row.getProvinceNameCn());
            provinceList.add(pro);
        }
        return provinceList;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public List<Province> getProvinceNameEnList() {
        List<Province> provinceList = new ArrayList<Province>();
        List<LocationProvince> rows = locationRepository.findProvinceList();
        for (LocationProvince row : rows) {
            Province pro = new Province();
            pro.setProvinceId(row.getProvinceId() + "");
            pro.setProvinceName(row.getProvinceNameEn());
            provinceList.add(pro);
        }
        return provinceList;
    }

    private Interest coverToInterest(InterestStructure row, Locale locale) {

        Interest interest = new Interest();
        if (Locale.CHINESE.toString().equals(locale.getLanguage())) {
            interest.setName(row.getNameCn());
        } else {
            interest.setName(row.getNameEn());
        }
        String id = String.valueOf(row.getId());
        interest.setAudienceId(id);
        if (StringUtils.isNotBlank(id) && id.length() > 2) {
            interest.setParentId(id.substring(0, id.length() - 2));
        } else {
            interest.setParentId("0");
        }
        return interest;

    }

    @Transactional(propagation = Propagation.REQUIRED)
    public List<City> getCityNameCnList() {
        List<City> cityList = new ArrayList<City>();
        List<LocationCity> rows = locationCityRepository.findCityList();
        for (LocationCity row : rows) {
            City city = new City();
            city.setCityId(row.getCityId()+"");
            city.setCityName(row.getCityNameCn());
            cityList.add(city);
        }
        return cityList;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public List<City> getCityNameEnList() {
        List<City> cityList = new ArrayList<City>();
        List<LocationCity> rows = locationCityRepository.findCityList();
        for (LocationCity row : rows) {
            City city = new City();
            city.setCityId(row.getCityId()+"");
            city.setCityName(row.getCityNameEn());
            cityList.add(city);
        }
        return cityList;
    }

    @Override
    public String getInterestName(Integer id, Locale locale) {
        InterestStructure interest = interestRepository.findOne(id);
        String name = "";
        if (Locale.ENGLISH.toString().equals(locale.getLanguage())) {
            name = interest.getNameEn();
        } else {
            name = interest.getNameCn();
        }
        return name;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public String getInterestList(Locale locale) {
        List<Interest> resultList = new ArrayList<Interest>();
        List<Interest> tempList = null;
        try {
            List<InterestStructure> interestList = interestRepository.findInterestList();

            Interest interest = null;
            Map<String, List<Interest>> subMap = new HashMap<>();
            String parentId = null;
            for (InterestStructure row : interestList) {
                interest = coverToInterest(row, locale);
                parentId = interest.getParentId();
                interest.setChildren(subMap.get(interest.getAudienceId()));

                // 顶级节点
                if ("0".equals(parentId)) {
                    resultList.add(interest);
                } else {
                    if (subMap.containsKey(parentId)) {
                        subMap.get(parentId).add(interest);
                    } else {
                        tempList = new ArrayList<Interest>();
                        tempList.add(interest);
                        subMap.put(parentId, tempList);
                    }
                }
                interest = null;
            }
        } catch (Exception e) {
        }
        return JSONObject.toJSONString(resultList);
    }

    @Override
    public AudiencePlanModel getAudiencePlanModel(Integer id) {
        AudiencePlanModel audiencePlanModel = new AudiencePlanModel();
        AudiencePlan audiencePlan = this.getAudiencePlanById(id);
        if (audiencePlan == null) {
            return null;
        }
        audiencePlanModel.setPlanId(audiencePlan.getId());
        audiencePlanModel.setName(audiencePlan.getName());
        audiencePlanModel.setCategoryId(audiencePlan.getCategoryId());
        audiencePlanModel.setClientId(audiencePlan.getClientId());
//        audiencePlanModel.setUserId( UserUtil.getLoginUserId());
        //brandModel集合
        List<BrandModel> brandModelList = new ArrayList<>();
        List<Brand> brandList = new ArrayList<>(audiencePlan.getBrands());
        Collections.sort(brandList, Comparator.comparingInt(Brand::getId));
        for (Brand brand : brandList){
            BrandModel brandModel = new BrandModel();
            brandModel.setName(brand.getName());
            brandModel.setBrandId(brand.getId());
            brandModel.setCompetitor(brand.isCompetitor()? "true" : "false");
            brandModel.setKeyWords(brand.getKeyWords());
        //producModel集合
            List<ProductModel> productModelList = new ArrayList<>();
            for (Product product : brand.getProducts()){
                ProductModel productModel = new ProductModel();
                productModel.setProductId(product.getId());
                productModel.setCategory(product.getCategory());
                productModel.setName(product.getName());
                productModel.setKeyWords(product.getKeyWords());
                productModelList.add(productModel);
            }
            brandModel.setProductModelList(productModelList);
            brandModelList.add(brandModel);
        }

        audiencePlanModel.setBrandModelList(brandModelList);
        AdvancedSettingModel advancedSettingModel = new AdvancedSettingModel();
        AdvancedSetting advancedSetting = audiencePlan.getAdvancedSetting();
        advancedSettingModel.setAdvancedSettingId(advancedSetting.getId());
        advancedSettingModel.setCity(advancedSetting.getCity());
        advancedSettingModel.setLocation(advancedSetting.getLocation());
        advancedSettingModel.setKeyWords(advancedSetting.getKeyWords());
        audiencePlanModel.setAdvancedSettingModel(advancedSettingModel);
        return audiencePlanModel;
    }

    @Override
    public List<Product> getProductList(Integer id, String type) {
        List<Product> productList = new ArrayList<>();

        if (type.equals("brand")){
            productList = productRepository.findByBrandId(id);
        }
        if (type.equals("product")){
            Product product = productRepository.findOne(id);
            productList.add(product);
        }
        return productList;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String, String> getInterestMaping(Locale locale) {
        List<InterestStructure> interestList = interestRepository.findInterestList();
        Map<String, String> interestMapping = new HashMap<>();
        String name = null;
        for (InterestStructure interest : interestList) {
            if (Locale.ENGLISH.toString().equals(locale.getLanguage())) {
                name = interest.getNameEn();
            } else {
                name = interest.getNameCn();
            }
            interestMapping.put(interest.getId() + "", name);
        }
        return interestMapping;
    }

    @Transactional(readOnly = true)
    public List<AudiencePlan> getAudiencePlanList(List<Integer> clientIds) {
        Sort sort = new Sort(Direction.DESC, "updateTime");
        return audiencePlanRepository.findByIsDeletedFalseAndClientIdIn(clientIds,sort);
    }

    @Transactional(readOnly = true)
    public List<AudiencePlan> getAudiencePlanList(int clientId) {
        Sort sort = new Sort(Direction.DESC, "updateTime");
        return audiencePlanRepository.findByIsDeletedFalseAndClientId(clientId,sort);
    }

    @Transactional(readOnly = true)
    public List<AudiencePlan> getAudiencePlanList() {
        Sort sort = new Sort(Direction.DESC, "updateTime");
        return audiencePlanRepository.findByIsDeletedFalse(sort);
    }

    @Override
    public List<AudiencePlanModel> getAudienceModelList(int clientId) {
        List<AudiencePlan> audiencePlanList = this.getAudiencePlanList(clientId);
        List<AudiencePlanModel> audiencePlanModelList = new ArrayList<>();
        if (audiencePlanList.size() > 0) {
            for (AudiencePlan audiencePlan : audiencePlanList) {
                audiencePlanModelList.add(this.getAudiencePlanModel(audiencePlan.getId()));
            }
        }
        return audiencePlanModelList;
    }


    @Transactional(readOnly = true)
    public AudiencePlan getAudiencePlanById(Integer id) {
        if (id == null){
            return null;
        }
        return audiencePlanRepository.findOne(id);

    }


    @Transactional(readOnly = true)
    public Map<String, Object> getClientsShow(Integer userId,Integer currentClientId) {
        List<ClientModel> recentClients = new ArrayList<>();
        ClientModel currentClient = new ClientModel();
        List<AgentModel> allAgents = new ArrayList<>();
        List<Integer> userIds = new ArrayList<>();
        userIds.add(userId);
        AudienceRights audienceRights =  userSerivce.getClients(userIds);
        AudienceRightRetMsg audienceRightRetMsg = audienceRights.getRet_msg();
        if (audienceRightRetMsg != null && audienceRightRetMsg.getList() != null){
            ClientAttributes clientAttributes = audienceRightRetMsg.getList().get(0);
            List<Advertiser> advertiserList = clientAttributes.getAdvids();
            if (!advertiserList.isEmpty()){
                for (Advertiser advertiser : advertiserList) {
                    AgentModel agentModel = new AgentModel();
                    agentModel.setAgentId(advertiser.getAgent().getId());

                    if (advertiser.getId() == currentClientId){
                        currentClient.setClientId(currentClientId);
                        currentClient.setClientName(advertiser.getName());
                    }

                }
            }

        }
        System.out.println(audienceRights);
        Map<String,Object> map = new HashMap();
        map.put("currentClient","");
        map.put("recentClient","");
        map.put("all","");
        return map;
    }








    @Transactional(readOnly = true)
	public Page<AudiencePlan> getAllByPage(int pageNumber, int pageSize) {
		Sort sort = new Sort(Direction.DESC, "createTime");
		PageRequest request = buildPageRequest(pageNumber,pageSize, sort);
        Page<AudiencePlan> audiencePlans = audiencePlanRepository.findAllPlans(false, request);
        return audiencePlans;
	}


	@Override
	public List<Product> getProductsByBrandId(int id) {
		return productRepository.findByBrandId(id);
	}

}
