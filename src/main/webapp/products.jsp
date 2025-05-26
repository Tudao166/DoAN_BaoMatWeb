<%@page import="com.webshoes.dao.WishlistDao"%>
<%@page import="com.webshoes.beans.User"%>
<%@page import="com.webshoes.dao.CategoryDao"%>
<%@page import="com.webshoes.beans.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.webshoes.helper.ConnectionProvider"%>
<%@page import="com.webshoes.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    User u = (User) session.getAttribute("activeUser");
    WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());

    String searchKey = request.getParameter("search");
    String catId = request.getParameter("category");
    CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
    String message = "";

    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
    List<Product> prodList = null;
    if (searchKey != null) {
        if (!searchKey.isEmpty()) {
            message = "Hiển thị kết quả cho \"" + searchKey + "\"";
        } else {
            message = "Không tìm thấy sản phẩm!";
        }
        prodList = productDao.getAllProductsBySearchKey(searchKey);

    } else if (catId != null && !(catId.trim().equals("0"))) {
        prodList = productDao.getAllProductsByCategoryId(Integer.parseInt(catId.trim()));
        message = "Hiển thị kết quả cho \"" + categoryDao.getCategoryName(Integer.parseInt(catId.trim())) + "\"";
    } else {
        prodList = productDao.getAllProducts();
        message = "Tất cả hàng hóa";
    }

    if (prodList != null && prodList.size() == 0) {

        message = "Không có hàng hóa nào có sẵn cho \""
                + (searchKey != null ? searchKey : categoryDao.getCategoryName(Integer.parseInt(catId.trim()))) + "\"";

        prodList = productDao.getAllProducts();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
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

        /* Product Card */
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

        /* Responsive Grid */
        .row-cols-md-4 {
            gap: 100;
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
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Show Products -->
    <h4 class="text-center"><%=message%></h4>
    <div class="container-fluid">
        <div class="row row-cols-1 row-cols-md-4 g-4">
            <%
                for (Product p : prodList) {
            %>
            <div class="col">
                <div class="card h-100 position-relative">
                    <img src="<%=request.getContextPath()%>/Product_imgs/<%=p.getProductImages()%>" alt="<%=p.getProductName()%>" class="card-img-top">
                    <div class="wishlist-icon">
                        <%
                            if (u != null) {
                                if (wishlistDao.getWishlist(u.getUserId(), p.getProductId())) {
                        %>
                        <button
                            onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=remove', '_self')"
                            class="btn btn-link" type="submit">
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
                        <button onclick="window.open('login.jsp', '_self')" class="btn btn-link" type="submit">
                            <i class="fa-solid fa-heart" style="color: #909191;"></i>
                        </button>
                        <%
                            }
                        %>
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title"><%=p.getProductName()%></h5>
                        <p>
                            <span class="real-price"><%=p.getProductPriceAfterDiscount()%>&#8363;</span>
                            <span class="product-price"><%=p.getProductPrice()%>&#8363;</span>
                            <span class="product-discount"><%=p.getProductDiscount()%>&#37; off</span>
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
