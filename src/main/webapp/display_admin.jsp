<%@page import="com.webshoes.dao.AdminDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("Bạn chưa đăng nhập!! Đăng nhập trước!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
AdminDao adminDao = new AdminDao(ConnectionProvider.getConnection());
List<Admin> adminList = adminDao.getAllAdmin();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Admin</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f7f9fc;
            margin: 0;
        }

        .container-fluid {
            padding: 30px;
        }

        h2 {
            font-weight: bold;
            color: #34495e;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Admin Form Section */
        .admin-form-card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .admin-form-card .card-header {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            padding: 15px;
            font-size: 18px;
            text-align: center;
        }

        .admin-form-card .card-body {
            padding: 20px;
        }

        .admin-form-card input[type="text"],
        .admin-form-card input[type="email"],
        .admin-form-card input[type="password"],
        .admin-form-card input[type="number"] {
            font-size: 14px;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .admin-form-card button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .admin-form-card button:hover {
            background-color: #2980b9;
        }

        /* Admin List Section */
        .admin-list-card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            overflow: hidden;
        }

        .admin-list-card .card-header {
            background-color: #34495e;
            color: white;
            padding: 15px;
            font-size: 18px;
            text-align: center;
        }

        .admin-list-card table {
            margin: 0;
            width: 100%;
        }

        .admin-list-card table th {
            background-color: #6a11cb;
            color: white;
            padding: 10px;
            font-size: 16px;
            text-align: center;
        }

        .admin-list-card table td {
            padding: 10px;
            font-size: 14px;
            text-align: center;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .admin-form-card,
            .admin-list-card {
                margin-bottom: 20px;
            }

            .admin-form-card button {
                font-size: 12px;
                padding: 8px 15px;
            }

            .admin-list-card table th,
            .admin-list-card table td {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Main Content -->
    <div class="container-fluid">
        <h2>Quản lý Admin</h2>
        <div class="row">
            <!-- Admin Form Section -->
            <div class="col-md-4">
                <div class="admin-form-card">
                    <div class="card-header">Thêm Admin</div>
                    <div class="card-body">
                        <%@include file="Components/alert_message.jsp"%>
                        <form action="AdminServlet?operation=save" method="post">
                            <input type="text" name="name" placeholder="Nhập tên" class="form-control" required>
                            <input type="email" name="email" placeholder="Nhập Email" class="form-control" required>
                            <input type="password" name="password" placeholder="Nhập mật khẩu" class="form-control" required>
                            <input type="number" name="phone" placeholder="Nhập số điện thoại" class="form-control" required>
                            <div class="text-center mt-3">
                                <button type="submit">Đăng ký</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Admin List Section -->
            <div class="col-md-8">
                <div class="admin-list-card">
                    <div class="card-header">Danh sách Admin</div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Tên</th>
                                    <th>Email</th>
                                    <th>Điện thoại</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Admin a : adminList) { %>
                                <tr>
                                    <td><%=a.getName()%></td>
                                    <td><%=a.getEmail()%></td>
                                    <td><%=a.getPhone()%></td>
                                    <td>
                                        <a href="AdminServlet?operation=delete&id=<%=a.getId()%>" class="btn-delete">Xóa</a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
