package com.crm.service;

import com.crm.entity.SalesOpportunity;
import java.util.List;
import java.util.Map;

public interface SalesOpportunityService {
    List<SalesOpportunity> getAllOpportunities();
    
    List<SalesOpportunity> searchOpportunities(Long customerId, String stage, String status);
    
    SalesOpportunity getOpportunityById(Long id);
    
    void saveOpportunity(SalesOpportunity opportunity);
    
    void updateOpportunity(SalesOpportunity opportunity);
    
    void deleteOpportunity(Long id);
    
    void updateOpportunityStatus(Long id, String status);
    
    List<SalesOpportunity> getOpportunitiesByCustomer(Long customerId);
    
    int getOpportunityCount();
    
    List<Map<String, Object>> getOpportunityStageStats();
    
    int getNewOpportunityCount();
} 