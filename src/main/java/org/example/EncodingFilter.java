//EncodingFilter.java
package org.example;

import javax.servlet.*;
import java.io.IOException;

public class EncodingFilter implements Filter {
    private String encoding = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) {
        String paramEncoding = filterConfig.getInitParameter("encoding");
        if (paramEncoding != null && !paramEncoding.isEmpty()) {
            encoding = paramEncoding;
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // リクエストに適用されるエンコーディングをログに記録
        System.out.println("Applying encoding: " + encoding + " to the request");
        // リクエストのエンコーディング設定
        request.setCharacterEncoding("UTF-8");
        // レスポンスのエンコーディング設定
        response.setCharacterEncoding("UTF-8");

        // フィルターチェーンを続行
        chain.doFilter(request, response);

        // レスポンスに適用されたエンコーディングをログに記録
        System.out.println("Applied encoding: " + encoding + " to the response");
    }

    public void destroy() {
    }
}
