<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>添加客户 - CRM系统</title>
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
        
        .form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
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
                    <i class="fas fa-plus-circle me-2"></i>添加新客户
                </h5>
            </div>
            <div class="card-body">
                <form id="customerForm" class="needs-validation" novalidate>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="name" class="form-label">客户名称</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                            <div class="invalid-feedback">
                                请输入客户名称
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="contact" class="form-label">联系人</label>
                            <input type="text" class="form-control" id="contact" name="contact" required>
                            <div class="invalid-feedback">
                                请输入联系人姓名
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="phone" class="form-label">联系电话</label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   pattern="^1[3-9]\d{9}$" required>
                            <div class="invalid-feedback">
                                请输入有效的手机号码
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">电子邮箱</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                            <div class="invalid-feedback">
                                请输入有效的电子邮箱地址
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">地址</label>
                        <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                        <div class="invalid-feedback">
                            请输入地址
                        </div>
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
            // 表单验证
            const form = document.getElementById('customerForm');
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
                    contact: $('#contact').val(),
                    phone: $('#phone').val(),
                    email: $('#email').val(),
                    address: $('#address').val()
                };
                
                // 发送AJAX请求
                $.ajax({
                    url: '${pageContext.request.contextPath}/customer/add',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        if (response.success) {
                            alert('客户添加成功');
                            window.location.href = '${pageContext.request.contextPath}/customer/list';
                        } else {
                            alert(response.message || '添加失败，请重试');
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试');
                    }
                });
            });
            
            // 手机号码实时验证
            $('#phone').on('input', function() {
                const phoneRegex = /^1[3-9]\d{9}$/;
                if (this.value && !phoneRegex.test(this.value)) {
                    this.setCustomValidity('请输入有效的手机号码');
                } else {
                    this.setCustomValidity('');
                }
            });
            
            // 邮箱实时验证
            $('#email').on('input', function() {
                if (this.value && !this.checkValidity()) {
                    this.setCustomValidity('请输入有效的电子邮箱地址');
                } else {
                    this.setCustomValidity('');
                }
            });
        });
    </script>
</body>
</html> 