<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="../layout/app.jsp">

    <c:param name="content">
        <c:choose>
            <c:when test="${employee != null}">
                <h2>id : ${employee.id } の従業員情報 詳細ページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>社員番号</th>
                            <td><c:out value="${employee.code}" /></td>
                        </tr>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${employee.name}" /></td>
                        </tr>
                        <tr>
                            <th>権限</th>
                            <c:choose>
                                <c:when test="${employee.admin_flag == 1}">
                                    <td>課長</td>
                                </c:when>
                                <c:when test="${employee.admin_flag == 2}">
                                    <td>部長</td>
                                </c:when>
                                <c:otherwise>
                                    <td>一般</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td>
                                <fmt:formatDate value="${employee.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td><fmt:formatDate value="${employee.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                    </tbody>
                </table>

                <p><a href="<c:url value='/employees/edit?id=${employee.id}' />">この従業員を編集する</a></p>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>
        <!-- test="${employee != null}" -->

        <p><a href="<c:url value='/employees/index' />">一覧に戻る</a></p>
    </c:param>

</c:import>