<%@page import="com.webshoes.dao.WishlistDao"%>
<%@page import="com.webshoes.dao.ProductDao"%>
<%@page import="com.webshoes.beans.Product"%>
<%@page import="com.webshoes.security.CSRFProtection"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// Enhanced input validation and sanitization
String pidParam = request.getParameter("pid");
int productId = 0;
Product product = null;
boolean validProduct = false;

// Multi-layer validation
if (pidParam != null && pidParam.trim().length() > 0) {
    try {
        // Strict numeric validation - only allow digits
        if (pidParam.matches("^[0-9]+$")) {
            productId = Integer.parseInt(pidParam);

            // Range validation
            if (productId > 0 && productId < 999999) {
                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                product = productDao.getProductsByProductId(productId);

                // Verify product exists and has valid data
                if (product != null && product.getProductId() > 0 &&
                    product.getProductName() != null && !product.getProductName().trim().isEmpty()) {
                    validProduct = true;
                }
            }
        }
    } catch (Exception e) {
        // Silent handling - log internally only
        validProduct = false;
    }
}

// Consistent response for all invalid cases
if (!validProduct) {
    response.sendRedirect("error_page.jsp");
    return;
}

// Tạo CSRF Token cho session hiện tại
String csrfToken = "";
if (session != null) {
    csrfToken = CSRFProtection.getCSRFToken(session);
}

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xem sản phẩm</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.real-price {
	font-size: 26px !important;
	font-weight: 600;
}

.product-price {
	font-size: 18px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 16px !important;
	color: #027a3e;
}
.text-end {
    text-align: center !important;
}
</style>
</head>
<body>

	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container mt-5">
			<%@include file="Components/alert_message.jsp"%>
		<div class="row border border-3">
			<div class="col-md-6">
				<div class="container-fluid text-end my-3">
					<img src="Product_imgs\<%=product.getProductImages()%>"
						class="card-img-top"
						style="max-width: 100%; max-height: 500px; width: auto;">
				</div>
			</div>
			<div class="col-md-6">
				<div class="container-fluid my-5">
					<h4><%=product.getProductName()%></h4>
					<span class="fs-5"><b>Mô tả</b></span><br> <span><%=product.getProductDescription()%></span><br>
					<span class="real-price"><%=product.getProductPriceAfterDiscount()%>&#8363;</span>&ensp;
					<span class="product-price"><%=product.getProductPrice()%>&#8363;</span>&ensp;
					<span class="product-discount"><%=product.getProductDiscount()%>&#37;off</span><br>
					<span class="fs-5"><b>Tình trạng : </b></span> <span id="availability">
						<%
						if (product.getProductQunatity() > 0) {
							out.println("Có sẵn");
						} else {
							out.println("Hiện tại đã hết hàng");
						}
						%>
					</span><br> <span class="fs-5"><b>Hãng : </b></span> <span><%=catDao.getCategoryName(product.getCategoryId())%></span>
					<!-- Form với CSRF Protection -->
                    <form method="post" id="productForm">
                        <!-- CSRF Token hidden field -->
                        <input type="hidden" name="csrfToken" value="<%=csrfToken%>" />

                        <div class="container-fluid text-center mt-3">
							<%
							if (user == null) {
							%>
							<button type="button" onclick="window.open('login.jsp', '_self')"
								class="btn btn-primary text-white btn-lg">Thêm vào giỏ hàng</button>
							&emsp;
							<button type="button" onclick="window.open('login.jsp', '_self')"
								class="btn btn-info text-white btn-lg">Mua ngay bây giờ</button>
							<%
							} else {
							%>
							<button type="submit"
                                formaction="./AddToCartServlet?uid=<%=user.getUserId()%>&pid=<%=product.getProductId()%>"
                                class="btn btn-primary text-white btn-lg" id="add-to-cart-btn">Thêm vào giỏ hàng</button>
							&emsp; <button type="button" id="buy-btn"
                                       class="btn btn-info text-white btn-lg">Mua ngay bây giờ</button>
							<%
							}
							%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<script>
    $(document).ready(function() {
        // Kiểm tra tình trạng sản phẩm
        if ($('#availability').text().trim() == "Hiện tại đã hết hàng") {
            $('#availability').css('color', 'red');
            $('.btn').addClass('disabled');
        }

        // Xử lý nút "Mua ngay"
        $('#buy-btn').click(function(e){
            e.preventDefault();

            // Tạo form ẩn để gửi đến checkout với CSRF token
            var form = $('<form>', {
                'method': 'POST',
                'action': 'checkout.jsp'
            });

            // Thêm CSRF token
            form.append($('<input>', {
                'type': 'hidden',
                'name': 'csrfToken',
                'value': '<%=csrfToken%>'
            }));

            // Thêm product ID
            form.append($('<input>', {
                'type': 'hidden',
                'name': 'pid',
                'value': '<%=productId%>'
            }));

            // Thêm flag
            form.append($('<input>', {
                'type': 'hidden',
                'name': 'from',
                'value': 'buy'
            }));

            // Submit form
            form.appendTo('body').submit();
        });

        // Xử lý form submit với validation
        $('#productForm').submit(function(e) {
            // Kiểm tra CSRF token tồn tại
            var csrfToken = $('input[name="csrfToken"]').val();
            if (!csrfToken || csrfToken.trim() === '') {
                e.preventDefault();
                alert('Lỗi bảo mật. Vui lòng tải lại trang và thử lại.');
                return false;
            }

            // Kiểm tra sản phẩm còn hàng
            if ($('#availability').text().trim() == "Hiện tại đã hết hàng") {
                e.preventDefault();
                alert('Sản phẩm hiện tại đã hết hàng.');
                return false;
            }
        });
    });
</script>
</body>
</html>