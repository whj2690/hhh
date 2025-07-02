package com.crm.controller;

import com.crm.entity.User;
import com.crm.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class IndexController {
    
    @Autowired
    private ReportService reportService;

    @GetMapping("/")
    public String root() {
        return "redirect:/login";
    }

    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        // 注入统计数据
        model.addAttribute("customerStats", reportService.getCustomerStats());
        model.addAttribute("opportunityStats", reportService.getOpportunityStats());
        model.addAttribute("orderStats", reportService.getOrderStats());
        model.addAttribute("serviceStats", reportService.getServiceStats());
        return "index";
    }
} 