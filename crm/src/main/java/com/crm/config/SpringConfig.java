package com.crm.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@ComponentScan(basePackages = {
    "com.crm.service",
    "com.crm.service.impl",
    "com.crm.dao"
})
@Import({MyBatisConfig.class})
public class SpringConfig {
    // Spring配置
} 