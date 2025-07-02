package com.crm.service;

import java.util.List;
import java.util.Map;

public interface ReportService {
    // 客户统计
    Map<String, Object> getCustomerStats();
    
    // 销售机会统计
    Map<String, Object> getOpportunityStats();
    
    // 销售订单统计
    Map<String, Object> getOrderStats();
    
    // 服务统计
    Map<String, Object> getServiceStats();
    
    // 按月统计销售额
    List<Map<String, Object>> getMonthlySales();
    
    // 按客户类型统计销售额
    List<Map<String, Object>> getSalesByCustomerType();
    
    // 按产品类型统计销售额
    List<Map<String, Object>> getSalesByProductType();
    
    // 服务满意度统计
    Map<String, Integer> getServiceSatisfactionStats();
} 