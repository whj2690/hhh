<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>统计报表 - CRM系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
    <script src="${pageContext.request.contextPath}/static/js/echarts.min.js"></script>
    <style>
        .stats-card {
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 4px;
            color: white;
        }
        .stats-card.primary { background-color: #007bff; }
        .stats-card.success { background-color: #28a745; }
        .stats-card.warning { background-color: #ffc107; }
        .stats-card.danger { background-color: #dc3545; }
        .stats-card .number {
            font-size: 24px;
            font-weight: bold;
        }
        .stats-card .title {
            font-size: 16px;
            opacity: 0.8;
        }
        .chart-container {
            height: 400px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <h2 class="mt-3 mb-4">统计报表</h2>

        <!-- 统计卡片 -->
        <div class="row">
            <div class="col-md-3">
                <div class="stats-card primary">
                    <div class="number">${customerStats.total}</div>
                    <div class="title">客户总数</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card success">
                    <div class="number">${opportunityStats.total}</div>
                    <div class="title">销售机会</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card warning">
                    <div class="number">
                        <fmt:formatNumber value="${orderStats.totalAmount}" pattern="#,##0.00"/>
                    </div>
                    <div class="title">销售总额</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card danger">
                    <div class="number">${serviceStats.total}</div>
                    <div class="title">服务工单</div>
                </div>
            </div>
        </div>

        <!-- 图表区域 -->
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        月度销售额趋势
                    </div>
                    <div class="card-body">
                        <div id="monthlySalesChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        客户类型销售分布
                    </div>
                    <div class="card-body">
                        <div id="customerTypeSalesChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        产品类型销售分布
                    </div>
                    <div class="card-body">
                        <div id="productTypeSalesChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        服务满意度分布
                    </div>
                    <div class="card-body">
                        <div id="serviceSatisfactionChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
        $(function() {
            // 初始化图表
            initMonthlySalesChart();
            initCustomerTypeSalesChart();
            initProductTypeSalesChart();
            initServiceSatisfactionChart();
        });

        function initMonthlySalesChart() {
            $.get('${pageContext.request.contextPath}/report/monthly-sales', function(data) {
                const chart = echarts.init(document.getElementById('monthlySalesChart'));
                const option = {
                    tooltip: {
                        trigger: 'axis'
                    },
                    xAxis: {
                        type: 'category',
                        data: data.map(item => item.month)
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        data: data.map(item => item.amount),
                        type: 'line',
                        smooth: true
                    }]
                };
                chart.setOption(option);
            });
        }

        function initCustomerTypeSalesChart() {
            $.get('${pageContext.request.contextPath}/report/sales-by-customer-type', function(data) {
                const chart = echarts.init(document.getElementById('customerTypeSalesChart'));
                const option = {
                    tooltip: {
                        trigger: 'item'
                    },
                    series: [{
                        type: 'pie',
                        radius: '60%',
                        data: data.map(item => ({
                            name: item.type,
                            value: item.amount
                        }))
                    }]
                };
                chart.setOption(option);
            });
        }

        function initProductTypeSalesChart() {
            $.get('${pageContext.request.contextPath}/report/sales-by-product-type', function(data) {
                const chart = echarts.init(document.getElementById('productTypeSalesChart'));
                const option = {
                    tooltip: {
                        trigger: 'item'
                    },
                    series: [{
                        type: 'pie',
                        radius: '60%',
                        data: data.map(item => ({
                            name: item.type,
                            value: item.amount
                        }))
                    }]
                };
                chart.setOption(option);
            });
        }

        function initServiceSatisfactionChart() {
            $.get('${pageContext.request.contextPath}/report/service-satisfaction', function(data) {
                const chart = echarts.init(document.getElementById('serviceSatisfactionChart'));
                const option = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    xAxis: {
                        type: 'category',
                        data: ['1星', '2星', '3星', '4星', '5星']
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        data: [
                            data['1'] || 0,
                            data['2'] || 0,
                            data['3'] || 0,
                            data['4'] || 0,
                            data['5'] || 0
                        ],
                        type: 'bar'
                    }]
                };
                chart.setOption(option);
            });
        }
    </script>
</body>
</html> 