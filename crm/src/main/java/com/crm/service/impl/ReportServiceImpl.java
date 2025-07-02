package com.crm.service.impl;

import com.crm.dao.CustomerDao;
import com.crm.dao.SalesOpportunityDao;
import com.crm.dao.SalesOrderDao;
import com.crm.dao.CustomerServiceDao;
import com.crm.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

@Service
public class ReportServiceImpl implements ReportService {
    
    @Autowired
    private CustomerDao customerDao;
    
    @Autowired
    private SalesOpportunityDao opportunityDao;
    
    @Autowired
    private SalesOrderDao orderDao;
    
    @Autowired
    private CustomerServiceDao serviceDao;

    @Override
    public Map<String, Object> getCustomerStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("total", customerDao.getCustomerCount());
        stats.put("newCount", customerDao.getNewCustomerCount());
        stats.put("typeDistribution", customerDao.countByType());
        return stats;
    }

    @Override
    public Map<String, Object> getOpportunityStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("total", opportunityDao.getOpportunityCount());
        stats.put("newCount", opportunityDao.getNewOpportunityCount());
        stats.put("stageDistribution", opportunityDao.countByStage());
        return stats;
    }

    @Override
    public Map<String, Object> getOrderStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("total", orderDao.getOrderCount());
        stats.put("totalAmount", orderDao.getTotalAmount());
        stats.put("monthlyCount", orderDao.getMonthlyOrderCount());
        stats.put("monthlyAmount", orderDao.getMonthlyAmount());
        return stats;
    }

    @Override
    public Map<String, Object> getServiceStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("total", serviceDao.getServiceCount());
        stats.put("pendingCount", serviceDao.getPendingCount());
        stats.put("monthlyCount", serviceDao.getMonthlyServiceCount());
        return stats;
    }

    @Override
    public List<Map<String, Object>> getMonthlySales() {
        return orderDao.getMonthlySales();
    }

    @Override
    public List<Map<String, Object>> getSalesByCustomerType() {
        return orderDao.getSalesByCustomerType();
    }

    @Override
    public List<Map<String, Object>> getSalesByProductType() {
        return orderDao.getSalesByProductType();
    }

    @Override
    public Map<String, Integer> getServiceSatisfactionStats() {
        Map<String, Integer> satisfactionStats = new HashMap<>();
        Map<String, Integer> rawStats = serviceDao.countBySatisfaction();
        
        // 确保所有满意度等级都有数据
        for (int i = 1; i <= 5; i++) {
            String key = String.valueOf(i);
            satisfactionStats.put(key, rawStats.getOrDefault(key, 0));
        }
        
        return satisfactionStats;
    }
} 