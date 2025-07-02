<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>编辑服务 - CRM系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
    <style>
        .required::after {
            content: "*";
            color: red;
            margin-left: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card mt-3">
            <div class="card-header">
                <h3>编辑服务</h3>
            </div>
            <div class="card-body">
                <form id="editForm">
                    <input type="hidden" id="serviceId" value="${service.id}">
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="customerId" class="required">选择客户</label>
                                <select class="form-control" id="customerId" name="customerId" required>
                                    <option value="">请选择</option>
                                    <c:forEach items="${customers}" var="customer">
                                        <option value="${customer.id}" ${service.customerId == customer.id ? 'selected' : ''}>
                                            ${customer.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="type" class="required">服务类型</label>
                                <select class="form-control" id="type" name="type" required>
                                    <option value="">请选择</option>
                                    <option value="咨询" ${service.type == '咨询' ? 'selected' : ''}>咨询</option>
                                    <option value="投诉" ${service.type == '投诉' ? 'selected' : ''}>投诉</option>
                                    <option value="建议" ${service.type == '建议' ? 'selected' : ''}>建议</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="title" class="required">服务标题</label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       value="${service.title}" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="content" class="required">服务内容</label>
                                <textarea class="form-control" id="content" name="content" 
                                          rows="5" required>${service.content}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-save"></i> 保存
                        </button>
                        <a href="${pageContext.request.contextPath}/service/list" class="btn btn-secondary">
                            <i class="fa fa-times"></i> 取消
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
        $(function() {
            $('#editForm').on('submit', function(e) {
                e.preventDefault();
                
                // 收集表单数据
                const formData = {
                    id: $('#serviceId').val(),
                    customerId: $('#customerId').val(),
                    type: $('#type').val(),
                    title: $('#title').val(),
                    content: $('#content').val()
                };

                // 发送请求
                $.ajax({
                    url: '${pageContext.request.contextPath}/service/edit',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        if (response.success) {
                            alert('保存成功');
                            location.href = '${pageContext.request.contextPath}/service/list';
                        } else {
                            alert(response.message || '保存失败');
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