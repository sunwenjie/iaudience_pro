package com.iclick.symphony.iapps.repository;

import java.io.Serializable;

import javax.persistence.EntityManager;

import org.springframework.data.jpa.repository.support.JpaEntityInformation;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;

public class SimpleBaseRepository<T,ID extends Serializable> extends SimpleJpaRepository<T, ID> implements BaseRepository<T, ID> {

    public SimpleBaseRepository(JpaEntityInformation<T, ?> entityInformation, EntityManager em) {
        super(entityInformation, em);
    }
    
    public SimpleBaseRepository(Class<T> domainClass, EntityManager em) {
        super(domainClass, em);
    }

}
