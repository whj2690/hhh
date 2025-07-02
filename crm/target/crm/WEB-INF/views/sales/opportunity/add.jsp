<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>添加销售机会 - CRM系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 800px;
            margin: 2rem auto;
        }
        .card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .btn-toolbar {
            gap: 0.5rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="form-container">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-plus-circle me-2"></i>添加销售机会
                </h5>
            </div>
            <div class="card-body">
                <form id="opportunityForm" class="needs-validation" novalidate>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="name" class="form-label">机会名称</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                            <div class="invalid-feedback">请输入机会名称</div>
                        </div>
                        <div class="col-md-6">
                            <label for="customerId" class="form-label">选择客户</label>
                            <select class="form-select" id="customerId" name="customerId" required>
                                <option value="">请选择客户</option>
                                <c:forEach items="${customers}" var="customer">
                                    <option value="${customer.id}">${customer.name}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">请选择客户</div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="expectedAmount" class="form-label">预期金额</label>
                            <div class="input-group">
                                <span class="input-group-text">￥</span>
                                <input type="number" class="form-control" id="expectedAmount" name="expectedAmount" 
                                       step="0.01" min="0" required>
                                <div class="invalid-feedback">请输入有效的金额</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="stage" class="form-label">当前阶段</label>
                            <select class="form-select" id="stage" name="stage" required>
                                <option value="">请选择阶段</option>
                                <option value="初步接触">初步接触</option>
                                <option value="需求确定">需求确定</option>
                                <option value="方案制定">方案制定</option>
                                <option value="商务谈判">商务谈判</option>
                                <option value="成交">成交</option>
                            </select>
                            <div class="invalid-feedback">请选择当前阶段</div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="successRate" class="form-label">成功率</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="successRate" name="successRate" 
                                       min="0" max="100" required>
                                <span class="input-group-text">%</span>
                                <div class="invalid-feedback">请输入0-100之间的数字</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="expectedClosingDate" class="form-label">预计成交日期</label>
                            <input type="date" class="form-control" id="expectedClosingDate" name="expectedClosingDate" required>
                            <div class="invalid-feedback">请选择预计成交日期</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">机会描述</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                        <div class="invalid-feedback">请输入机会描述</div>
                    </div>

                    <div class="btn-toolbar justify-content-end">
                        <button type="button" class="btn btn-secondary" onclick="history.back()">
                            <i class="fas fa-arrow-left me-1"></i>返回
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>保存
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
            // 根据阶段自动设置成功率
            $('#stage').on('change', function() {
                const stageRates = {
                    '初步接触': 10,
                    '需求确定': 30,
                    '方案制定': 50,
                    '商务谈判': 80,
                    '成交': 100
                };
                const stage = $(this).val();
                if (stage) {
                    $('#successRate').val(stageRates[stage]);
                }
            });

            // 表单验证和提交
            const form = document.getElementById('opportunityForm');
            form.addEventListener('submit', function(event) {
                event.preventDefault();
                
                if (!form.checkValidity()) {
                    event.stopPropagation();
                    form.classList.add('was-validated');
                    return;
                }
                
                // 收集表单数据
                const formData = {
                    name: $('#name').val(),
                    customerId: $('#customerId').val(),
                    expectedAmount: $('#expectedAmount').val(),
                    stage: $('#stage').val(),
                    successRate: $('#successRate').val(),
                    expectedClosingDate: $('#expectedClosingDate').val(),
                    description: $('#description').val()
                };
                
                // 发送AJAX请求
                $.ajax({
                    url: '${pageContext.request.contextPath}/sales/opportunity/add',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        if (response.success) {
                            alert('销售机会添加成功');
                            window.location.href = '${pageContext.request.contextPath}/sales/opportunity/list';
                        } else {
                            alert(response.message || '添加失败，请重试');
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试');
                    }
                });
            });
        });
    </script>
</body>
</html> 