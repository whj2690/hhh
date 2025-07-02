package com.crm.service.impl;

import com.crm.dao.SalesOrderDao;
import com.crm.entity.SalesOrder;
import com.crm.service.SalesOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Service
public class SalesOrderServiceImpl implements SalesOrderService {
    
    @Autowired
    private SalesOrderDao orderDao;

    @Override
    public List<SalesOrder> getAllOrders() {
        return orderDao.findAll();
    }

    @Override
    public List<SalesOrder> searchOrders(Long customerId, String status, String paymentStatus) {
        return orderDao.findByCondition(customerId, status, paymentStatus);
    }

    @Override
    public SalesOrder getOrderById(Long id) {
        return orderDao.findById(id);
    }

    @Override
    public SalesOrder getOrderByOrderNo(String orderNo) {
        return orderDao.findByOrderNo(orderNo);
    }

    @Override
    public void saveOrder(SalesOrder order) {
        if (order.getId() == null) {
            // 新订单，生成订单编号
            order.setOrderNo(orderDao.generateOrderNo());
            orderDao.insert(order);
        } else {
            orderDao.update(order);
        }
    }

    @Override
    public void updateOrder(SalesOrder order) {
        orderDao.update(order);
    }

    @Override
    public void deleteOrder(Long id) {
        orderDao.deleteById(id);  // 修改这里：使用deleteById替代delete
    }

    @Override
    public void updateOrderStatus(Long id, String status) {
        orderDao.updateStatus(id, status);
    }

    @Override
    public void updatePaymentStatus(Long id, String paymentStatus) {
        orderDao.updatePaymentStatus(id, paymentStatus);
    }

    @Override
    public List<SalesOrder> getOrdersByCustomer(Long customerId) {
        return orderDao.findByCustomerId(customerId);
    }

    @Override
    public List<SalesOrder> getOrdersByOpportunity(Long opportunityId) {
        return orderDao.findByOpportunityId(opportunityId);
    }

    @Override
    public int getOrderCount() {
        return orderDao.getOrderCount();
    }

    @Override
    public double getTotalAmount() {
        return orderDao.getTotalAmount();
    }

    @Override
    public List<Map<String, Object>> getOrderStatusStats() {
        return orderDao.countByStatus();
    }

    @Override
    public int getNewOrderCount() {
        return orderDao.getNewOrderCount();
    }

    @Override
    public int getMonthlyOrderCount() {
        return orderDao.getMonthlyOrderCount();
    }

    @Override
    public BigDecimal getMonthlyAmount() {
        return orderDao.getMonthlyAmount();
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
} 