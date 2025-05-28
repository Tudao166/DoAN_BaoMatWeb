/* Code ban đầu*/

/*package com.webshoes.filters;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.webshoes.security.CSRFProtection;

@WebFilter(urlPatterns = {"*.jsp", "/AddToCartServlet", "/RemoveFromCartServlet",
        "/UpdateCartServlet", "/OrderServlet", "/UpdateProductServlet", "/LogoutServlet"})
public class CSRFFilter implements Filter {

    // Các servlet cần bảo vệ CSRF cho POST request
    private static final Set<String> PROTECTED_POST_SERVLETS = new HashSet<>(Arrays.asList(
            "/AddToCartServlet", "/RemoveFromCartServlet", "/UpdateCartServlet",
            "/OrderServlet", "/UpdateProductServlet", "/LogoutServlet"
    ));

    // Các servlet cần bảo vệ CSRF cho GET request (như search)
    private static final Set<String> PROTECTED_GET_PAGES = new HashSet<>(Arrays.asList(
            "/products.jsp"
    ));

    // Các trang JSP cần bảo vệ CSRF cho POST
    private static final Set<String> PROTECTED_POST_PAGES = new HashSet<>(Arrays.asList(
            "/viewProduct.jsp", "/cart.jsp", "/checkout.jsp", "/admin.jsp"
    ));

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String method = httpRequest.getMethod();

        // Kiểm tra CSRF cho các request cần bảo vệ
        if (shouldProtectRequest(requestURI, method)) {

            HttpSession session = httpRequest.getSession(false);
            if (session == null) {
                // Nếu không có session và cần bảo vệ, redirect về login
                if ("POST".equalsIgnoreCase(method)) {
                    httpResponse.sendRedirect("login.jsp?error=session_expired");
                    return;
                }
            } else {
                String submittedToken = httpRequest.getParameter("csrfToken");

                // Đối với GET request có tham số search, kiểm tra CSRF nếu có token
                if ("GET".equalsIgnoreCase(method) && submittedToken != null) {
                    if (!CSRFProtection.validateCSRFToken(session, submittedToken)) {
                        httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        httpRequest.setAttribute("errorMessage",
                                "Yêu cầu tìm kiếm không hợp lệ. Vui lòng thử lại.");
                        httpRequest.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                }

                // Đối với POST request, luôn kiểm tra CSRF
                if ("POST".equalsIgnoreCase(method)) {
                    if (!CSRFProtection.validateCSRFToken(session, submittedToken)) {
                        httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        httpRequest.setAttribute("errorMessage",
                                "Yêu cầu không hợp lệ. Vui lòng thử lại.");
                        httpRequest.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                }
            }
        }

        // Tiếp tục xử lý request
        chain.doFilter(request, response);
    }

    private boolean shouldProtectRequest(String requestURI, String method) {
        // Kiểm tra POST servlet
        if ("POST".equalsIgnoreCase(method)) {
            for (String servlet : PROTECTED_POST_SERVLETS) {
                if (requestURI.endsWith(servlet)) {
                    return true;
                }
            }

            // Kiểm tra POST JSP page
            for (String page : PROTECTED_POST_PAGES) {
                if (requestURI.endsWith(page)) {
                    return true;
                }
            }
        }

        // Kiểm tra GET page với search parameter
        if ("GET".equalsIgnoreCase(method)) {
            for (String page : PROTECTED_GET_PAGES) {
                if (requestURI.endsWith(page)) {
                    return true;
                }
            }
        }

        return false;
    }

    @Override
    public void destroy() {
        // Cleanup
    }
}
*/

/*Code lỗ hổng missing*/
package com.webshoes.filters;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.webshoes.security.CSRFProtection;

@WebFilter(urlPatterns = {"/*"})
public class CSRFFilter implements Filter {

    // Các servlet cần bảo vệ CSRF cho POST request
    private static final Set<String> PROTECTED_POST_SERVLETS = new HashSet<>(Arrays.asList(
            "/AddToCartServlet", "/RemoveFromCartServlet", "/UpdateCartServlet",
            "/OrderServlet", "/UpdateProductServlet", "/LogoutServlet"
    ));

    // Các servlet cần bảo vệ CSRF cho GET request (như search)
    private static final Set<String> PROTECTED_GET_PAGES = new HashSet<>(Arrays.asList(
            "/products.jsp"
    ));

    // Các trang JSP cần bảo vệ CSRF cho POST
    private static final Set<String> PROTECTED_POST_PAGES = new HashSet<>(Arrays.asList(
            "/viewProduct.jsp", "/cart.jsp", "/checkout.jsp", "/admin.jsp"
    ));

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        httpResponse.setHeader("Content-Security-Policy", "frame-ancestors 'none';");
        httpResponse.setHeader("X-Frame-Options", "DENY"); // Ngăn Clickjacking hoàn toàn
        httpResponse.setHeader("X-Content-Type-Options", "nosniff"); // Chống MIME sniffing
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block"); // Bật bộ lọc XSS cũ trên một số trình duyệt cũ
        httpResponse.setHeader("Referrer-Policy", "no-referrer"); // Không gửi thông tin Referrer

        String requestURI = httpRequest.getRequestURI();
        String method = httpRequest.getMethod();

        // Kiểm tra CSRF cho các request cần bảo vệ
        if (shouldProtectRequest(requestURI, method)) {

            HttpSession session = httpRequest.getSession(false);
            if (session == null) {
                // Nếu không có session và cần bảo vệ, redirect về login
                if ("POST".equalsIgnoreCase(method)) {
                    httpResponse.sendRedirect("login.jsp?error=session_expired");
                    return;
                }
            } else {
                String submittedToken = httpRequest.getParameter("csrfToken");

                // Đối với GET request có tham số search, kiểm tra CSRF nếu có token
                if ("GET".equalsIgnoreCase(method) && submittedToken != null) {
                    if (!CSRFProtection.validateCSRFToken(session, submittedToken)) {
                        httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        httpRequest.setAttribute("errorMessage",
                                "Yêu cầu tìm kiếm không hợp lệ. Vui lòng thử lại.");
                        httpRequest.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                }

                // Đối với POST request, luôn kiểm tra CSRF
                if ("POST".equalsIgnoreCase(method)) {
                    if (!CSRFProtection.validateCSRFToken(session, submittedToken)) {
                        httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        httpRequest.setAttribute("errorMessage",
                                "Yêu cầu không hợp lệ. Vui lòng thử lại.");
                        httpRequest.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                }
            }
        }

        // Tiếp tục xử lý request
        chain.doFilter(request, response);
    }

    private boolean shouldProtectRequest(String requestURI, String method) {
        // Kiểm tra POST servlet
        if ("POST".equalsIgnoreCase(method)) {
            for (String servlet : PROTECTED_POST_SERVLETS) {
                if (requestURI.endsWith(servlet)) {
                    return true;
                }
            }

            // Kiểm tra POST JSP page
            for (String page : PROTECTED_POST_PAGES) {
                if (requestURI.endsWith(page)) {
                    return true;
                }
            }
        }

        // Kiểm tra GET page với search parameter
        if ("GET".equalsIgnoreCase(method)) {
            for (String page : PROTECTED_GET_PAGES) {
                if (requestURI.endsWith(page)) {
                    return true;
                }
            }
        }

        return false;
    }

    @Override
    public void destroy() {
        // Cleanup
    }
}
