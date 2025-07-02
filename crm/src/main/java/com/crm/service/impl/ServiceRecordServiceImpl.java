package com.crm.service.impl;

import com.crm.dao.ServiceRecordDao;
import com.crm.entity.ServiceRecord;
import com.crm.service.ServiceRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ServiceRecordServiceImpl implements ServiceRecordService {
    
    @Autowired
    private ServiceRecordDao serviceRecordDao;

    @Override
    public List<ServiceRecord> getAllServiceRecords() {
        return serviceRecordDao.findAll();
    }

    @Override
    public List<ServiceRecord> searchServiceRecords(Long customerId, String type, String status, Long handleUserId) {
        Map<String, Object> params = new HashMap<>();
        params.put("customerId", customerId);
        params.put("type", type);
        params.put("status", status);
        params.put("handleUserId", handleUserId);
        return serviceRecordDao.findByCondition(params);
    }

    @Override
    public ServiceRecord getServiceRecordById(Long id) {
        return serviceRecordDao.findById(id);
    }

    @Override
    public void saveServiceRecord(ServiceRecord record) {
        serviceRecordDao.insert(record);
    }

    @Override
    public void updateServiceRecord(ServiceRecord record) {
        serviceRecordDao.update(record);
    }

    @Override
    public void deleteServiceRecord(Long id) {
        serviceRecordDao.delete(id);
    }

    @Override
    public void updateStatus(Long id, String status) {
        serviceRecordDao.updateStatus(id, status, null);
    }

    @Override
    public void assignHandler(Long id, Long handleUserId) {
        serviceRecordDao.updateStatus(id, "处理中", handleUserId);
    }

    @Override
    public void completeSolution(Long id, String solution) {
        serviceRecordDao.completeSolution(id, solution);
    }

    @Override
    public void updateSatisfaction(Long id, Integer satisfaction) {
        serviceRecordDao.updateSatisfaction(id, satisfaction);
    }

    @Override
    public int getServiceCount() {
        return serviceRecordDao.getServiceCount();
    }

    @Override
    public List<Map<String, Object>> getStatusStats() {
        return serviceRecordDao.countByStatus();
    }

    @Override
    public List<Map<String, Object>> getTypeStats() {
        return serviceRecordDao.countByType();
    }

    @Override
    public List<Map<String, Object>> getSatisfactionStats() {
        return serviceRecordDao.countBySatisfaction();
    }

    @Override
    public Double getAvgHandleTime() {
        return serviceRecordDao.getAvgHandleTime();
    }
} 