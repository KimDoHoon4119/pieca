package sitemesh;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

@WebFilter("/*")
public class SiteMeshFilter extends ConfigurableSiteMeshFilter{
	
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)servletRequest;
		//servletRequest : request객체의 부모 클래스
		String url = request.getRequestURI(); // 요청된 url 정보
		if(url.contains("/user/")) url="user";
		else if(url.contains("/admin/")) url="user";
		else if(url.contains("/board/")) url="board";
		else if(url.contains("/item/")) url="item";
		else if(url.contains("/cart/")) url="item";
		else if(url.contains("/chat/")) url="chat";
		else url="";
		request.setAttribute("url", url);
		super.doFilter(servletRequest, servletResponse, filterChain);
	}

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("/*", "/layout/gdulayout.jsp")
		.addExcludedPath("/user/idsearch*")
		.addExcludedPath("/user/pwsearch*")
		.addExcludedPath("/user/payment")
		.addExcludedPath("/user/getcard")
		.addExcludedPath("/board/imgupload*")
		.addExcludedPath("/ajax/*");
	}

}
