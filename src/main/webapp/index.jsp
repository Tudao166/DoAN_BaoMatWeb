<%@page import="com.webshoes.dao.ProductDao"%>
<%@page import="com.webshoes.beans.Product"%>
<%@page import="com.webshoes.helper.ConnectionProvider"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
    List<Product> productList = productDao.getAllLatestProducts();
    List<Product> topDeals = productDao.getDiscountedProducts();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ</title>
        <%@include file="Components/common_css_js.jsp"%>
        <style type="text/css">
            /* General Styles */
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            h1, h5, h6 {
                font-weight: bold;
            }

            a {
                text-decoration: none;
                color: inherit;
                transition: color 0.3s ease;
            }

            a:hover {
                color: #027a3e;
            }

            .card {
                border-radius: 10px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .cus-card {
                border-radius: 15px;
                overflow: hidden;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .cus-card:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            }

            .real-price {
                font-size: 22px;
                font-weight: 600;
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

            /* Carousel */
            .carousel-item img {
                border-radius: 10px;
                object-fit: cover;
                height: 400px;
            }

            /* Category Section */
            .category-card {
                background-color: #ffffff;
                padding: 15px;
                border-radius: 10px;
                transition: box-shadow 0.3s ease, transform 0.3s ease;
            }

            .category-card:hover {
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                transform: translateY(-5px);
            }

            .category-card img {
                max-height: 120px;
                max-width: 100%;
                object-fit: contain;
            }
        </style>
    </head>
    <body>
        <!--navbar -->
        <%@include file="Components/navbar.jsp"%>

        <!-- Carousel -->
        <div id="carouselAutoplaying" class="carousel slide carousel-dark mt-3 mb-3" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="Images/scroll_img_2.jpg" class="d-block w-100" alt="Banner 1">
                </div>
                <div class="carousel-item">
                    <img src="Images/scroll_img_1.jpg" class="d-block w-100" alt="Banner 2">
                </div>
                <div class="carousel-item">
                    <img src="Images/scroll_img_3.jpg" class="d-block w-100" alt="Banner 3">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Quay lại</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Tiếp tục</span>
            </button>
        </div>

        <!-- Category list -->
        <div class="container py-4">
            <h2 class="text-center mb-4">Danh mục sản phẩm</h2>
            <div class="row row-cols-1 row-cols-md-4 g-4">
                <% for (Category c : categoryList) { %>
                <div class="col">
                    <a href="products.jsp?category=<%=c.getCategoryId()%>" class="text-center">
                        <div class="category-card">
                            <img src="Product_imgs/<%=c.getCategoryImage()%>" alt="<%=c.getCategoryName()%>" class="img-fluid">
                            <h6 class="mt-3"><%=c.getCategoryName()%></h6>
                        </div>
                    </a>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Latest Products -->
        <div class="container py-4">
            <h2 class="text-center mb-4">Sản phẩm mới nhất</h2>
            <div class="row row-cols-1 row-cols-md-4 g-4">
                <% for (int i = 0; i < Math.min(12, productList.size()); i++) { %>
                <div class="col">
                    <a href="viewProduct.jsp?pid=<%=productList.get(i).getProductId()%>">
                        <div class="card">
                            <img src="Product_imgs/<%=productList.get(i).getProductImages()%>" class="card-img-top" alt="<%=productList.get(i).getProductName()%>">
                            <div class="card-body text-center">
                                <h5 class="card-title"><%=productList.get(i).getProductName()%></h5>
                                <span class="real-price"><%=productList.get(i).getProductPriceAfterDiscount()%>&#8363;</span>
                                &ensp;<span class="product-price"><%=productList.get(i).getProductPrice()%>&#8363;</span>
                                <span class="product-discount"><%=productList.get(i).getProductDiscount()%>&#37; off</span>
                            </div>
                        </div>
                    </a>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Chatbot -->
        <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
        <df-messenger intent="WELCOME" chat-title="Chat_bot_web_shoes" agent-id="1f30195b-1044-492f-ac46-1df0d371d85e" language-code="en"></df-messenger>
    </body>
</html>
