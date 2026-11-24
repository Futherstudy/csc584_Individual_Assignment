<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CV Builder - Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="form-page">

<div class="form-container error-box">
    <h1>Please fix the following</h1>
    <p class="subtitle">Your CV could not be generated.</p>

    <ul class="error-list">
        <c:forEach var="err" items="${errors}">
            <li><c:out value="${err}"/></li>
        </c:forEach>
    </ul>

    <p>
        <a class="btn btn-primary" href="cvForm.jsp">Back to Form</a>
    </p>
</div>

</body>
</html>