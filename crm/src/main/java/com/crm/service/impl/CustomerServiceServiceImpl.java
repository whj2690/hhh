package com.crm.service.impl;

import com.crm.dao.CustomerServiceDao;
import com.crm.entity.CustomerService;
import com.crm.service.CustomerServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceServiceImpl implements CustomerServiceService {
    
    @Autowired
    private CustomerServiceDao serviceDao;

    @Override
    public List<CustomerService> getAllServices() {
        return serviceDao.findAll();
    }

    @Override
    public List<CustomerService> searchServices(Long customerId, String type, String status) {
        return serviceDao.findByCondition(customerId, type, status);
    }

    @Override
    public CustomerService getServiceById(Long id) {
        return serviceDao.findById(id);
    }

    @Override
    public void createService(CustomerService service) {
        service.setStatus("PENDING");  // 新建服务默认为待处理状态
        serviceDao.insert(service);
    }

    @Override
    public void updateService(CustomerService service) {
        serviceDao.update(service);
    }

    @Override
    public void deleteService(Long id) {
        serviceDao.delete(id);
    }

    @Override
    public void updateServiceStatus(Long id, String status) {
        serviceDao.updateStatus(id, status);
    }

    @Override
    public void assignHandler(Long id, String handler) {
        serviceDao.updateHandler(id, handler);
        serviceDao.updateStatus(id, "PROCESSING");  // 分配处理人后状态改为处理中
    }

    @Override
    public void completeService(Long id, String result, Integer satisfaction) {
        serviceDao.updateResult(id, result, satisfaction);
    }
} 