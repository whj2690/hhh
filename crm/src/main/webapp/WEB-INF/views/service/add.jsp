<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>新建服务工单 - CRM系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .form-card {
            background: #fff;
            border-radius: 0.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 0 20px rgba(1, 41, 112, 0.08);
        }
        .form-label {
            font-weight: 600;
            color: #444;
            margin-bottom: 8px;
        }
        .required::after {
            content: "*";
            color: #dc3545;
            margin-left: 4px;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">新建服务工单</h5>
                <button class="btn btn-secondary" onclick="history.back()">
                    <i class="fas fa-arrow-left"></i> 返回列表
                </button>
            </div>
            <div class="card-body">
                <div class="form-card">
                    <form id="addForm" class="needs-validation" novalidate>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label required">选择客户</label>
                                <select class="form-select" id="customerId" name="customerId" required>
                                    <option value="">请选择客户</option>
                                </select>
                                <div class="invalid-feedback">请选择客户</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">服务类型</label>
                                <select class="form-select" id="type" name="type" required>
                                    <option value="">请选择类型</option>
                                    <option value="咨询">咨询</option>
                                    <option value="投诉">投诉</option>
                                    <option value="建议">建议</option>
                                </select>
                                <div class="invalid-feedback">请选择服务类型</div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label required">工单标题</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                            <div class="invalid-feedback">请输入工单标题</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label required">工单内容</label>
                            <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                            <div class="invalid-feedback">请输入工单内容</div>
                        </div>
                        <div class="d-flex justify-content-center gap-3">
                            <button type="button" class="btn btn-secondary" onclick="history.back()">
                                取消
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check"></i> 提交工单
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 加载客户列表（用原生JS，兼容所有环境）
        $(function() {
            $.get('/crm/customer/list/simple', function(data) {
                alert('客户数据：' + JSON.stringify(data)); // 调试用
                var select = document.getElementById('customerId');
                // 先清空除第一个option外的所有选项
                while (select.options.length > 1) {
                    select.remove(1);
                }
                data.forEach(function(customer) {
                    var opt = document.createElement('option');
                    opt.value = customer.id;
                    opt.text = customer.name;
                    select.appendChild(opt);
                });
            });
        });
        // 表单验证和提交
        (function() {
            const form = document.getElementById('addForm');
            form.addEventListener('submit', function(event) {
                event.preventDefault();
                if (!form.checkValidity()) {
                    event.stopPropagation();
                    form.classList.add('was-validated');
                    return;
                }
                const formData = {
                    customerId: $('#customerId').val(),
                    type: $('#type').val(),
                    title: $('#title').val().trim(),
                    content: $('#content').val().trim()
                };
                $.ajax({
                    url: '${pageContext.request.contextPath}/service/add',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        if (response.success) {
                            alert('工单创建成功');
                            location.href = '${pageContext.request.contextPath}/service/list';
                        } else {
                            alert(response.message || '创建失败，请重试');
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试');
                    }
                });
            });
        })();
    </script>
</body>
</html> 