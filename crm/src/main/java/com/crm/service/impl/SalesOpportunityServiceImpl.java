package com.crm.service.impl;

import com.crm.dao.SalesOpportunityDao;
import com.crm.dao.SalesOrderDao;
import com.crm.entity.SalesOpportunity;
import com.crm.entity.SalesOrder;
import com.crm.service.SalesOpportunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SalesOpportunityServiceImpl implements SalesOpportunityService {
    
    @Autowired
    private SalesOpportunityDao opportunityDao;

    @Autowired
    private SalesOrderDao salesOrderDao;

    @Override
    public List<SalesOpportunity> getAllOpportunities() {
        return opportunityDao.findAll();
    }

    @Override
    public List<SalesOpportunity> searchOpportunities(Long customerId, String stage, String status) {
        return opportunityDao.findByCondition(customerId, stage, status);
    }

    @Override
    public SalesOpportunity getOpportunityById(Long id) {
        return opportunityDao.findById(id);
    }

    @Override
    public void saveOpportunity(SalesOpportunity opportunity) {
        if (opportunity.getId() == null) {
            opportunityDao.insert(opportunity);
        } else {
            opportunityDao.update(opportunity);
        }
    }

    @Override
    public void updateOpportunity(SalesOpportunity opportunity) {
        opportunityDao.update(opportunity);
    }

    @Override
    public void deleteOpportunity(Long id) {
        // 先检查是否有关联的订单
        List<SalesOrder> orders = salesOrderDao.findByOpportunityId(id);
        if (!orders.isEmpty()) {
            throw new RuntimeException("该销售机会已有关联的订单，无法删除");
        }
        
        // 如果没有关联订单，则可以安全删除
        opportunityDao.deleteById(id);
    }

    @Override
    public void updateOpportunityStatus(Long id, String status) {
        opportunityDao.updateStatus(id, status);
    }

    @Override
    public List<SalesOpportunity> getOpportunitiesByCustomer(Long customerId) {
        return opportunityDao.findByCustomerId(customerId);
    }

    @Override
    public int getOpportunityCount() {
        return opportunityDao.getOpportunityCount();
    }

    @Override
    public List<Map<String, Object>> getOpportunityStageStats() {
        return opportunityDao.countByStage();
    }

    @Override
    public int getNewOpportunityCount() {
        return opportunityDao.getNewOpportunityCount();
    }
} 