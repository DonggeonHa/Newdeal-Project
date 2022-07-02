<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${estDetailCnt eq 0}">
	<tr>
		<td colspan="7">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<!-- 모달이 여러개라 id값 name값 다르게-->

<c:if test="${estDetailCnt > 0}">
	<c:forEach items="${estListDetail}" var="list">
		<c:set var="sum" value="${list.price + list.tax}"></c:set>
		<tr>
			<td>${list.productNm}</td>
			<td>${list.ourDeadline}</td>
			<td><fmt:formatNumber value="${list.estimateCnt}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.unitCost}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.price}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.tax}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
		</tr>
	</c:forEach>
</c:if>
<!-- 모달2 끝 -->

<!-- 단건조회시 카운트와 연관 깊음 -->
<input type="hidden" id="estDetailCnt" name="estDetailCnt" value="${estDetailCnt}"/>
