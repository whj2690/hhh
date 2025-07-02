<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>CRM系统 - 管理控制台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        /* 侧边栏样式 */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background: #2c3e50;
            padding-top: 1rem;
            transition: all 0.3s;
        }
        
        .sidebar-header {
            padding: 1rem;
            text-align: center;
            border-bottom: 1px solid #34495e;
        }
        
        .sidebar-header h3 {
            color: #fff;
            margin: 0;
            font-size: 1.5rem;
        }
        
        .sidebar-menu {
            padding: 1rem 0;
        }
        
        .menu-item {
            padding: 0.75rem 1.5rem;
            color: #bdc3c7;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        
        .menu-item:hover {
            color: #fff;
            background: #34495e;
        }
        
        .menu-item.active {
            color: #fff;
            background: #3498db;
        }
        
        .menu-item i {
            width: 20px;
            margin-right: 10px;
        }
        
        /* 主内容区域样式 */
        .main-content {
            margin-left: 250px;
            padding: 1rem;
        }
        
        /* 顶部导航栏样式 */
        .top-nav {
            background: #fff;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .user-info {
            display: flex;
            align-items: center;
        }
        
        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        /* 仪表盘卡片样式 */
        .dashboard-card {
            background: #fff;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .dashboard-card h4 {
            margin: 0 0 1rem 0;
            color: #2c3e50;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #3498db;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 0.875rem;
        }
    </style>
</head>
<body class="bg-light">
    <!-- 侧边栏 -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3>CRM系统</h3>
        </div>
        <div class="sidebar-menu">
            <a href="#" class="menu-item active">
                <i class="fas fa-tachometer-alt"></i>
                仪表盘
            </a>
            <a href="${pageContext.request.contextPath}/customer/list" class="menu-item">
                <i class="fas fa-users"></i>
                客户管理
            </a>
            <a href="${pageContext.request.contextPath}/sales/opportunity/list" class="menu-item">
                <i class="fas fa-chart-line"></i>
                销售机会
            </a>
            <a href="${pageContext.request.contextPath}/sales/order/list" class="menu-item">
                <i class="fas fa-file-invoice-dollar"></i>
                订单管理
            </a>
            <a href="${pageContext.request.contextPath}/service/list" class="menu-item">
                <i class="fas fa-headset"></i>
                客户服务
            </a>

        </div>
    </div>

    <!-- 主内容区域 -->
    <div class="main-content">
        <!-- 顶部导航栏 -->
        <div class="top-nav">
            <div class="breadcrumb mb-0">
                <i class="fas fa-home"></i>
                <span class="ms-2">首页</span>
            </div>
            <div class="user-info">
<%--                <img src="https://via.placeholder.com/40" alt="用户头像">--%>
                <div class="ms-2">
                    <div class="fw-bold">${sessionScope.user.realName}</div>
                    <div class="text-muted small">${sessionScope.user.role}</div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm ms-3">
                    <i class="fas fa-sign-out-alt"></i>
                    退出
                </a>
            </div>
        </div>

        <!-- 仪表盘内容 -->
        <div class="container-fluid mt-4">
            <div class="row">
                <div class="col-md-3">
                    <div class="dashboard-card">
                        <h4>客户总数</h4>
                        <div class="stat-number">${customerStats.total}</div>
                        <div class="stat-label">暂无数据</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-card">
                        <h4>销售额</h4>
                        <div class="stat-number">¥${orderStats.monthlyAmount}</div>
                        <div class="stat-label">暂无数据</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-card">
                        <h4>待处理工单</h4>
                        <div class="stat-number">${serviceStats.pendingCount}</div>
                        <div class="stat-label">暂无数据</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-card">
                        <h4>销售机会</h4>
                        <div class="stat-number">${opportunityStats.total}</div>
                        <div class="stat-label">暂无数据</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 