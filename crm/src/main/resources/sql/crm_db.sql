-- 创建数据库
CREATE DATABASE IF NOT EXISTS crm_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE crm_db;

-- 创建用户表
CREATE TABLE user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    real_name VARCHAR(50) COMMENT '真实姓名',
    email VARCHAR(100) COMMENT '邮箱',
    phone VARCHAR(20) COMMENT '电话',
    role VARCHAR(20) NOT NULL COMMENT '角色：ADMIN-管理员，SALES-销售，SERVICE-客服',
    status INT NOT NULL DEFAULT 1 COMMENT '状态：1-正常，0-禁用',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 创建客户表
CREATE TABLE customer (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '客户名称',
    contact VARCHAR(50) COMMENT '联系人',
    phone VARCHAR(20) COMMENT '联系电话',
    email VARCHAR(100) COMMENT '电子邮箱',
    address TEXT COMMENT '地址',
    industry VARCHAR(50) COMMENT '所属行业',
    level VARCHAR(20) COMMENT '客户级别：A、B、C、D',
    status INT NOT NULL DEFAULT 1 COMMENT '状态：1-正常，0-禁用',
    source VARCHAR(50) COMMENT '客户来源',
    create_user_id BIGINT COMMENT '创建人ID',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (create_user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户表';

-- 创建销售机会表
CREATE TABLE sales_opportunity (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    name VARCHAR(200) NOT NULL COMMENT '机会名称',
    expected_amount DECIMAL(12,2) COMMENT '预期金额',
    stage VARCHAR(50) NOT NULL COMMENT '阶段：初步接触、需求确定、方案制定、商务谈判、成交',
    success_rate INT COMMENT '成功率',
    expected_closing_date DATE COMMENT '预计成交日期',
    description TEXT COMMENT '描述',
    status VARCHAR(20) NOT NULL COMMENT '状态：进行中、已成交、已失败',
    create_user_id BIGINT NOT NULL COMMENT '创建人ID',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (create_user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售机会表';

-- 创建销售订单表
CREATE TABLE sales_order (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_no VARCHAR(50) NOT NULL UNIQUE COMMENT '订单编号',
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    opportunity_id BIGINT COMMENT '销售机会ID',
    amount DECIMAL(12,2) NOT NULL COMMENT '订单金额',
    status VARCHAR(20) NOT NULL COMMENT '订单状态：待审核、已审核、已发货、已完成、已取消',
    payment_status VARCHAR(20) NOT NULL COMMENT '付款状态：未付款、部分付款、已付款',
    delivery_date DATE COMMENT '交付日期',
    description TEXT COMMENT '订单描述',
    create_user_id BIGINT NOT NULL COMMENT '创建人ID',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (opportunity_id) REFERENCES sales_opportunity(id),
    FOREIGN KEY (create_user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售订单表';

-- 创建服务记录表
CREATE TABLE service_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    type VARCHAR(50) NOT NULL COMMENT '服务类型：咨询、投诉、建议等',
    status VARCHAR(50) NOT NULL COMMENT '状态：待处理、处理中、已完成、已关闭',
    title VARCHAR(200) NOT NULL COMMENT '服务标题',
    content TEXT NOT NULL COMMENT '服务内容',
    solution TEXT COMMENT '解决方案',
    satisfaction INT COMMENT '客户满意度(1-5)',
    create_user_id BIGINT NOT NULL COMMENT '创建人ID',
    handle_user_id BIGINT COMMENT '处理人ID',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    handle_time DATETIME COMMENT '处理时间',
    finish_time DATETIME COMMENT '完成时间',
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (create_user_id) REFERENCES user(id),
    FOREIGN KEY (handle_user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务记录表';

-- 添加索引
CREATE INDEX idx_customer_name ON customer(name);
CREATE INDEX idx_customer_phone ON customer(phone);
CREATE INDEX idx_customer_create_time ON customer(create_time);

CREATE INDEX idx_opportunity_customer_id ON sales_opportunity(customer_id);
CREATE INDEX idx_opportunity_create_time ON sales_opportunity(create_time);
CREATE INDEX idx_opportunity_stage ON sales_opportunity(stage);

CREATE INDEX idx_order_customer_id ON sales_order(customer_id);
CREATE INDEX idx_order_order_no ON sales_order(order_no);
CREATE INDEX idx_order_create_time ON sales_order(create_time);
CREATE INDEX idx_order_status ON sales_order(status);

CREATE INDEX idx_service_customer_id ON service_record(customer_id);
CREATE INDEX idx_service_create_user_id ON service_record(create_user_id);
CREATE INDEX idx_service_handle_user_id ON service_record(handle_user_id);
CREATE INDEX idx_service_create_time ON service_record(create_time);
CREATE INDEX idx_service_status ON service_record(status);

-- 插入初始管理员用户(密码: admin)
INSERT INTO user (username, password, real_name, role, status) 
VALUES ('admin', '21232f297a57a5a743894a0e4a801fc3', '系统管理员', 'ADMIN', 1);