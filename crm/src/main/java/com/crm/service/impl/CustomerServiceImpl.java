package com.crm.service.impl;

import com.crm.dao.CustomerDao;
import com.crm.entity.Customer;
import com.crm.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService {
    
    private static final Logger logger = LoggerFactory.getLogger(CustomerServiceImpl.class);
    
    @Autowired
    private CustomerDao customerDao;

    @Override
    public List<Customer> getAllCustomers() {
        return customerDao.findAll();
    }

    @Override
    public Customer getCustomerById(Long id) {
        return customerDao.findById(id);
    }

    @Override
    public void saveCustomer(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("客户信息不能为空");
        }
        
        if (customer.getName() == null || customer.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("客户名称不能为空");
        }
        
        try {
            if (customer.getId() == null) {
                // 新增客户
                customer.setCreateTime(new Date());
                int rows = customerDao.insert(customer);
                if (rows != 1) {
                    throw new RuntimeException("添加失败");
                }
                logger.info("Successfully added new customer: {}", customer.getName());
            } else {
                // 更新客户
                update(customer);
            }
        } catch (Exception e) {
            logger.error("Failed to save customer: {}", customer, e);
            throw new RuntimeException("保存失败：" + e.getMessage());
        }
    }

    @Override
    public void updateCustomer(Customer customer) {
        update(customer);
    }

    @Override
    public void deleteCustomer(Long id) {
        customerDao.deleteById(id);
    }

    @Override
    public void updateCustomerStatus(Long id, String status) {
        customerDao.updateStatus(id, status);
    }

    @Override
    public List<Customer> searchCustomers(String name, String level, String status) {
        return customerDao.findByCondition(name, level, status);
    }

    @Override
    public int getCustomerCount() {
        return customerDao.getCustomerCount();
    }

    @Override
    public List<Map<String, Object>> getCustomerTypeStats() {
        return customerDao.countByType();
    }

    @Override
    public int getNewCustomerCount() {
        return customerDao.getNewCustomerCount();
    }

    @Override
    public void update(Customer customer) {
        if (customer == null || customer.getId() == null) {
            throw new IllegalArgumentException("客户信息不完整");
        }
        
        logger.info("Updating customer with ID: {}", customer.getId());
        logger.debug("Customer details: {}", customer);
        
        // 验证客户是否存在
        Customer existingCustomer = customerDao.findById(customer.getId());
        if (existingCustomer == null) {
            throw new RuntimeException("客户不存在");
        }
        
        // 保留创建时间和创建人信息
        customer.setCreateTime(existingCustomer.getCreateTime());
        customer.setCreateUserId(existingCustomer.getCreateUserId());
        
        // 设置更新时间
        customer.setUpdateTime(new Date());
        
        try {
            int rows = customerDao.update(customer);
            if (rows != 1) {
                throw new RuntimeException("更新失败，影响行数：" + rows);
            }
            logger.info("Successfully updated customer with ID: {}", customer.getId());
        } catch (Exception e) {
            logger.error("Failed to update customer with ID: " + customer.getId(), e);
            throw new RuntimeException("更新失败：" + e.getMessage());
        }
    }
} 