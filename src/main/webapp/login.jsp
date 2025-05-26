<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }

    label {
        font-weight: bold;
    }

    .btn-outline-primary {
        background-color: white;
        color: #33cccc;
        border: 2px solid #33cccc;
        padding: 10px 20px;
        font-size: 16px;
    }

    .btn-outline-primary:hover {
        background-color: #33cccc;
        color: white;
        transition: all 0.3s ease;
    }

    .login-container {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        padding: 20px;
    }

    .login-card {
        display: flex;
        width: 80%;
        max-width: 1100px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        border-radius: 15px;
        overflow: hidden;
        background-color: #ffffff;
    }

    .illustration {
        background: linear-gradient(to bottom right, #33cccc, #00aaff);
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ffffff;
        padding: 30px;
    }

    .illustration img {
        max-width: 80%;
        object-fit: contain;
        border-radius: 10px;
    }

    .form-section {
        flex: 1;
        padding: 3rem;
    }

    h3 {
        font-weight: bold;
        color: #33cccc;
        margin-bottom: 1.5rem;
        text-align: center;
    }

    .form-control {
        padding: 15px;
        font-size: 16px;
        border: 1px solid #ddd;
        border-radius: 10px;
        transition: border 0.3s ease;
    }

    .form-control:focus {
        border-color: #33cccc;
        box-shadow: 0 0 5px rgba(51, 204, 204, 0.5);
    }

    .forgot-password {
        font-size: 14px;
        margin-top: 10px;
        text-align: center;
    }

    .forgot-password a {
        text-decoration: none;
        color: #33cccc;
    }

    .forgot-password a:hover {
        text-decoration: underline;
        color: #007bff;
    }
</style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Login Section -->
    <div class="login-container">
        <div class="login-card">
            <!-- Illustration Section -->
            <div class="illustration">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMa6iXnGEqoX-4O7C-j1yly_Lq4OJCuqGHPw&s" alt="Login Illustration">
            </div>
            <!-- Form Section -->
            <div class="form-section">
                <h3>Đăng nhập</h3>
                <%@include file="Components/alert_message.jsp" %>
                <form id="login-form" action="LoginServlet" method="post">
                    <input type="hidden" name="login" value="user">
                    <div class="mb-4">
                        <label class="form-label">Email</label>
                        <input type="email" name="user_email" placeholder="Nhập địa chỉ Email"
                               class="form-control" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Mật khẩu</label>
                        <input type="password" name="user_password" placeholder="Nhập mật khẩu"
                               class="form-control" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-outline-primary">Đăng nhập</button>
                    </div>
                </form>
                <div class="forgot-password">
                    <h6><a href="forgot_password.jsp">Quên mật khẩu?</a></h6>
                    <h6>
                        Bạn chưa có tài khoản?
                        <a href="register.jsp">Đăng ký ngay</a>
                    </h6>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
