package com.crm.service;

import com.crm.entity.ServiceRecord;
import java.util.List;
import java.util.Map;

public interface ServiceRecordService {
    List<ServiceRecord> getAllServiceRecords();
    
    List<ServiceRecord> searchServiceRecords(Long customerId, String type, String status, Long handleUserId);
    
    ServiceRecord getServiceRecordById(Long id);
    
    void saveServiceRecord(ServiceRecord record);
    
    void updateServiceRecord(ServiceRecord record);
    
    void deleteServiceRecord(Long id);
    
    void updateStatus(Long id, String status);
    
    void assignHandler(Long id, Long handleUserId);
    
    void completeSolution(Long id, String solution);
    
    void updateSatisfaction(Long id, Integer satisfaction);
    
    int getServiceCount();
    
    List<Map<String, Object>> getStatusStats();
    
    List<Map<String, Object>> getTypeStats();
    
    List<Map<String, Object>> getSatisfactionStats();
    
    Double getAvgHandleTime();
} 