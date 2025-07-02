package com.crm.service;

import com.crm.entity.CustomerService;
import java.util.List;

public interface CustomerServiceService {
    List<CustomerService> getAllServices();
    
    List<CustomerService> searchServices(Long customerId, String type, String status);
    
    CustomerService getServiceById(Long id);
    
    void createService(CustomerService service);
    
    void updateService(CustomerService service);
    
    void deleteService(Long id);
    
    void updateServiceStatus(Long id, String status);
    
    void assignHandler(Long id, String handler);
    
    void completeService(Long id, String result, Integer satisfaction);
} 