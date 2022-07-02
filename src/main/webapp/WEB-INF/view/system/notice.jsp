<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>



<script type="text/javascript">
var pagesize = 10;
var pagenavisize = 5;


$(document).ready(function() {

	fn_dateset(this);
	fn_noticelist();
	fNoticeButtonClickEvent();
	
});	


function fn_dateset(e){
	
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth();
	month += 1;
	if (month <= 9){
	    month = "0" + month;
	}
	var day = date.getDate();
	if (day <= 9){
	    day = "0" + month;
	}
	var today = year + '-' + month + '-' + day;
	var dateID =e.id;
	var date =e.value;
	$("#today").val(today);
	
	console.log(today);

	if(date == "" || date == undefined){ //날짜 삭제시, min,max초기화 
		
		console.log("didd");
		$("#to_date").attr("max",today); 
		$("#to_date").attr("min",""); 

		$("#from_date").attr("max",today);
		$("#from_date").attr("min");
	
	}
	
	else if(dateID == "from_date"){	
		
		$("#to_date").attr("min", date); 
		
	}
	else if( dateID == "to_date"){
		console.log(e.value);
		$("#from_date").attr("max", date);
		
		
	}
	
	
		
} 	

	/*모달 팝업 창 내의 버튼 id를 얻음 해당 버튼클릭시 실행해야하는 것들 호출*/
	function fNoticeButtonClickEvent() {
		
		

		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			
			case 'search_btn' : 
					console.log("1 검색버튼이 눌렸습니다.");
					 fn_searchnull();
					fn_noticelist();
					break;
					
			case 'btnSave':
				console.log("2");
				fn_noticeSave();
				break;
			case 'btnClose':
				console.log("3");
				gfCloseModal();
				break;
			case 'btnDelete':
				console.log("4");
				fn_deleteNotice();
				break;
				
			case'btnUpdate':
				console.log("수정");
				fn_noticeSave();
			
			}
		});
	}
	
	function fn_searchnull(){
		
		var search_option =  $("#search_option").val();
		var search_text = $("#search_text").val();
		<!--null 검색 -->
		if(search_option == "" &&  search_text == "" )
			alert(" 값을 입력해주세요 :) ");
		else if(search_option != "" && search_text == "")
			alert(" 값을 입력해 :) ");
		
		
	}
	
	<!--공지사항 리스트 불러오기 -->
	function fn_noticelist(pagenum) {
		
		
		
		pagenum = pagenum || 1;		
		
		
		var search_option =  $("#search_option").val();
		var search_text = $("#search_text").val();
		var toDate = $('#to_date').val();
		var fromDate = $('#from_date').val();
		var today = $("#today").val();
		
		console.log(search_option);
		
		var param = {
			search_option : search_option,
			search_text : search_text,
			pagenum : pagenum,
    		pagesize : pagesize,
    		fromDate : fromDate,
    		toDate : toDate,
    		today : today
		
		}
		
		Object.keys(param).forEach((key) => { 
		    console.log(key+" = "+param[key]); // key in obj
		    
		})
		

		var notice_callback = function(returndata) {
			console.log("notice_callback "+returndata);
			fn_listcallback(returndata, pagenum);
		}

		callAjax("/system/noticeList.do", "post", "text", true, param,notice_callback);

	}
	
	
	<!--공지사항 리스트 콜백함수 목록뿌리기  -->
	function fn_listcallback(returndata, pagenum) {

	
		console.log("fn_listcallback : " + returndata);
		
		$("#notice_list").empty().append(returndata);
		var totalcnt = $("#totalcnt").val();
	
		var paginationHtml = getPaginationHtml(pagenum, totalcnt, pagesize,pagenavisize, 'fn_noticelist'); 
		
		//swal(paginationHtml);
		
		$("#notice_paging").empty().append(paginationHtml); 

		$("#pagenum").val(pagenum);
		console.log("fn_listcallback : pagenum" + pagenum);
		
	}

<!--단건 조회 -->
function fn_selectnotice(no){
	$("#notice_no").val(no);
	 var writer=$("#modal_id").val();
	
	var param = {
			
			no : no,
			writer : writer
	}
	
	
	var selectOneCallback = function(returndata){
		
		console.log("확인2");
		fn_selectone(returndata);
	}
	
	callAjax("/system/noticeSelectOne.do", "post", "json", true, param,selectOneCallback);
			
}

<!-- 단건조회 콜백함수  -->
function fn_selectone(returndata){
	
	console.log(returndata.result);
	
	

	
	if(returndata.resultdata == "SUCCESS"){
		 gfModalPop("#writeform");
	}
	
	fn_modalInit(returndata.result);
	
}


<!-- 팝업 초기화 -->
function fn_modalInit(object){
	
	var userID = $("#writer_id").val();
 	
 	
	 if(object == "" || object == null || object == undefined){
		
		 var loginID=$("#writer_id").val();
			console.log("아이디 "+loginID);
	
			$("#modal_id").val(loginID);
			$("#modal_id").attr("readonly",true);
    		$("#noticeno").val("");
		 	$("#modal_title").val("");
			$("#modal_cont").val("");
			$("#btnSave").show();
			$("#btnUpdate").hide();
			$("#btnDelete").hide();
			$("#action").val("I");
			
			
	 }else if(object.loginID != userID){
	
		 
		 		console.log("확인 " +object.loginID);
	 			console.log("작성자가 다르다.");
	 			$("#modal_id").val(object.loginID);
	 		   	$("#modal_title").val(object.title);
	 			$("#modal_cont").val(object.contents);
	 			$("#noticeno").val(object.contents);
	 			
	 			$("#modal_id").attr("readonly",true);
	 			$("#modal_title").attr("readonly",true);
	 			$("#modal_cont").attr("readonly",true);
	 			
	 			$("#btnSave").hide();
	 			$("#btnDelete").hide();

	 			
	 			
	 		} else{ // 수정
	 		
	 
	 		console.log("작성자가 같다규 ");
	 		console.log("수정  " +object.loginID);
		   $("#modal_id").val(object.loginID);
		   $("#modal_title").val(object.title);
			$("#modal_cont").val(object.contents);
			$("#noticeno").val(object.contents);
			
			$("#modal_id").attr("readonly",true);

			$("#btnUpdate").show();
			$("#btnSave").hide();
			$("#btnDelete").show();
			$("#action").val("U");
				
		 
	 	}
	 
	
}

<!-- 신규작성 -->
function fn_writemodal(notice_no){
	
	console.log(notice_no);
	
	if(notice_no == null || notice_no == ""){ // 신규등록일때 
		
		$("#action").val("I"); 
		//화면초기화
		fn_modalInit(notice_no); // 초기화
		gfModalPop("#writeform");
		
		
	}else{ //수정일때 
		
		 fn_selectnotice(notice_no);
		 $("#action").val("U"); 
		
	}
}

/* 팝업내 수정, 저장 validation */
function fValidatePopup(){
	 var chk = checkNotEmpty(
			 [
				 ["modal_title", "제목을 입력해주세요!"],
				 ["modal_cont", "내용 입력해주세요!"]
			 ]
	 );

	if(!chk){return;}
	return true;
}

<!--저장 -->
function fn_noticeSave(){
	
	
	if(!(fValidatePopup())){
		return;
	}
	
	
	var title =  $("#modal_title").val();
	var contents = $("#modal_cont").val();
	var action =  $("#action").val();
	var no =  $("#notice_no").val();

	
	var param = {
			
			title : title,
		   contents : contents,
			action :action,
			no : no
			
	}
	

	
	var saveCallback = function(returndata){
		
		console.log("저쟝");
		fn_saveResult(returndata);
	}
	
	callAjax("/system/noticeSave.do", "post", "json", true, param,saveCallback);
			
}





function fn_saveResult(returndata){
	
	
	console.log("fn_saveCallback "+ JSON.stringify(returndata));
	console.log(returndata.result);

	if(returndata.result == "SUCCESS"){
		alert("저장되었습니다.");
	}else if(returndata.result == "UPDATED"){
		 alert("수정되었습니다.");
	}else if(returndata.result == "DELETED"){
		alert("삭제 되었습니다.");
	}
	
	gfCloseModal();
	fn_noticelist();
	fn_modalInit();

	
}

function fn_updateNotice(){

	
	if(!confirm("수정 하겠습니까?")) {
		return;
	}
	
	if(!(fValidatePopup())){
		return;
	}
	
	
	var updateCallback = function(returndata){
		
		console.log("수져어어");
		fn_saveResult(returndata);
	}
	
	callAjax("/system/noticeSave.do", "post", "json", true, param,updateCallback);
	
	
}

function fn_deleteNotice() {
	
	if(!confirm("삭제 하겠습니까?")) {
		return;
	}
	
	//$("#action").val("D");
	
	var no =  $("#notice_no").val();
	//var action = $("#action").val();
	
	var param = {
			no : no,
			action : "D"
	}
	
	var deletecollaback = function(retundata) {
	  
	
	    if(retundata.result == "DELETE") {
	    	alert("삭제 되었습니다");
	    	
	    	 gfCloseModal();
	    	 fn_noticelist();
	    }
	    
	   //fn_selectoneproc(retundata);
  }	
	$("#action").val("D");
  callAjax("/system/noticeSave.do", "post", "json", true, param, deletecollaback);   	
}

	


	
</script>



</head>
<body>

	<form id="noticelistform" action="" method="">
		<!-- 게시판 번호/ 등록인지 수정인지 알수있는 플래그값 /-->
		<input type="hidden" id="pagenum" value=""> <input
			type="hidden" name="action" id="action" value=""> <input
			type="hidden" name="notice_no" id="notice_no" value=""> <input
			type="hidden" id="writer_id" value="${loginId}"> <input
			type="hidden" id="today" value="">

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

						<h3 class="hidden">contents 영역</h3>
						<div class="content">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">시스템관리</span> <span
									class="btn_nav bold">공지사항</span>
							</p>

							<p class="conTitle">
								<span><a href="../system/notice.do">ERP공지사항</span></a>
							</p>



							<div
								style="float: right; witdh: 100%; margin-top: 10px; margin-bottom: 30px;">
								<c:set var="nullNum" value=""></c:set>
								<a href="javascript:fn_writemodal(${nullNum});"
									class="btnType blue" id="write_btn" name="modal"><span>신규
										작성</span></a>
							</div>


							<!--검색창  -->

							<table
								style="clear: both; width: 100%; cellpadding: 5; cellspacing =: 0; border: 1; text-align: center; collapse; border: 1px #50bcdf;">
								<tr style="border: 0px; border-color: blue;">
									<td><select name="search_option" id="search_option">
											<option value="" selected>선택</option>
											<option value="search_title">제목</option>
											<option value="search_name">작성자</option>
									</select></td>
									<td>날짜</td>
									<td><input type="date" id="from_date"
										onchange="fn_dateset(this)"> <input type="date"
										id="to_date" onchange="fn_dateset(this)"></td>
									<td><input style="width: 300px; height: 25px;"
										id="search_text" name=""></td>
									<td><a href="" class="btnType blue" id="search_btn"
										name="btn"><span>검색</span></a></td>
								</tr>
							</table>
							<!--검색창  -->

							<!--목록 리스트-->
							<div>
								<table class="col" style="margin-top: 20px;">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="54%">
										<col width="20%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">제목</th>
											<th scope="col">작성자</th>
											<th scope="col">날짜</th>
										</tr>
									</thead>
									<tbody id="notice_list"></tbody>
								</table>
							</div>
							<!-- 페이징 처리  -->
							<div class="paging_area" id="notice_paging"></div>

















						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->

		<div id="writeform" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>공지사항</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="100px">
							<col width="200PX">
							<col width="100px">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p200"
									name="writer" id="modal_id"></input></td>
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><textarea id="modal_title" name="title"></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3"><textarea id="modal_cont" name="cont"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnUpdate" name="btn"
							style="display: none"><span>수정</span></a> <a href=""
							class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>


		</div>


	</form>
</body>
</html>