package com.crm.controller;

import com.crm.entity.SalesOpportunity;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import com.crm.service.SalesOpportunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales/opportunity")
public class SalesOpportunityController {
    
    @Autowired
    private SalesOpportunityService opportunityService;
    
    @Autowired
    private CustomerService customerService;

    @GetMapping("/list")
    public String list(Model model) {
        List<SalesOpportunity> opportunities = opportunityService.getAllOpportunities();
        model.addAttribute("opportunities", opportunities);
        return "sales/opportunity/list";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) Long customerId,
                        @RequestParam(required = false) String stage,
                        @RequestParam(required = false) String status,
                        Model model) {
        List<SalesOpportunity> opportunities = opportunityService.searchOpportunities(customerId, stage, status);
        model.addAttribute("opportunities", opportunities);
        return "sales/opportunity/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("customers", customerService.getAllCustomers());
        return "sales/opportunity/add";
    }

    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody SalesOpportunity opportunity, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 设置创建人
            User user = (User) session.getAttribute("user");
            opportunity.setCreateUserId(user.getId());
            
            // 设置默认状态
            opportunity.setStatus("OPEN");
            
            // 保存机会信息
            opportunityService.saveOpportunity(opportunity);
            
            result.put("success", true);
            result.put("message", "销售机会添加成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "销售机会添加失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        // 添加阶段选项
        String[] stages = {"初步接触", "需求确定", "方案制定", "商务谈判", "成交"};
        model.addAttribute("stages", stages);
        
        // 添加客户列表和机会信息
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("opportunity", opportunityService.getOpportunityById(id));
        return "sales/opportunity/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public Map<String, Object> edit(@RequestBody SalesOpportunity opportunity) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 获取原有机会信息
            SalesOpportunity existingOpportunity = opportunityService.getOpportunityById(opportunity.getId());
            
            // 保持原有状态不变
            opportunity.setStatus(existingOpportunity.getStatus());
            
            // 更新机会信息
            opportunityService.updateOpportunity(opportunity);
            
            result.put("success", true);
            result.put("message", "销售机会更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "销售机会更新失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        try {
            opportunityService.deleteOpportunity(id);
            result.put("success", true);
            result.put("message", "销售机会删除成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "销售机会删除失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/status/{id}")
    @ResponseBody
    public Map<String, Object> updateStatus(@PathVariable Long id, @RequestParam String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            opportunityService.updateOpportunityStatus(id, status);
            result.put("success", true);
            result.put("message", "销售机会状态更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "销售机会状态更新失败：" + e.getMessage());
        }
        return result;
    }
} 