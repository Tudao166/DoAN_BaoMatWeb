<%@page import="com.webshoes.beans.Message"%>
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
    <title>Quản lý danh mục</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f7f9fc;
        }

        .container {
            margin-top: 30px;
        }

        h2 {
            font-weight: bold;
            color: #34495e;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Card Layout for Categories */
        .category-card {
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: #ffffff;
            overflow: hidden;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .category-image {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .category-body {
            padding: 15px;
            text-align: center;
        }

        .category-name {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .action-buttons a {
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-update {
            background-color: #3498db;
            color: white;
        }

        .btn-update:hover {
            background-color: #2980b9;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .category-card {
                margin-bottom: 20px;
            }

            .category-body {
                padding: 10px;
            }

            .category-name {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Category Section -->
    <div class="container">
        <%@include file="Components/alert_message.jsp"%>
        <h2>Danh mục sản phẩm</h2>
        <div class="row">
            <% for (Category c : categoryList) { %>
            <div class="col-md-4 mb-4">
                <div class="category-card">
                    <img src="Product_imgs/<%=c.getCategoryImage()%>" alt="<%=c.getCategoryName()%>" class="category-image">
                    <div class="category-body">
                        <h3 class="category-name"><%=c.getCategoryName()%></h3>
                        <div class="action-buttons">
                            <a href="update_category.jsp?cid=<%=c.getCategoryId()%>" class="btn-update">Cập nhật</a>
                            <a href="AddOperationServlet?cid=<%=c.getCategoryId()%>&operation=deleteCategory" class="btn-delete">Xóa</a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>
