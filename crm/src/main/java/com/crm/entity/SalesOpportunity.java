package com.crm.entity;

import java.math.BigDecimal;
import java.util.Date;

public class SalesOpportunity {
    private Long id;
    private Long customerId;
    private String name;            // 机会名称
    private BigDecimal expectedAmount; // 预期金额
    private String stage;           // 阶段：初步接触、需求确定、方案制定、商务谈判、成交
    private Integer successRate;    // 成功率
    private Date expectedClosingDate; // 预计成交日期
    private String description;     // 描述
    private String status;          // 状态：进行中、已成交、已失败
    private Long createUserId;      // 创建人ID
    private Date createTime;        // 创建时间
    private Date updateTime;        // 更新时间
    
    // 关联对象
    private Customer customer;      // 关联的客户
    private User createUser;        // 创建人
    
    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getExpectedAmount() {
        return expectedAmount;
    }

    public void setExpectedAmount(BigDecimal expectedAmount) {
        this.expectedAmount = expectedAmount;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public Integer getSuccessRate() {
        return successRate;
    }

    public void setSuccessRate(Integer successRate) {
        this.successRate = successRate;
    }

    public Date getExpectedClosingDate() {
        return expectedClosingDate;
    }

    public void setExpectedClosingDate(Date expectedClosingDate) {
        this.expectedClosingDate = expectedClosingDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public User getCreateUser() {
        return createUser;
    }

    public void setCreateUser(User createUser) {
        this.createUser = createUser;
    }

    @Override
    public String toString() {
        return "SalesOpportunity{" +
                "id=" + id +
                ", customerId=" + customerId +
                ", name='" + name + '\'' +
                ", expectedAmount=" + expectedAmount +
                ", stage='" + stage + '\'' +
                ", successRate=" + successRate +
                ", expectedClosingDate=" + expectedClosingDate +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", createUserId=" + createUserId +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
} 