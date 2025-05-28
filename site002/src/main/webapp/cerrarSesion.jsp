<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session = "true"%>
<%
	HttpSession sesionOk = request.getSession();
	sesionOk.invalidate();
%>
<jsp:forward page="login.jsp"/>
		
