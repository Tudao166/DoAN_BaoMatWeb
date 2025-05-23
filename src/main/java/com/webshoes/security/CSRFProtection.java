package com.webshoes.security;

import java.security.SecureRandom;
import java.util.Base64;
import jakarta.servlet.http.HttpSession; // Thay đổi từ javax sang jakarta

public class CSRFProtection {

    private static final String CSRF_TOKEN_ATTR = "csrfToken";
    private static final SecureRandom secureRandom = new SecureRandom();

    /**
     * Tạo CSRF token mới và lưu vào session
     */
    public static String generateCSRFToken(HttpSession session) {
        byte[] tokenBytes = new byte[32];
        secureRandom.nextBytes(tokenBytes);
        String token = Base64.getEncoder().encodeToString(tokenBytes);
        session.setAttribute(CSRF_TOKEN_ATTR, token);
        return token;
    }

    /**
     * Lấy CSRF token từ session, tạo mới nếu chưa có
     */
    public static String getCSRFToken(HttpSession session) {
        String token = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        if (token == null || token.trim().isEmpty()) {
            token = generateCSRFToken(session);
        }
        return token;
    }

    /**
     * Xác thực CSRF token
     */
    public static boolean validateCSRFToken(HttpSession session, String submittedToken) {
        if (submittedToken == null || submittedToken.trim().isEmpty()) {
            return false;
        }

        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        if (sessionToken == null || sessionToken.trim().isEmpty()) {
            return false;
        }

        // Sử dụng phương pháp so sánh an toàn để tránh timing attack
        return secureEquals(sessionToken, submittedToken);
    }

    /**
     * So sánh chuỗi an toàn tránh timing attack
     */
    private static boolean secureEquals(String a, String b) {
        if (a.length() != b.length()) {
            return false;
        }

        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        return result == 0;
    }

    /**
     * Xóa CSRF token khỏi session (dùng khi logout)
     */
    public static void clearCSRFToken(HttpSession session) {
        session.removeAttribute(CSRF_TOKEN_ATTR);
    }
}