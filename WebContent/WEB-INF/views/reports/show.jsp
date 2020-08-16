<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="../layout/app.jsp">

    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
                <h2>日報 詳細ページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${report.employee.name}" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value="${report.report_date}" /></td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td>
                                <pre><c:out value="${report.content}" /></pre>
                            </td>
                        </tr>
                        <tr>
                            <th>承認</th>
                            <td>
                            <c:choose>
                                <c:when test="${report.approval == null || report.approval == 0}">
                                    未
                                </c:when>
                                <c:otherwise>
                                    済
                                </c:otherwise>
                            </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td><fmt:formatDate value="${report.created_at}" /></td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td><fmt:formatDate value="${report.updated_at}"  /></td>
                        </tr>
                    </tbody>
                </table><br />

                <c:if test="${sessionScope.login_employee.id == report.employee.id}">
                    <p><a href="<c:url value='/reports/edit?id=${report.id}' />">この日報を編集する</a></p>
                </c:if>
                <c:if test="${sessionScope.login_employee.admin_flag > report.employee.admin_flag}">

                    <form method="POST" action="<c:url value='/reports/approval' />">
                        <input type="hidden" name="_token" value="${_token}" />
                        <input type="hidden" name="report_id_for_approval" value="${report.id}" />
                        <c:choose>
                            <c:when test="${report.approval == 0}">
                                <!-- <p><a href="#">承認する</a></p> -->
                                <input type="submit" value="<c:out value="承認する" />">
                            </c:when>
                            <c:otherwise>
                                <input type="submit" value="<c:out value="承認を解除する" />">
                            </c:otherwise>
                         </c:choose>
                    </form>

                 </c:if>

            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value='/reports/index' />">一覧に戻る</a></p>
    </c:param>

</c:import>