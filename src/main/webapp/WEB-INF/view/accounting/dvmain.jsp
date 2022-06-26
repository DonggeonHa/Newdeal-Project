<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
	<!--  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<!--  CSS stylesheet link -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/accounting/accounting.css" >

	<title>지출결의서 신청</title>

	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

</head>

<body>
	<form id="myForm" action=""  method="">
		<input type="hidden" id="currentPageEmpDv" value="1">
		<input type="hidden" id="tmpEmpDv" value="">
		<input type="hidden" id="tmpEmpDvNm" value="">
		<input type="hidden" name="userType" id="userType" value="${userType}">
		<input type="hidden" name="curloginID" id="curloginID" value="${loginID}">
		
		
		<!-- 모달 배경 -->
		<div id="mask"></div>
	
		<div id="wrap_area">
	
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						
						<!-- content -->
						<div class="content">
	
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">회계</a> <span class="btn_nav bold">
									지출결의서 신청</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
	
							<p class="conTitle">
								<span>지출결의서 신청</span> <span class="fr">
									<a class="btnType blue"  href = "javascript:fPopModalEmpDv()" name="modal"><span>신규등록</span></a>
								</span>
							</p>
							
							<!-- date picker -->				
							<div class = "app_date_apply">
								<Strong>신청일자</Strong> <input type = "date" id="from_date">~<input type="date" id="to_date">
							</div>
							
							<div class = "selectEmpDv">
								<ul>
									<li>
									<strong>계정대분류명</strong>
										<select id ="account_cd" name ="account_cd" onChange="javascript:fn_selectComCombo()">
										<option></option>
										</select>	
									</li>
									<li>
									<strong>상세분류명</strong>
										<select id ="detail_account_cd" name ="detail_account_cd">
										<option></option>
										</select>
									</li>
									<li>
									<strong>승인여부</strong>
										<select id="dv_app_yn" name="dv_app_yn">
											<option value="" selected>전체</option>
											<option value="1">승인대기중</option>
											<option value= 2">승인</option>
											<option value="3">반려</option>
										</select>
									</li>	
								</ul>
									  <a class="btnType blue" href="javascript:fListEmpDv()" id="searchEnter" name="search">
									  <span>조회</span></a><br/>
							</div>
							
							<div class="divDvList">
								<table class="table table-striped col">			
										<thead id="tableTextD" >
											<tr>
												<th class="tdtext1">결의번호</th>
												<th class="tdtext1">계정대분류명</th>
												<th class="tdtext1">상세분류명</th>
												<th class="tdtext1">거래처명</th>
												<th class="tdtext1">신청일자</th>
												<th class="tdtext1">사용일자</th>
												<th class="tdtext1">지출금액</th>
												<th class="tdtext1">승인여부</th>
												<th class="tdtext1">승인/반려일자</th>
												<th class="tdtext1">승인자</th>
											</tr>
										</thead>
									<tbody id="listEmpDv"></tbody>
								</table>
							</div>
							<div class="paging_area"  id="empDvPagination"> </div>
						</div>
						
						<!-- footer 영역 -->
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	</form>
			
		
	<!-- 지출결의서 신규 등록 및 수정 모달(단건 조회) -->	
	<form id="empDvReg">
		<input type ="hidden" name = "action" id = "action" value = "">
		<div id = "layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
			<dt>
				<strong>지출결의서 신청 및 삭제</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>
						<tbody>
							<tr id = "dv_form">
								<th scope="row">결의번호</th>
								<td><input type="text" class="inputTxt p100" name="dv_no" id="dv_no"/></td>
							</tr>
							<tr>
								<th scope="row">아이디</th>
								<td><input type="text" class="inputTxt p100" name="loginID" id="loginID" readonly/></td>
							</tr>
							<tr>
								<th scope="row">사원명</th>
								<td><input type="text" class="inputTxt p100" name="name" id="name" readonly/></td>
							</tr>
							<tr>
								<th scope="row">계정대분류명<span class="font_red">*</span></span></th>
								<td colspan="3">
								<select id ="account_cd_modal" name = "account_cd_modal" onChange = "javascript:fn_selectComCombo_modal()">
								</select></td>
							</tr>
							<tr>
								<th scope="row">상세과목명<span class="font_red">*</span></th>
								<td colspan="3">
								<select id ="detail_account_cd_modal" name = "detail_account_cd_modal">
								</select></td>
							</tr>
	
							<tr>
								<th scope="row">거래처명<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="acc_name" id="acc_name" /></td>
							</tr>
							<tr>
								<th scope="row">신청일자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="dv_reg_date" id="dv_reg_date" readonly/></td>
							</tr>
							<tr>
								<th scope="row">사용일자<span class="font_red">*</span></th>
								<td colspan="3"><input type="date" 
									name="dv_use_date" id="dv_use_date" class ="inputTxt p100" style ="font-size : 92%"/></td>
							</tr>
							<tr>
								<th scope="row">지출금액<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="dv_amt" id="dv_amt" /></td>
							</tr>
							<tr id = "att_file_form">
								<th scope="row">증빙서류</th>
								<td colspan="3"><input type = "file" name = "att_file" id = "att_file"/></td>
							</tr>
							<tr style = "height: 100px">
								<th scope="row">비고</th>
								<td colspan="3"><textarea cols="20" rows="10" name = "dv_memo" id="dv_memo"  class = "p100" style = "height: 100px"/></textarea></td>
							</tr>
							<tr id = "dv_return_form">
								<th scope ="row">반려사유</th>
								<td colspan ="3"><textarea cols="20" rows="10" name = "dv_return" id="dv_return" readonly/></textarea></td>
							</tr>	
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveEmpDv" name="btn"><span>저장</span></a> 
						<a href="" class="btnType blue" id="btnDeleteEmpDv" name="btn"><span>삭제</span></a> 
						<a href=""	class="btnType gray"  id="btnCloseEmpDv" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href=""  class="closePop"><span class="hidden">닫기</span></a>
		</div>				
	</form> <!--// content -->

</body>

<script type="text/javascript">
 
</script>

</html>