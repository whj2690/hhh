<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录 - CRM系统</title>
    <!-- 先加载jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- 再加载Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- CSS文件放在后面 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background: #f5f6fa;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }

        .login-container {
            background: #fff;
            width: 100%;
            max-width: 400px;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
            box-sizing: border-box;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h1 {
            color: #2d3436;
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #636e72;
            font-size: 0.875rem;
            margin: 0;
        }

        .form-group {
            margin-bottom: 1.5rem;
            width: 100%;
        }

        .form-group label {
            display: block;
            color: #2d3436;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.75rem;
            font-size: 0.875rem;
            line-height: 1.5;
            color: #2d3436;
            background-color: #fff;
            border: 1px solid #dfe6e9;
            border-radius: 5px;
            transition: all 0.2s ease-in-out;
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: #4834d4;
            box-shadow: 0 0 0 3px rgba(72, 52, 212, 0.1);
            outline: none;
        }

        .input-group {
            position: relative;
            width: 100%;
        }

        .input-group-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #b2bec3;
            width: 1rem;
            text-align: center;
            z-index: 1;
        }

        .btn-login {
            display: block;
            width: 100%;
            padding: 0.75rem 1rem;
            font-size: 0.875rem;
            font-weight: 500;
            text-align: center;
            color: #fff;
            background: #4834d4;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }

        .btn-login:hover {
            background: #3c2bb0;
            transform: translateY(-1px);
        }

        .btn-login:active {
            transform: translateY(1px);
        }

        .btn-login:disabled {
            background: #6c5ce7;
            cursor: not-allowed;
            transform: none;
        }

        .btn-login i {
            margin-right: 0.5rem;
        }

        @media (max-width: 576px) {
            .login-container {
                margin: 1rem;
                width: calc(100% - 2rem);
            }
        }

        .alert {
            padding: 0.75rem 1.25rem;
            margin-bottom: 1rem;
            border: 1px solid transparent;
            border-radius: 5px;
            display: none;
        }

        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }

        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>CRM系统</h1>
            <p>请登录您的账户</p>
        </div>
        <div id="alertBox" class="alert" role="alert"></div>
        <form id="loginForm" method="post" onsubmit="return false;">
            <div class="form-group">
                <label for="username">用户名</label>
                <div class="input-group">
                    <i class="fas fa-user input-group-icon"></i>
                    <input type="text" class="form-control" id="username" name="username" 
                           placeholder="请输入用户名" required autocomplete="off">
                </div>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <div class="input-group">
                    <i class="fas fa-lock input-group-icon"></i>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="请输入密码" required>
                </div>
            </div>
            <button type="submit" class="btn-login">
                <i class="fas fa-sign-in-alt"></i>
                <span>登录</span>
            </button>
        </form>
    </div>

    <script>
    // 确保jQuery加载完成
    $(document).ready(function() {
        // 显示提示信息的函数
        function showAlert(message, type = 'danger') {
            const $alert = $('#alertBox');
            $alert.removeClass('alert-danger alert-success')
                  .addClass('alert-' + type)
                  .html(message)
                  .fadeIn();
            
            // 5秒后自动隐藏
            setTimeout(() => {
                $alert.fadeOut();
            }, 5000);
        }
        
        // 隐藏提示信息
        function hideAlert() {
            $('#alertBox').fadeOut();
        }
        
        // 重置按钮状态
        function resetButton() {
            const $btn = $('#loginForm').find('button[type="submit"]');
            const $icon = $btn.find('i');
            const $text = $btn.find('span');
            
            $btn.prop('disabled', false);
            $icon.removeClass('fa-spinner fa-spin').addClass('fa-sign-in-alt');
            $text.text('登录');
        }
        
        // 绑定表单提交事件
        $('#loginForm').submit(function(e) {
            e.preventDefault();
            
            const username = $('#username').val().trim();
            const password = $('#password').val().trim();
            
            // 表单验证
            if (!username) {
                showAlert('<i class="fas fa-exclamation-circle"></i> 请输入用户名');
                $('#username').focus();
                return false;
            }
            if (!password) {
                showAlert('<i class="fas fa-exclamation-circle"></i> 请输入密码');
                $('#password').focus();
                return false;
            }
            
            // 隐藏之前的提示
            hideAlert();
            
            // 禁用提交按钮，显示加载状态
            const $btn = $(this).find('button[type="submit"]');
            const $icon = $btn.find('i');
            const $text = $btn.find('span');
            
            $btn.prop('disabled', true);
            $icon.removeClass('fa-sign-in-alt').addClass('fa-spinner fa-spin');
            $text.text('登录中...');
            
            // 发送AJAX请求
            $.ajax({
                url: '${pageContext.request.contextPath}/login',
                type: 'POST',
                data: {
                    username: username,
                    password: password
                },
                success: function(response) {
                    console.log('登录响应:', response);
                    
                    if (response.success) {
                        // 登录成功，显示成功提示
                        showAlert('<i class="fas fa-check-circle"></i> 登录成功，正在跳转...', 'success');
                        // 延迟跳转，让用户看到成功提示
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}' + response.redirect;
                        }, 1000);
                    } else {
                        // 登录失败，显示错误信息
                        showAlert('<i class="fas fa-exclamation-circle"></i> ' + 
                                (response.message || '登录失败，请检查用户名和密码'));
                        resetButton();
                        $('#password').val('').focus();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('登录请求失败:', {
                        status: status,
                        error: error,
                        response: xhr.responseText
                    });
                    showAlert('<i class="fas fa-times-circle"></i> 系统错误，请稍后重试');
                    resetButton();
                }
            });
            
            return false;
        });
    });
    </script>
</body>
</html> 