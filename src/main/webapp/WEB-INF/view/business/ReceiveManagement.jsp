<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- 다음 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// 페이징 설정 
	const pageSizeOemList = 8; // 행 다섯개
	const pageBlockSizeOemList = 5;  // 블록 갯수 일단 출력

	// 함수 시작
	$(document).ready(function(){
		//견적서 목록 조회 
		oemList();
		
		//모달창 초기화
		oemInitForm();
			
		// 버튼 이벤트 등록
		oRegisterButtonClickEvent();

		// -> 처음목록 & 검색용  거래처이름 
		selectComCombo("cli", "client_search", "all", "");   

		// -> 수주서등록 모달용 거래처 이름
		receiveNumSelectCombo("clientSearch1", "all", "");

		productCombo("l", "scm_big_class", "all", "");
		
		// 달력api datepicker 사용 선언 
		$('#from_date').datepicker();
		$('#to_date').datepicker();
	});

	/* -------------------------------------------------------------------  */
	/* -------------------------------------------------------------------  */
	/** 수주서 전용 콤보박스 만들자 */
	function receiveNumSelectCombo(combo_name, type, searchkey, selvalue) {

		console.log("receiveNumSelectCombo Start !!!!!!!!!!!!!! ");

		var selectbox = document.getElementById(combo_name);

		var data = {
			"searchkey" : searchkey
		};

		$(selectbox).find("option").remove();

		$.ajax({
			type: "POST",
			url: "/business/receiveNumSelectCombo.do",
			dataType: "json",
			data : data,
			success: function(data) {
				var json_obj = $.parseJSON(JSON.stringify(data));//parse JSON
				var jsonstr = json_obj.list;
				console.log("jsonstr : " + jsonstr);

				var jsonstr_obj = $.parseJSON(JSON.stringify(jsonstr));//parse JSON
				var listLen = jsonstr_obj.length;

				if(type == "all") {
					$(selectbox).append("<option value=''>전체</option>");
				}

				if(type == "sel") {
					$(selectbox).append("<option value=''>선택</option>");
				}

				console.log(" selvalue : " + JSON.stringify(selvalue));
				for(var i = 0; i < listLen; i++) {
					var eleString = JSON.stringify(jsonstr_obj[i]);
					var item_obj = $.parseJSON(eleString); //parse JSON

					if(selvalue != null && selvalue != null && selvalue != "") {
						if(selvalue == item_obj.dtl_cod) {
							console.log(" item_obj.cd : " + item_obj.clientCd);

							$(selectbox).append("<option value='"+ item_obj.clientCd + "' selected>" + item_obj.clientNm + "</option>");
						} else {
							$(selectbox).append("<option value='"+ item_obj.clientCd + "'>" + item_obj.clientNm + "</option>");
						}
					} else {
						$(selectbox).append("<option value='"+ item_obj.clientCd + "'>" + item_obj.clientNm + "</option>");
					}
				}
				$(selectbox).val(selvalue);
			},
			error:function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
		});
	};

	/** 버튼 이벤트 등록 */
	function oRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnIdEst = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

			switch (btnIdEst) {
				case 'btnReceiveInfoInsert' : // 신규등록 , 저장
					ReceiveInfoInsert();
					break;
				case 'btnDeleteOem' : // 삭제 
					oDeleteOem();
					break;
				case 'btnSearchOem': // 검색 
					oSearchOem();
					break;
				case 'btnReceiveClose' : // 모달 닫기 함수 [나는 하나로 썼음 ]
					gfCloseModal();
					break;
			}
		});
	}
	
/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  1. 수주서 신규 등록 모달  :  모달 실행 */
	function receiveModal1() {
		// 모달 팝업
		gfModalPop("#receiveModal");

		var param = {
			SUCCESS : "SUCCESS"
		};

		// 콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========" + JSON.stringify(data));
			receiveModal2(data);
		};

		callAjax("/business/receiveInfoCreateModal.do", "post", "json", true, param, resultCallback);
	}

	function receiveModal2(data){
		$("#erpCopnm").text(data.erp_copnm);
		$("#erpCopnum").text(data.erp_copnum);
		$("#erpEmp").text(data.user.name);
		$("#erpTel").text(data.user.tel);
		$("#erpEmail").text(data.user.mail);
	}

	/** 견적서 정보에 거래처를 셀렉하면 옆에 거래처 담당자랑 거래처 연락처가 뜬다 Ajax로 */
	function receiveSearchClient() {
		var clientCd = $('#clientSearch1').val();
		var clientNm = $('#clientSearch1 option:checked').text();
		let idx = clientNm.indexOf("@");
		let estimateNo = clientNm.substring(0, idx).trim();

		var param = {
			clientCd : clientCd,
			estimateNo : estimateNo
		}

		//콜백
		var resultCallback = function(data) {
			receiveSearchClient2(data);
		};

		callAjax("/business/receiveSearchClient.do", "post", "json", true, param, resultCallback);
	}

	/** 바로 위 함수의 콜백값을 받아 뿌려주기 */
	function receiveSearchClient2(data) {
		$('#clientName').empty();
		$('#clientTell').empty();
		$('#estimateNo').empty();

		$('#clientName').text(data.client.empNm);
		$('#clientTell').text(data.client.empHp);
		$('#estimateNo').text(data.estimateNo);
	}
	/* 신규 등록모달 끝   */

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  신규 등록 및 저장  */
	function ReceiveInfoInsert() {
		var clientCd = $('#clientSearch1').val();
		var remarks = $('#remarks').val();
		var estimateNo = $('#estimateNo').text();

		var param = {
			clientCd : clientCd,
			remarks : remarks,
			estimateNo : estimateNo
		}

		// validation 체크
		if(!(rValidatePopup())){ return; }

		var resultCallback = function(data){
			ReceiveInfoInsertResult(data); // 저장 콜백 함수
		};

		callAjax("/business/receiveManagementInsert.do", "post", "json", true, param, resultCallback);
	}

	/*  저장함수 콜백 함수 */
	function ReceiveInfoInsertResult(data) {
		gfCloseModal();	// 모달 닫기

		// 모달 팝업
		gfModalPop("#receiveModal2");
		ReceiveInfoInsert2(data.receiveInfo.estimateNo, data.receiveInfo.clientCd);
	}

	function ReceiveInfoInsert2(estimateNo, clientCd) {
		var param = {
			estimateNo : estimateNo,
			clientCd : clientCd
		}

		var resultCallback = function(data){
			ReceiveInfoInsertResult2(data); // 저장 콜백 함수
		};

		callAjax("/business/receiveManagementInsert2.do", "post", "json", true, param, resultCallback);
	}

	function ReceiveInfoInsertResult2(data) {
		$("#erpCopnm2").text(data.erp_copnm);
		$("#erpCopnum2").text(data.erp_copnum);
		$("#receiveNum2").text(data.receiveInfo.receiveNum);
		$("#erpEmp2").text(data.user.name);
		$("#erpTel2").text(data.user.tel);
		$("#erpEmail2").text(data.user.mail);
		$("#clientCd2").val(data.receiveInfo.clientCd);
		$("#clientNm2").text(data.receiveInfo.clientNm);
		$("#clientName2").text(data.receiveInfo.empNm);
		$("#clientTell2").text(data.receiveInfo.tel);
		$("#remarks2").text(data.receiveInfo.remarks);
	}

	/* 팝업내 수정, 저장 validation */
	function rValidatePopup(){

		var chk = checkNotEmpty(
				[
					["clientSearch1", "업체명을 체크해주세요!"]
				]
		);

		if(!chk){return;}
		return true;
	}

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  2 .단건조회 등등  모달창 값 초기화  */
	function oemInitForm(data) {
		$("#oemCnt").focus();	
		
		//2 - 1 신규등록	일 때
		if( data == "" || data == null || data == undefined) {
			$("#receive_num").val("");  					// hidden
			$("#estimate_no").val("");  					// hidden
			$("#client_search1").val(""); 					// 거래처 콤보박스
			$("#scm_big_class").val(""); 					// scm 대분류
			$("#scm_middle_class").val(""); 				// scm 중분류
			$("#product_cd").val(""); 					// scm 제품
			$("#estimate_cnt").val(""); 					// 수량
			$('#divtitle').empty();
			$("#divtitle").append("<strong>수주서 등록</strong>");
		} else {
			//2 - 2 단건 상세조회 모달창 
	 		$("#oem_client_nm").val(data.client_nm); 		// data.실제컬럼이름
		 	$("#limit_date").val(data.limit_date); 			// data.실제컬럼이름
		 	$("#oem_client_nm").val(data.client_nm); 		// data.실제컬럼이름
		 	$("#erp_copnm").val(data.cop_copnm); 			// data.실제컬럼이름
		 	$("#cop_no1").val(data.cop_no1); 				// data.실제컬럼이름
		 	$("#cop_no2").val(data.cop_no2); 				// data.실제컬럼이름
		 	$("#cop_no3").val(data.cop_no3); 				// data.실제컬럼이름
		 	$("#direct_nm").val(data.emp_nm); 				// data.실제컬럼이름
		 	$("#addr").val(data.addr); 						// data.실제컬럼이름
		 	$("#addr_other").val(data.addr_detail); 		// data.실제컬럼이름
		 	$("#limit_date").val(data.limit_date); 			// data.실제컬럼이름
		 	$("#client_search1").val(data.client_search); 	// data.실제컬럼이름
			//var client_search1 =  $("#client_search1").val(data.client_search).text();
		 	//console.log("client_search1 ", client_search1);

			// 담당자 번호 
			$("#local_tel2").val(data.emp_hp);	
			var beta0 = $("#local_tel1").val();
			var beta1 = $("#local_tel2").val();
			var beta1Answer = beta1.split("-");

			console.log("beta1Answer    ",beta1Answer);
			
			$("#local_tel2").val(beta1Answer[1]);
			var beta2 = $("#local_tel3").val();

			console.log("beta1Answer    ",beta1Answer[2]);
			$("#local_tel3").val(beta1Answer[2]);
			
			if(beta0 != beta1Answer[0]){
				console.log("beta0    " ,  beta0);
				
				$("#local_tel1").val(beta1Answer[0]);
			}
		}
	}
   
	/**  3.  처음 견적서 목록 뿌려주기 */
	function oemList(currentPage) {  
		currentPage = currentPage || 1;

		var client_search = $("#client_search").val();
		// 날짜 1
		var to_date = $("#to_date").val();
		// 날짜 2
		var from_date = $("#from_date").val();
		
        var param = {
        	currentPage : currentPage,
            pageSize : pageSizeOemList,
			client_search : client_search,
            to_date : to_date,
            from_date : from_date
        }

	    console.log(" param : " ,param);
		console.log("param.valueOf()",  param.valueOf());
		 
		//콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========");
		
			//목록 조회 결과 
			oemListResult(data,currentPage);
			console.log(" 목록뿌려주기 조회결과 data ",data);
		};
		
		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/receiveManagementList.do", "post", "text", true, param, resultCallback); //text
	}

	/**  3-1.목록조회 콜백 함수 */
	function oemListResult(data,currentPage) {
		console.log("목록조회 콜백함수 ",data);

		// 기존 목록 삭제
		$('#listOemManage').empty(); 
		// 신규 목록 생성
		$("#listOemManage").append(data);
		// 총 갯수 추출
		var oemCnt = $("#oemCnt").val();

		console.log("oemCnt ", oemCnt);

		// 네비게이션
		//	현재페이지  , 행 갯수 , 리스트사이즈 , 블록 갯수 , 목록리스트함수 
		var oemManageHtml = getPaginationHtml(
			currentPage, 
			oemCnt,
			pageSizeOemList,
			pageBlockSizeOemList,
			'oemList'
		);
		
		console.log("oemManageHtml  : " + oemManageHtml );

		//네비게이션 비우고 다시 채우기
		$("#OemPagination").empty().append( oemManageHtml );
		
		// BizCurrentPage 에 현재 페이지 설정
		$("#OemCurrentPage").val(currentPage);
		
		// 값이제대로 왔다 확인 
		var OemCurrentPage = $("#OemCurrentPage").val();
		console.log("OemCurrentPage " +  OemCurrentPage);
	}

	/** 4-1. 단건 조회 */
	function oemOne(estimate_no) {
		var param = {
			estimate_no:estimate_no
		};
		
		var resultCallback = function(data) {
			oemOneResult(data);
		};
		
		callAjax("/business/oeManagementSelect.do", "post", "json", true, param, resultCallback);
	}
	
	/**  4-2 단건 조회 콜백 함수*/
	function oemOneResult(data) {
		// 모달 팝업
		gfModalPop("#layer2");
			
		// 그룹코드 폼 데이터 설정
		oemInitForm(data.oempart); // 사업자 파트 데이터
			
		// 숫자 -> 한글로 , 데이터값 바로 박음 
		fn_change_hangul_money(data.oempart.supply_val, data.oempart.estimate_cnt, data.oempart.limit_data);
		
		// 사업자등록번호
		$("#erp_copnum2").val(data.erp_copnum);

		console.log("alpa1Answer    ",alpa1Answer[2]);

		$("#erp_tel3").val(alpa1Answer[2]);

		if(alpa0 != alpa1Answer[0]){
			console.log("beta0    " ,  beta0);
			$("#erp_tel1").val(alpa1Answer[0]);
		}

		// 단건조회의 foreach문으로 리스트 뿌리기 
		oemdetailList(data.oempart.estimate_no); 
	}
	
	// 4-3 단건조회의 리스트 뿌리기 
	function oemdetailList(estimate_no){
		console.log("단건 조회의 리스트 뿌리기 estimate_no ", estimate_no);
		
		var param = {
			estimate_no : estimate_no
	    }

		console.log(" param : " ,param);
		console.log("param.valueOf()",  param.valueOf());

		//콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========");
			
			//목록 조회 결과 
			oemDetailListResult(data);
			console.log(" 목록뿌려주기 조회결과 data ",data);
		};
			
		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/oeDetailList.do", "post", "text",  true,param, resultCallback); //text
	}
	
	// 4-4 단건조회의 리스트 뿌리기 콜백 
	function oemDetailListResult(data){
		// 기존 목록 삭제
		$('#OemDetailList1').empty(); 
		// 신규 목록 생성
		$("#OemDetailList1").append(data);
	}
	 
	/* 팝업내 수정, 저장 validation */
	function oValidatePopup(data){
		var chk = checkNotEmpty(
			[
				["client_search1", "업체명을 체크해주세요!"],
				["scm_big_class", "대분류를 체크해주세요!"],
				["scm_middle_class", "중분류를 체크해주세요!"],
				["product_cd", "제품을 체크해주세요!"],
				["estimate_cnt", "수량을 입력해주세요"]
			]
		); 
	 
	 	if(!chk){return;}
		return true;
	}
	/* 팝업내 수정, 저장 validation 끝 */
	 
	/*  신규 등록 및 저장  */
	function oSaveOem(){
		alert("저장 함수 타는지!!!!!?? ");
		 
		// validation 체크 
		if(!(oValidatePopup())){ return; }
		 
		var resultCallback = function(data){
			oSaveResult(data); // 저장 콜백 함수 
		};
	
		//폼이름 =>$("#myNotice").serialize() => 직렬화해서 name 값들을 그냥 넘김.
	 	callAjax("/business/oeManagementSave.do", "post", "json", true, $("#oemForm1").serialize(), resultCallback);
		// callAjax("estManagementSave.do", "post", "json", true,par am, resultCallback);
	}
	 
	/*  저장 & 수정  & 삭제 함수 콜백 함수 */
	function oSaveResult(data){
		if($("#action").val() != "I"){
			alert("신규등록합니다");
		}
		if(data.resultMsg == "SUCCESS"){
			alert(data.resultMsg);	// 받은 메세지 출력 
			alert("저장 되었습니다.");
		} else if(data.resultMsg == "UPDATED") {
			alert("수정 되었습니다.");
		} else if(data.resultMsg == "DELETED") {
			alert("삭제 되었습니다.");
		} else {
			alert(data.resultMsg); //실패시 이거 탄다. 
		}

		gfCloseModal();	// 모달 닫기

		oemInitForm();// 입력폼 초기화
	}

	//검색구현
	function oSearchOem(currentPage) {
		/* 달력=>datepicker 사용했음 
		document.ready에서 		
		$('#from_date').datepicker();
		$('#to_date').datepicker();  작성 후 검색구현 함수에서 값 가져오기  */
			
		currentPage = currentPage || 1;
	
		// 날짜 1
		var to_date = $("#to_date").val();
		// 날짜 2
		var from_date = $("#from_date").val();
			
		console.log('to_date' , to_date);
		console.log('from_date' , from_date);

		// 거래처 넘기기 
		var client_search =   $("#client_search").val();
			
		// 값 내용물 
		console.log("from_date : " + from_date.valueOf());     
		console.log("to_date : " + to_date.valueOf());     
		
        var param = {
        	client_search : client_search,
            currentPage : currentPage,
            pageSize : pageSizeOemList, 
            from_date : from_date, 
            to_date : to_date 
        }
        
	    console.log(" param : " ,param);
		console.log("param.valueOf()",  param.valueOf());
		
		var resultCallback = function(data) {
			console.log("=======resultCallback========");
		
			//목록 조회 결과 
			oemListResult(data,currentPage);
			console.log(" 검색 조회결과 data ",data);
		};
		
		// 목록조회에 던져준다.
		/*  순서 주의 :  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/oeManagementList.do", "post", "text",  true,param, resultCallback); //text       
	} 
	 	
	/**  견적서 모달 안 리스트  */
	function oemDetailList(currentPage) {  
		currentPage = currentPage || 1;

		// 날짜 1
		var to_date = $("#to_date").val();
		// 날짜 2
		var from_date = $("#from_date").val();
		
        var param = {
			currentPage : currentPage,
            pageSize : pageSizeOemList,
         	// 뷰단에 남아있는 날짜 데이터 넣어줘서 다시 조회
            to_date:to_date, 
            from_date:from_date
        }

	    console.log(" param : " ,param);
		console.log("param.valueOf()",  param.valueOf());
		
		//콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========");
		
			//목록 조회 결과 
			oemListDetailResult(data);
			console.log(" 목록뿌려주기 조회결과 data ",data);
		};
		
		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/oeManagementSave.do", "post", "text",  true,param, resultCallback); //text
	}

	/**  견적서 모달 안 리스트  함수  */
	function oemListDetailResult(data,currentPage) {
		console.log("목록조회 콜백함수 ",data);

		// 기존 목록 삭제
		$('#listOemManage1').empty(); 
		// 신규 목록 생성
		$("#listOemManage1").append(data);
		// 총 갯수 추출
		var oemCnt = $("#oemCnt").val();
		
		console.log("oemCnt ", oemCnt);
		
		// 네비게이션
		//	현재페이지  , 행 갯수 , 리스트사이즈 , 블록 갯수 , 목록리스트함수 
		var oemManageHtml = getPaginationHtml(
			currentPage, 
			oemCnt,
			pageSizeOemList ,  
			pageBlockSizeOemList,
			'oemList'
		);
		
		console.log("oemManageHtml  : " + oemManageHtml );

		//네비게이션 비우고 다시 채우기
		$("#OemPagination").empty().append( oemManageHtml );
		
		// BizCurrentPage 에 현재 페이지 설정
		
		// 값이제대로 왔다 확인 
		var OemCurrentPage = $("#OemCurrentPage").val();
		console.log("OemCurrentPage " +  OemCurrentPage);
	}

	// scm 대분류,중분류,제품 콤보박스 
	function selectmidcat() {
		var largecd = $("#scm_big_class").val();
		// 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
	  	productCombo("m", "scm_middle_class", "all", largecd);     
	
	  	$("#scm_middle_class").find("option").remove();
	  	$("#scm_product").find("option").remove();
	} 
	
	function selectproductlistcombo() {
	  	var margecd = $("#scm_middle_class").val();
	 // 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
	  	productCombo("p", "product_cd", "all", margecd);     
	}
</script>
</head>
<body>
	<form id="oemForm1" action=""  method="">
		<input type="hidden" id="OemCurrentPage" value="1">
	    <input type="hidden" name="action" id="action" value="">
	     
		<!-- 모달 배경 -->
		<div id="mask"></div>
		
		<div id="wrap_area">
		    <h2 class="hidden">header 영역</h2>
		    <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	
	      	<h2 class="hidden">컨텐츠 영역</h2>
	      	<div id="container">
	        	<ul>
		            <li class="lnb">
		            	<!-- lnb 영역 --> 
		            	<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
		            	<!--// lnb 영역 -->
		            </li>
	            
	            	<li class="contents">
	                	<!-- contents -->
	               		<h3 class="hidden">contents 영역</h3> <!-- content -->
	               		<div class="content">
	                  		<p class="Location">
	                     		<a href="#" class="btn_set home">메인으로</a> 
	                     		<a href="#" class="btn_nav">영업</a> 
	                     		<span class="btn_nav bold"> 수주서 작성 및 조회 </span> 
	                        	<a href=javascript:location.reload(); class="btn_set refresh">새로고침</a>
	                  		</p>
	
	                  		<p class="conTitle">
	                     		<span>수주서 작성 및 조회</span> 
	                     		<span class="fr"> 
		                     		<a class="btnType blue" href="javascript:receiveModal1();" name="modal">
		                     			<span>수주서 신규등록</span>
		                     		</a>
	                     		</span>
	                  		</p>
	
					        <!-- 검색조회 -->
					        <!-- form 안에 form이 맞나? 버튼두고 자바스크립트로  보내기  자바스크립트 함수 하나 만들기   xxxxxx안하기로 함  -->        
					        <!--  == 콤보박스로 체크  -->   
		     
	                 		<!--검색   -->
	                 		<br>       
				                    
			  				<div style = "padding : 3% 10% 3% 13%  ; border : 3px #CDECFA; border-style : solid ; margin: auto;">
								<!-- 거래처 콤보박스   -->
								<div style ="margin: auto" >	
									<b style ="padding: 0 1% 0 1%" >거래처</b>
									<select name="client_search" id ='client_search'></select>
		                  			<!-- 달력 조회  -->
									<b style ="padding: 0 3% 0 5%">날짜 </b>
									<input type="text" id="from_date"  style="padding : 0.5%;"> ~ <input type="text" id="to_date"  style="padding : 0.5% 0 0.5% 0;" >
						
									<a href="" class="btnType blue" id="btnSearchOem" name="btn" style ="float : right; ">
								 		<span>조회</span>
									</a> 
								</div>
	                  		</div>
	                   		<!-- 검색조건 끝 -->
								
		                	<!-- 조회목록 윗칸띄우기 -->
		                  	<div class="zldf" style ="padding-top: 2%;margin: auto;"> </div>
	                    	<table class="col">
		                        <caption>caption</caption>
		                        <colgroup>
		                           <col width="10%">
		                           <col width="7%">
		                           <col width="15%">
	                               <col width="10%">
		                           <col width="18%">
		                           <col width="15%">
		                           <col width="8%">
		                           <col width="7%">
		                           <col width="10%">
		                        </colgroup>

		                        <thead>
		                        	<tr>
										<th scope="col">회사</th>
										<th scope="col">담당자</th>
			                        	<th scope="col">거래처</th>
			                        	<th scope="col">거래처담당자</th>
			                            <th scope="col">수주번호</th>
			                            <th scope="col">수주일자</th>
			                            <th scope="col">총 갯수</th>
			                            <th scope="col">총 합계</th>
			                            <th scope="col"></th>
		                           	</tr>
		                        </thead>
	
		                        <tbody id="listOemManage"></tbody> <!--BizParnerCallBack으로 넘어감.여기는 틀만 만드는곳  -->
                     		</table>
		                  	<!-- 페이징에리어 -->
							<div class="paging_area" id="OemPagination"></div>
						</div>
					</li>
				</ul> 
	            <!-- content end -->
	        </div>
			<h3 class="hidden">풋터 영역</h3>
	        <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
		</div>
		<jsp:include page="/WEB-INF/view/business/ReceiveInfoInsert.jsp"></jsp:include>
	</form>	   
	<jsp:include page="/WEB-INF/view/business/ReceiveManagementModal.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/business/ReceiveProdInsert.jsp"></jsp:include>

</body>
</html>