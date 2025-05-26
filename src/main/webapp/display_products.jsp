<%@page import="com.webshoes.beans.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page errorPage="error_exception.jsp"%>
<%@page import="com.webshoes.dao.UserDao"%>
<%@page import="com.webshoes.beans.Product"%>
<%@page import="com.webshoes.dao.ProductDao"%>
<%
    Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
    if (activeAdmin == null) {
        Message message = new Message("Bạn chưa đăng nhập! Đăng nhập trước!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("adminlogin.jsp");
        return;
    }
    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
        }

        .container {
            padding: 30px;
        }

        h2 {
            font-weight: bold;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Card Layout for Products */
        .product-card {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .product-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-body {
            padding: 20px;
            text-align: center;
        }

        .product-name {
            font-size: 18px;
            font-weight: bold;
            color: #34495e;
            margin-bottom: 10px;
        }

        .product-category {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 15px;
        }

        .product-price {
            font-size: 16px;
            color: #27ae60;
            font-weight: bold;
        }

        .product-discount {
            font-size: 14px;
            color: #e74c3c;
            margin-left: 5px;
        }

        .product-actions {
            margin-top: 20px;
        }

        .product-actions a {
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            padding: 8px 15px;
            border-radius: 5px;
            margin-right: 10px;
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
            .product-card img {
                height: 150px;
            }

            .product-name {
                font-size: 16px;
            }

            .product-price {
                font-size: 14px;
            }

            .product-actions a {
                font-size: 12px;
                padding: 6px 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Product List -->
    <div class="container">
        <h2>Danh sách sản phẩm</h2>
        <%@include file="Components/alert_message.jsp"%>
        <div class="row">
            <% 
                List<Product> productList = productDao.getAllProducts();
                for (Product prod : productList) {
                    String category = catDao.getCategoryName(prod.getCategoryId());
            %>
            <div class="col-md-4 mb-4">
                <div class="product-card">
                    <!-- Product Image -->
                    <img src="Product_imgs/<%=prod.getProductImages()%>" alt="<%=prod.getProductName()%>">

                    <!-- Product Details -->
                    <div class="product-body">
                        <h3 class="product-name"><%=prod.getProductName()%></h3>
                        <p class="product-category">Danh mục: <%=category%></p>
                        <p>
                            <span class="product-price"><%=prod.getProductPriceAfterDiscount()%>&#8363;</span>
                            <span class="product-discount">-<%=prod.getProductDiscount()%>%</span>
                        </p>
                        <p class="product-stock">Số lượng: <%=prod.getProductQunatity()%></p>
                    </div>

                    <!-- Actions -->
                    <div class="product-actions text-center">
                        <a href="update_product.jsp?pid=<%=prod.getProductId()%>" class="btn-update">Cập nhật</a>
                        <a href="AddOperationServlet?pid=<%=prod.getProductId()%>&operation=deleteProduct" class="btn-delete">Xóa</a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>
