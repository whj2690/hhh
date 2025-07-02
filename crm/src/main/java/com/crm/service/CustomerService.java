package com.crm.service;

import com.crm.entity.Customer;
import java.util.List;
import java.util.Map;

public interface CustomerService {
    List<Customer> getAllCustomers();
    
    Customer getCustomerById(Long id);
    
    void saveCustomer(Customer customer);
    
    void updateCustomer(Customer customer);
    
    void deleteCustomer(Long id);
    
    void updateCustomerStatus(Long id, String status);
    
    List<Customer> searchCustomers(String name, String level, String status);
    
    int getCustomerCount();
    
    List<Map<String, Object>> getCustomerTypeStats();
    
    int getNewCustomerCount();
    
    void update(Customer customer);
} 