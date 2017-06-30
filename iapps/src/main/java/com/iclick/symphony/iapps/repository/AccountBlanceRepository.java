package com.iclick.symphony.iapps.repository;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.iclick.symphony.iapps.domain.AccountBalance;

public interface AccountBlanceRepository extends BaseRepository<AccountBalance, Integer> {

    @Modifying
    @Query("update AccountBalance a set a.balance = (?2) where id = (?1)")
    void updateBalance(Integer id,BigDecimal balance);

}
