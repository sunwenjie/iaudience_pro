package com.iclick.symphony.iaudience.entity;

import com.iclick.symphony.iaudience.dao.AudiencePlanRepository;
import org.junit.Test;

import javax.annotation.Resource;

/**
 * Created by wenjie.sun on 2017/5/17.
 */
public class AudiencePlanTest {
    @Resource
    private AudiencePlanRepository audiencePlanRepository;

    @Test
    public void testPlan() {
     String a = "true";
     String b = "false";
        System.out.println(Boolean.parseBoolean(a));
        System.out.println(Boolean.parseBoolean(b));

//        AudiencePlanModel audiencePlanModel = new AudiencePlanModel();
//
//        audiencePlanModel.setUserId(1206);
//        audiencePlanModel.setClientId(100);
//        audiencePlanModel.setCategoryId(2000);
//        audiencePlanModel.setName("TestAudience1");
//
//        AdvancedSettingModel advancedSettingModel = new AdvancedSettingModel();
////        advancedSettingModel.setAdvancedSettingId(1);
//        advancedSettingModel.setKeyWords("UpdaateadvancedSetting,1,2,3");
//        advancedSettingModel.setCity("1156110000,1156440100");
//        advancedSettingModel.setLocation("肯德基");
//        audiencePlanModel.setAdvancedSettingModel(advancedSettingModel);
//
//        List<BrandModel> brandModelList = new ArrayList<>();
//        BrandModel brandModel = new BrandModel();
//        brandModel.setName("TestBrand1");
//        brandModel.setCompetitor(false);
//        brandModel.setKeyWords("brand1,1,2,3");
//
//        ProductModel productModel = new ProductModel();
//        productModel.setName("TestProduct1");
//        productModel.setCategory("20001");
//        productModel.setKeyWords("product1,1,2,3");
//
//        ProductModel productModel1 = new ProductModel();
//        productModel1.setName("TestProduct2");
//        productModel1.setCategory("20001");
//        productModel1.setKeyWords("product2,1,2,3");
//
//        List<ProductModel> productModelList = new ArrayList<>();
//        productModelList.add(productModel);
//        productModelList.add(productModel1);
//        brandModel.setProductModelList(productModelList);
//        brandModelList.add(brandModel);
//
//        BrandModel brandModel1 = new BrandModel();
////        brandModel1.setBrandId(2);
////        brandModel1.setName("UpdateTestBrand2");
//        brandModel1.setName("TestBrand2");
//        brandModel1.setCompetitor(true);
//        brandModel1.setKeyWords("brand2,1,2,3");
//
//        ProductModel productMode3 = new ProductModel();
////        productMode3.setProductId(5);
////        productMode3.setName("UpdateTestProduct3");
//        productMode3.setName("TestProduct3");
//        productMode3.setCategory("30001");
//        productMode3.setKeyWords("product3,1,2,3");
//
//        ProductModel productMode4 = new ProductModel();
//        productMode4.setName("TestProduct4");
//        productMode4.setCategory("30002");
//        productMode4.setKeyWords("product4,1,2,3");
//
//        List<ProductModel> productModelList2 = new ArrayList<>();
//        productModelList2.add(productMode3);
//        productModelList2.add(productMode4);
//        brandModel1.setProductModelList(productModelList2);
//        brandModelList.add(brandModel1);
//
//        audiencePlanModel.setBrandModelList(brandModelList);
//        System.out.println(audiencePlanModel.getBrandModelList());
//        List<BrandModel> list = audiencePlanModel.getBrandModelList();
//        list.remove(0);
//        System.out.println(list);

//        audiencePlanModel.setBrandModelList(brandModelList);
//        audiencePlanService.saveOrUpdate(audiencePlanModel);
//
//        String[] deleteProductIds = {"3","4"};
//        audiencePlanService.deleteProducts(deleteProductIds);
    }

}