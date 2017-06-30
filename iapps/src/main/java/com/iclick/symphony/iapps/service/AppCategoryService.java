package com.iclick.symphony.iapps.service;

import java.util.List;
import java.util.Set;

import com.iclick.symphony.iapps.domain.AppCategory;

public interface AppCategoryService {

    List<AppCategory> getCategoriesWithApps(Set<Integer> modules);

    List<AppCategory> getCategoriesWithApps();

    List<AppCategory> getCategories();

}
