package com.crm.service;

import com.crm.entity.SalesOrder;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface SalesOrderService {
    List<SalesOrder> getAllOrders();
    
    List<SalesOrder> searchOrders(Long customerId, String status, String paymentStatus);
    
    SalesOrder getOrderById(Long id);
    
    SalesOrder getOrderByOrderNo(String orderNo);
    
    void saveOrder(SalesOrder order);
    
    void updateOrder(SalesOrder order);
    
    void deleteOrder(Long id);
    
    void updateOrderStatus(Long id, String status);
    
    void updatePaymentStatus(Long id, String paymentStatus);
    
    List<SalesOrder> getOrdersByCustomer(Long customerId);
    
    List<SalesOrder> getOrdersByOpportunity(Long opportunityId);
    
    int getOrderCount();
    
    double getTotalAmount();
    
    List<Map<String, Object>> getOrderStatusStats();
    
    int getNewOrderCount();
    
    int getMonthlyOrderCount();
    
    BigDecimal getMonthlyAmount();
    
    List<Map<String, Object>> getMonthlySales();
    
    List<Map<String, Object>> getSalesByCustomerType();
    
    List<Map<String, Object>> getSalesByProductType();
} 