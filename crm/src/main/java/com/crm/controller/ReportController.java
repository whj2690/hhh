package com.crm.controller;

import com.crm.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/report")
public class ReportController {
    
    @Autowired
    private ReportService reportService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        // 获取各项统计数据
        model.addAttribute("customerStats", reportService.getCustomerStats());
        model.addAttribute("opportunityStats", reportService.getOpportunityStats());
        model.addAttribute("orderStats", reportService.getOrderStats());
        model.addAttribute("serviceStats", reportService.getServiceStats());
        return "report/dashboard";
    }

    @GetMapping("/sales")
    public String sales() {
        return "report/sales";
    }

    @GetMapping("/service")
    public String service() {
        return "report/service";
    }

    @GetMapping("/monthly-sales")
    @ResponseBody
    public List<Map<String, Object>> getMonthlySales() {
        return reportService.getMonthlySales();
    }

    @GetMapping("/sales-by-customer-type")
    @ResponseBody
    public List<Map<String, Object>> getSalesByCustomerType() {
        return reportService.getSalesByCustomerType();
    }

    @GetMapping("/sales-by-product-type")
    @ResponseBody
    public List<Map<String, Object>> getSalesByProductType() {
        return reportService.getSalesByProductType();
    }

    @GetMapping("/service-satisfaction")
    @ResponseBody
    public Map<String, Integer> getServiceSatisfactionStats() {
        return reportService.getServiceSatisfactionStats();
    }
} 