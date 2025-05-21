<%@page import="com.webshoes.beans.Message"%>
<%@page import="com.webshoes.dao.UserDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("Bạn chưa đăng nhập! Đăng nhập trước!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f7f9fc;
        }

        h2 {
            font-weight: bold;
            color: #34495e;
            text-align: center;
            margin: 30px 0;
        }

        .container-fluid {
            padding: 30px;
        }

        /* Card Layout for Users */
        .user-card {
            border-radius: 15px;
            background-color: #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }

        .user-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .user-card .card-header {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 18px;
        }

        .user-card .card-body {
            padding: 20px;
            text-align: left;
        }

        .user-info {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .user-info strong {
            font-weight: bold;
            color: #34495e;
        }

        .user-action {
            text-align: right;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .user-card {
                margin-bottom: 20px;
            }

            .user-info {
                font-size: 14px;
            }

            .btn-delete {
                font-size: 12px;
                padding: 6px 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- User Management Section -->
    <div class="container-fluid">
        <h2>Danh sách người dùng</h2>
        <div class="row">
            <% 
                UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                List<User> userList = userDao.getAllUser();
                for (User u : userList) { 
            %>
            <div class="col-md-4 mb-4">
                <div class="user-card">
                    <div class="card-header">
                        <%=u.getUserName()%>
                    </div>
                    <div class="card-body">
                        <div class="user-info">
                            <strong>Email:</strong> <%=u.getUserEmail()%>
                        </div>
                        <div class="user-info">
                            <strong>Số điện thoại:</strong> <%=u.getUserPhone()%>
                        </div>
                        <div class="user-info">
                            <strong>Giới tính:</strong> <%=u.getUserGender()%>
                        </div>
                        <div class="user-info">
                            <strong>Địa chỉ:</strong> <%=userDao.getUserAddress(u.getUserId())%>
                        </div>
                        <div class="user-info">
                            <strong>Ngày đăng ký:</strong> <%=u.getDateTime()%>
                        </div>
                        <div class="user-action">
                            <a href="UpdateUserServlet?operation=deleteUser&uid=<%=u.getUserId()%>" class="btn-delete">Xóa</a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>
