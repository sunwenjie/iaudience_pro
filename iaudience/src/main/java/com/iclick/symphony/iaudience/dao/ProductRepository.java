package com.iclick.symphony.iaudience.dao;

import com.iclick.symphony.iaudience.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by wenjie.sun on 2017/5/23.
 */
public interface ProductRepository extends JpaRepository<Product,Integer> {
  List<Product> findByBrandId(Integer brandId);
}
