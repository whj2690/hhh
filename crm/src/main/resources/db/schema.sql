-- 客户服务工单表
CREATE TABLE IF NOT EXISTS customer_service (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    type VARCHAR(50) NOT NULL COMMENT '服务类型：咨询、投诉、建议等',
    title VARCHAR(200) NOT NULL COMMENT '服务标题',
    content TEXT COMMENT '服务内容',
    status VARCHAR(50) NOT NULL DEFAULT '待处理' COMMENT '状态：待处理、处理中、已完成',
    handler VARCHAR(100) COMMENT '处理人',
    result TEXT COMMENT '处理结果',
    satisfaction INT COMMENT '客户满意度（1-5星）',
    create_user_id BIGINT NOT NULL COMMENT '创建人ID',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (create_user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户服务工单表'; 