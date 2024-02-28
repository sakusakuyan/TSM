<!-- index.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<%
    request.setCharacterEncoding("UTF-8");
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<title>教師管理システムリンク</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/styles.css">
</head>
<body>

<p class="content"><a href="<%=basePath%>TeacherListServlet">教師情報</a></p>
<p class="content2"><a href="<%=basePath%>teacherNew.jsp">教師登録</a></p>

</body>
</html>