<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- tbody 제거 , comnGrpList.jsp 참고  -->
<c:if test="${oemCnt eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>


<c:if test="${oemCnt > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />

	<c:forEach items="${oemList}" var="list">
		<tr>
			<td>${list.client_nm}</td>
			<!-- 날짜 누르면 readonly  -->
			<td>${list.name}</td>
			<td>
				<a href="javascript:oemOne('${list.estimate_no}')">
					<strong>${list.receive_num}</strong>
				</a>
			</td>
			<td>${list.receive_date}</td>
			<td>${list.limit_date}</td>
			<td>${list.product_nm}</td>
			<td><fmt:formatNumber value="${list.estimate_cnt}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.supply_cost}" pattern="#,###"/></td>
			<td>${list.remarks}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
		<!-- 페이징 네비게이션 -->
	</c:forEach>
</c:if>

<!-- 단건조회시 카운트와 연관 깊음 -->
<input type="hidden" id="oemCnt" name="oemCnt" value="${oemCnt}" />
