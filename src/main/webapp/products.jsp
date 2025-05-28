<%@page import="com.webshoes.dao.WishlistDao"%>
<%@page import="com.webshoes.beans.User"%>
<%@page import="com.webshoes.dao.CategoryDao"%>
<%@page import="com.webshoes.beans.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.webshoes.helper.ConnectionProvider"%>
<%@page import="com.webshoes.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%!
    public static String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
%>

<%
    User u = (User) session.getAttribute("activeUser");
    WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());

    String searchKey = request.getParameter("search");
    String catId = request.getParameter("category");
    CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
    String message = "";

    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
    List<Product> prodList = null;

    try {
        if (searchKey != null && !searchKey.trim().isEmpty()) {
            message = "Hiển thị kết quả cho \"" + escapeHtml(searchKey) + "\"";
            prodList = productDao.getAllProductsBySearchKey(searchKey);
        } else if (catId != null && catId.trim().matches("\\d+") && !catId.trim().equals("0")) {
            int parsedCatId = Integer.parseInt(catId.trim());
            String catName = categoryDao.getCategoryName(parsedCatId);
            message = "Hiển thị kết quả cho \"" + escapeHtml(catName) + "\"";
            prodList = productDao.getAllProductsByCategoryId(parsedCatId);
        } else {
            prodList = productDao.getAllProducts();
            message = "Tất cả hàng hóa";
        }

        if (prodList != null && prodList.isEmpty()) {
            String fallback = searchKey != null ? searchKey : (catId != null && catId.matches("\\d+") ? categoryDao.getCategoryName(Integer.parseInt(catId)) : "Tất cả");
            message = "Không có hàng hóa nào có sẵn cho \"" + escapeHtml(fallback) + "\"";
            prodList = productDao.getAllProducts();
        }
    } catch (Exception e) {
        message = "Đã xảy ra lỗi khi xử lý yêu cầu.";
        prodList = productDao.getAllProducts();
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }

        h4 {
            font-weight: bold;
            color: #027a3e;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .container-fluid {
            padding: 30px 50px;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .card img {
            border-radius: 10px;
            max-height: 180px;
            object-fit: cover;
        }

        .wishlist-icon {
            position: absolute;
            right: 15px;
            top: 15px;
            background-color: #ffffff;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .wishlist-icon:hover {
            background-color: #ffecec;
        }

        .wishlist-icon i {
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .wishlist-icon:hover i {
            color: #ff4d4d;
        }

        .real-price {
            font-size: 22px;
            font-weight: bold;
            color: #ff5722;
        }

        .product-price {
            font-size: 16px;
            text-decoration: line-through;
            color: #888;
        }

        .product-discount {
            font-size: 14px;
            color: #027a3e;
        }

        .btn-primary {
            background-color: #027a3e;
            border: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-primary:hover {
            background-color: #025c2b;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .container-fluid {
                padding: 20px;
            }

            .card img {
                max-height: 150px;
            }
        }
    </style>
</head>
<body>
<%@include file="Components/navbar.jsp"%>

<h4 class="text-center"><%= escapeHtml(message) %></h4>
<div class="container-fluid">
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <%
            for (Product p : prodList) {
        %>
        <div class="col">
            <div class="card h-100 position-relative">
                <img src="Product_imgs/<%= escapeHtml(p.getProductImages()) %>" alt="<%= escapeHtml(p.getProductName()) %>" class="card-img-top">
                <div class="wishlist-icon">
                    <%
                        if (u != null) {
                            if (wishlistDao.getWishlist(u.getUserId(), p.getProductId())) {
                    %>
                    <button
                        onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=remove', '_self')"
                        class="btn btn-link">
                        <i class="fa-solid fa-heart" style="color: #ff4d4d;"></i>
                    </button>
                    <%
                            } else {
                    %>
                    <button
                        onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=add', '_self')"
                        class="btn btn-link">
                        <i class="fa-solid fa-heart" style="color: #909191;"></i>
                    </button>
                    <%
                            }
                        } else {
                    %>
                    <button onclick="window.open('login.jsp', '_self')" class="btn btn-link">
                        <i class="fa-solid fa-heart" style="color: #909191;"></i>
                    </button>
                    <%
                        }
                    %>
                </div>
                <div class="card-body text-center">
                    <h5 class="card-title"><%= escapeHtml(p.getProductName()) %></h5>
                    <p>
                        <span class="real-price"><%= p.getProductPriceAfterDiscount() %>&#8363;</span>
                        <span class="product-price"><%= p.getProductPrice() %>&#8363;</span>
                        <span class="product-discount"><%= p.getProductDiscount() %>&#37; off</span>
                    </p>
                    <button type="button" class="btn btn-primary"
                            onclick="window.open('viewProduct.jsp?pid=<%=p.getProductId()%>', '_self')">Xem chi tiết</button>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
