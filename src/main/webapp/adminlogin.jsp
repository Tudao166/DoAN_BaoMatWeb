<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập Admin</title>
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
        font-size: 18px;
    }

    .btn-outline-primary:hover {
        background-color: #33cccc;
        border: #33cccc;
        color: white;
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
        max-width: 1200px;
        height: 500px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        border-radius: 15px;
        overflow: hidden;
    }

    .illustration {
        background-color: #e6f7f8;
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .illustration img {
        max-width: 90%;
        max-height: 90%;
        object-fit: contain;
    }

    .form-section {
        flex: 1;
        padding: 3rem;
        display: flex;
        flex-direction: column;
        justify-content: center;
        background-color: #ffffff;
    }

    h3 {
        font-weight: bold;
        color: #33cccc;
        margin-bottom: 1.5rem;
    }

    .form-control {
        padding: 15px;
        font-size: 16px;
    }

    .text-center button {
        width: 100%;
    }
</style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Login Section -->
    <div class="container-fluid login-container">
        <div class="login-card">
            <!-- Illustration Section -->
            <div class="illustration">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoaPLPMZE1sJX9Ik_FtKM8X1mwam4TnVBgjA&s" alt="Admin Login">
            </div>
            <!-- Login Form Section -->
            <div class="form-section">
                <h3 class="text-center">Đăng nhập Admin</h3>
                <%@include file="Components/alert_message.jsp"%>
                <form id="login-form" action="LoginServlet" method="post">
                    <input type="hidden" name="login" value="admin"> 
                    
                    <div class="mb-4">
                        <label class="form-label">Email</label> 
                        <input type="email" name="email" placeholder="Địa chỉ Email" class="form-control" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Mật khẩu</label> 
                        <input type="password" name="password" placeholder="Nhập mật khẩu" class="form-control" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-outline-primary">Đăng nhập</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
