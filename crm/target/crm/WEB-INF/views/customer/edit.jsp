<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>编辑客户 - CRM系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f8fa;
        }
        
        .card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
            border: none;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }
        
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #edf2f7;
            padding: 1.5rem;
        }
        
        .card-header h3 {
            margin: 0;
            color: #2d3748;
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            color: #4a5568;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        
        .form-control {
            border-radius: 0.5rem;
            border: 1px solid #e2e8f0;
            padding: 0.75rem 1rem;
            transition: all 0.2s;
        }
        
        .form-control:focus {
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }
        
        .form-select {
            border-radius: 0.5rem;
            border: 1px solid #e2e8f0;
            padding: 0.75rem 1rem;
        }
        
        .required::after {
            content: "*";
            color: #e53e3e;
            margin-left: 4px;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            border-radius: 0.5rem;
            transition: all 0.2s;
        }
        
        .btn-primary {
            background-color: #4299e1;
            border-color: #4299e1;
        }
        
        .btn-primary:hover {
            background-color: #3182ce;
            border-color: #3182ce;
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background-color: #718096;
            border-color: #718096;
        }
        
        .btn-secondary:hover {
            background-color: #4a5568;
            border-color: #4a5568;
            transform: translateY(-1px);
        }
        
        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #edf2f7;
        }
        
        .form-buttons .btn i {
            margin-right: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .form-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .form-buttons .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-edit me-2"></i>编辑客户信息</h3>
            </div>
            <div class="card-body">
                <form id="editForm">
                    <input type="hidden" id="customerId" value="${customer.id}">
                    
                    <!-- 基本信息 -->
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="name" class="form-label required">客户名称</label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       value="${customer.name}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="contact" class="form-label">联系人</label>
                                <input type="text" class="form-control" id="contact" 
                                       name="contact" value="${customer.contact}">
                            </div>
                        </div>
                    </div>

                    <!-- 联系方式 -->
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="phone" class="form-label">联系电话</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                    <input type="tel" class="form-control" id="phone" 
                                           name="phone" value="${customer.phone}">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email" class="form-label">电子邮箱</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" class="form-control" id="email" 
                                           name="email" value="${customer.email}">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 客户信息 -->
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="level" class="form-label required">客户级别</label>
                                <select class="form-select" id="level" name="level" required>
                                    <option value="">请选择</option>
                                    <option value="A" ${customer.level == 'A' ? 'selected' : ''}>A级</option>
                                    <option value="B" ${customer.level == 'B' ? 'selected' : ''}>B级</option>
                                    <option value="C" ${customer.level == 'C' ? 'selected' : ''}>C级</option>
                                    <option value="D" ${customer.level == 'D' ? 'selected' : ''}>D级</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="industry" class="form-label">所属行业</label>
                                <input type="text" class="form-control" id="industry" 
                                       name="industry" value="${customer.industry}">
                            </div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="source" class="form-label">客户来源</label>
                                <input type="text" class="form-control" id="source" 
                                       name="source" value="${customer.source}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="status" class="form-label required">状态</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="1" ${customer.status == 1 ? 'selected' : ''}>正常</option>
                                    <option value="0" ${customer.status == 0 ? 'selected' : ''}>禁用</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address" class="form-label">详细地址</label>
                        <textarea class="form-control" id="address" name="address" 
                                rows="3">${customer.address}</textarea>
                    </div>

                    <div class="form-buttons">
                        <button type="button" class="btn btn-secondary" onclick="history.back()">
                            <i class="fas fa-arrow-left"></i> 返回
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> 保存修改
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(function() {
            // 表单验证和提交
            $('#editForm').on('submit', function(e) {
                e.preventDefault();
                
                // 收集表单数据
                const formData = {
                    id: $('#customerId').val(),
                    name: $('#name').val().trim(),
                    contact: $('#contact').val().trim(),
                    phone: $('#phone').val().trim(),
                    email: $('#email').val().trim(),
                    level: $('#level').val(),
                    industry: $('#industry').val().trim(),
                    source: $('#source').val().trim(),
                    status: $('#status').val(),
                    address: $('#address').val().trim()
                };

                // 发送请求
                $.ajax({
                    url: '${pageContext.request.contextPath}/customer/edit',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    beforeSend: function() {
                        // 禁用提交按钮，显示加载状态
                        $('button[type="submit"]')
                            .prop('disabled', true)
                            .html('<i class="fas fa-spinner fa-spin"></i> 保存中...');
                    },
                    success: function(response) {
                        if (response.success) {
                            alert('保存成功');
                            location.href = '${pageContext.request.contextPath}/customer/list';
                        } else {
                            alert(response.message || '保存失败');
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试');
                    },
                    complete: function() {
                        // 恢复提交按钮状态
                        $('button[type="submit"]')
                            .prop('disabled', false)
                            .html('<i class="fas fa-save"></i> 保存修改');
                    }
                });
            });
        });
    </script>
</body>
</html> 