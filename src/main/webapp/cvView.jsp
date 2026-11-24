<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${cvData.fullName} - CV</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="cv-page">

<div class="toolbar no-print">
    <a class="btn btn-secondary" href="cvForm.jsp">Back to Form</a>
    <button class="btn btn-primary" onclick="window.print()">Print CV</button>
</div>

<div class="cv">

    <header class="cv-header">
        <c:choose>
            <c:when test="${not empty cvData.photoUrl}">
                <img class="cv-photo" src="<c:out value='${cvData.photoUrl}'/>" alt="Profile photo">
            </c:when>
            <c:otherwise>
                <div class="cv-photo placeholder">Photo</div>
            </c:otherwise>
        </c:choose>
        <h1><c:out value="${cvData.fullName}"/></h1>
        <c:if test="${not empty cvData.title}">
            <h2><c:out value="${cvData.title}"/></h2>
        </c:if>
        <p class="contact">
            <c:out value="${cvData.email}"/>
            <c:if test="${not empty cvData.phone}"> | <c:out value="${cvData.phone}"/></c:if>
            <c:if test="${not empty cvData.linkedin}"> | <c:out value="${cvData.linkedin}"/></c:if>
        </p>
    </header>

    <c:if test="${not empty cvData.summary}">
        <section>
            <h3>Profile Summary</h3>
            <p><c:out value="${cvData.summary}"/></p>
        </section>
    </c:if>

    <section>
        <h3>Education</h3>
        <p class="item-title"><c:out value="${cvData.degree}"/></p>
        <p>
            <c:out value="${cvData.institution}"/>
            <c:if test="${not empty cvData.gradYear}"> (<c:out value="${cvData.gradYear}"/>)</c:if>
        </p>
        <c:if test="${not empty cvData.major}">
            <p>Major: <c:out value="${cvData.major}"/></p>
        </c:if>
    </section>

    <c:if test="${not empty cvData.jobTitle}">
        <section>
            <h3>Experience</h3>
            <p class="item-title"><c:out value="${cvData.jobTitle}"/></p>
            <p>
                <c:out value="${cvData.company}"/>
                <c:if test="${not empty cvData.duration}"> | <c:out value="${cvData.duration}"/></c:if>
            </p>
            <ul>
                <c:forEach var="item" items="${cvData.responsibilityList}">
                    <li><c:out value="${item}"/></li>
                </c:forEach>
            </ul>
        </section>
    </c:if>

    <section>
        <h3>Skills</h3>
        <p class="item-title">Technical Skills</p>
        <ul class="tags">
            <c:forEach var="skill" items="${cvData.technicalSkillList}">
                <li><c:out value="${skill}"/></li>
            </c:forEach>
        </ul>

        <c:if test="${not empty cvData.softSkillList}">
            <p class="item-title">Soft Skills</p>
            <ul class="tags">
                <c:forEach var="skill" items="${cvData.softSkillList}">
                    <li><c:out value="${skill}"/></li>
                </c:forEach>
            </ul>
        </c:if>
    </section>

</div>

</body>
</html>