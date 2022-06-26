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

<!-- 거래처 관리  -->
<style>
	#layer1,#layer2 {
		overflow-y: scroll;
	}
</style>

<script type="text/javascript">
	// 페이징 설정 
	var pageSizeOemList = 5; // 행 다섯개 
	var pageBlockSizeOemList = 5;  // 블록 갯수 일단 출력

	// 금액 => 한글로 치환 해주는 함수 
	
	// 1 ~ 9 한글 표시
    var arrNumberWord = new Array("","일","이","삼","사","오","육","칠","팔","구");
    // 10, 100, 100 자리수 한글 표시
    var arrDigitWord = new  Array("","십","백","천");
    // 만단위 한글 표시
    var arrManWord = new  Array("","만","억", "조");
   
    /* 	 // 체크박스 클릭 
	$("input:checkbox[name=client_search1]:checked").each(function(){
		var chckVal = $(this).val();
		console.log("chckVal ", chckVal);
		 
	}) */

 /* -------------------------------------------------------------------  */
 /* -------------------------------------------------------------------  */
   
	// 함수 시작
	$(document).ready(function(){
		//견적서 목록 조회 
		 oemList();
		
		//모달창 초기화
		 oemInitForm();
			
		// 버튼 이벤트 등록
		oRegisterButtonClickEvent();
		
		//콤보박스 함수
		// 조회 종류  
		//부서 : dept 	// acc : 회계계정  		//cli:거래처  
		//pro:싱품  //whp: 창고담당자 //wh: 창고
		// Combo Name, Option("all" : 전체     "sel" : 선택 , NULL)         
		// -> 처음목록 & 검색용  거래처이름 
		selectComCombo("cli", "client_search", "all", "");   

		// -> 견적서등록 모달용 거래처 이름
		selectComCombo("cli", "client_search1", "all", "");   

		productCombo("l", "scm_big_class", "all", "");
		
		// 달력api datepicker 사용 선언 
		$('#from_date').datepicker();
		$('#to_date').datepicker();
	});

	/* -------------------------------------------------------------------  */
	/* -------------------------------------------------------------------  */

	/** 버튼 이벤트 등록 */
	function oRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnIdEst = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

			switch (btnIdEst) {
				case 'btnUpdateOem' : // 신규등록 , 저장 
					oSaveOem();
					break;
				case 'btnDeleteOem' : // 삭제 
					oDeleteOem();
					break;
				case 'btnSearchOem': // 검색 
					oSearchOem();
					break;
				case 'btnCloseOem' : // 모달 닫기 함수 [나는 하나로 썼음 ]
					gfCloseModal();
					break;
			}
		});
	}
	
	/* -------------------------------------------------------------------  */
	/* -------------------------------------------------------------------  */

	/*  1. 견적서 신규 등록 모달  :  모달 실행 */
 	function oemModal1(estimate_no){
    	// 신규 저장  - 데이터 없음
		if (estimate_no == null || estimate_no =="") {
	    	// Tranjection type 설정
	        $("#action").val("I");
	        //모달창 수정쪽  초기화 
	        oemInitForm();
			var client_search1 = $("#client_search1").val();
			var receive_num = $("#receive_num").val();
			var scm_big_class = $('#scm_big_class').val();
			var scm_middle_class =  $('#scm_middle_class').val();
			var divproducttall =  $('#divproducttall').val();
			 
			
			console.log("액션 I : 신규 등록");
			console.log("client_search1  client_search1 " ,  client_search1);
			console.log("scm_big_class  scm_big_class " ,  scm_big_class);
			console.log("scm_middle_class  scm_middle_class " ,  scm_middle_class);
			console.log("divproducttall  divproducttall " ,  divproducttall);
	         
	        // 모달 팝업         	
			gfModalPop("#layer1");
	      }	
	   }
	/* 신규 등록모달 끝   */
		
/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  1-1  ReadOnly 모달 / 삭제  수정 가능  =>  erp에서 연결하지 않는 이상은 수정 삭제 가능  :  모달 실행 */
	function oemModal2(estimate_no){
		if (estimate_no != null || estimate_no !="") {
	   		// readonly 붙이기 
			$("#loginID").attr("readonly", true);
	        // Tranjection type 설정
	        $("#action").val("U");

	        // 모달 팝업         	
			gfModalPop("#layer2");
				
		}
	}

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  2 .단건조회 등등  모달창 값 초기화  */
	function oemInitForm(data) {
		$("#oemCnt").focus();	
		
		//2 - 1 신규등록	일 때
		if( data == "" || data == null || data == undefined) {
			$("#receive_num").val("");  // hidden 
			$("#estimate_no").val("");  // hidden 
			$("#client_search1").val(""); // 거래처 콤보박스
			$("#scm_big_class").val(""); // scm 대분류
			$("#scm_middle_class").val(""); // scm 중분류
			$("#divproducttall").val(""); // scm 제품
			$("#estimate_cnt").val(""); //수량
			$('#divtitle').empty();
			$("#divtitle").append("<strong>수주서 등록</strong>");
		} else {
			//2 - 2 단건 상세조회 모달창 
	 		$("#oem_client_nm").val(data.client_nm); // data.실제컬럼이름
		 	$("#limit_date").val(data.limit_date); // data.실제컬럼이름
		 	$("#oem_client_nm").val(data.client_nm); // data.실제컬럼이름
		 	$("#erp_copnm").val(data.cop_copnm); // data.실제컬럼이름
		 	$("#cop_no1").val(data.cop_no1); // data.실제컬럼이름
		 	$("#cop_no2").val(data.cop_no2); // data.실제컬럼이름
		 	$("#cop_no3").val(data.cop_no3); // data.실제컬럼이름
		 	$("#direct_nm").val(data.emp_nm); // data.실제컬럼이름
		 	$("#addr").val(data.addr); // data.실제컬럼이름
		 	$("#addr_other").val(data.addr_detail); // data.실제컬럼이름
		 	$("#limit_date").val(data.limit_date); // data.실제컬럼이름
		 	$("#client_search1").val(data.client_search); // data.실제컬럼이름
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

		var client_search =   $("#client_search").val();
		// 날짜 1
		var to_date = $("#to_date").val();
		// 날짜 2
		var from_date = $("#from_date").val();
		
        var param = {
        	currentPage : currentPage,
            pageSize : pageSizeOemList,
			client_search:client_search,
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
			oemListResult(data,currentPage);
			console.log(" 목록뿌려주기 조회결과 data ",data);
		};
		
		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/oeManagementList.do", "post", "text",  true,param, resultCallback); //text
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
			pageSizeOemList ,  
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
		fn_change_hangul_money(data.oempart.supply_val,data.oempart.estimate_cnt,data.oempart.limit_data);
		
		// 사업자등록번호
		$("#erp_copnum2").val(data.erp_copnum);	
		var beta0 = $("#erp_copnum1").val();
		var beta1 = $("#erp_copnum2").val();
		var beta1Answer = beta1.split("-");
		console.log("beta1Answer    ",beta1Answer);
	
		$("#erp_copnum2").val(beta1Answer[1]);
		var beta2 = $("#erp_copnum3").val();
		console.log("beta1Answer    ",beta1Answer[2]);
		$("#erp_copnum3").val(beta1Answer[2]);
		if(beta0 != beta1Answer[0]){
			console.log("beta0    " ,  beta0);
			$("#erp_copnum1").val(beta1Answer[0]);
		}
	
		// 담당자 
		$("#emp_name").val(data.erp_emp);	
		
		//주소
		$("#erp_addr").val(data.erp_addr);	
		
		// 상세 주소
		$("#erp_addr_other").val("전체");	
		
		// 전화번호
		$("#erp_tel2").val(data.erp_tel);	
		var alpa0 = $("#erp_tel1").val();
		var alpa1 = $("#erp_tel2").val();
		var alpa1Answer = alpa1.split("-");
		console.log("alpa1Answer    ",alpa1Answer);
		$("#erp_tel2").val(alpa1Answer[1]);
		var alpa2 = $("#erp_tel3").val();
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
				["divproducttall", "제품을 체크해주세요!"],
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
	function  oSaveResult(data){
		var client_search1 = $("#client_search1").val();
		var estimate_no = $("#estimate_no").val();
		var receive_nm = $("#receive_nm").val();
		var scm_big_class = $('#scm_big_class').val();
		var scm_middle_class =  $('#scm_middle_class').val();
		var divproducttall =  $('#divproducttall').val();
			 
		console.log("액션 I : 신규 등록");
		console.log("client_search1  client_search1 " ,  client_search1);
		console.log("scm_big_class  scm_big_class " ,  scm_big_class);
		console.log("scm_middle_class  scm_middle_class " ,  scm_middle_class);
		console.log("divproducttall  divproducttall " ,  divproducttall);
		
		var currentPage = currentPage || 1; 
	
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
	
	/*  삭제 */
/* 	function eDeleteEst(){
		 var con = confirm("정말 삭제하겠습니까? \n 삭제시 복구불가합니다."); 
		 if(con){
			 var resultCallback = function(data){
				 eSaveResult(data); // 삭제한걸 저장
			 }																				 	// serialize => 함수를 json형태로 정렬한다 
			 callAjax("/business/estManagementListDelete.do", "post", "json", true, $("#Form").serialize(), resultCallback);
		
		 }else{
			 gfCloseModal();	// 모달 닫기
			 estList(currentPage); // 목록조회 함수 다시 출력 
			 estInitForm();// 입력폼 초기화
		 }
	 }
	  */
	 
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
		
		
		
		
	// 금액 -> 한글로 변환
	// Copyright 취생몽사(http://bemeal2.tistory.com)
	// 소스는 자유롭게 사용가능합니다. Copyright 는 삭제하지 마세요.
	function fn_change_hangul_money(alpadata) {
    	var alpadata = String(alpadata);
        console.log("typeof ", typeof(alpadata));
        var num_length = alpadata.length;

        var betadata = betadata;
 
        console.log("======> alpadata ", alpadata );
        console.log("======> betadata ", betadata );
        console.log("======> num_length ", num_length );
            
        if(isNaN(alpadata) == true)
              return;



        var han_value = "";
        var man_count = 0;      // 만단위 0이 아닌 금액 카운트.



        for(i=0; i < alpadata.length; i++)
        {
        	
        	console.log("======>alpadata " ,alpadata);
              // 1단위의 문자로 표시.. (0은 제외)
              var strTextWord = arrNumberWord[alpadata.charAt(i)];



              // 0이 아닌경우만, 십/백/천 표시
              if(strTextWord != "")
              {
                    man_count++;
                    strTextWord += arrDigitWord[(num_length - (i+1)) % 4];
              }


              // 만단위마다 표시 (0인경우에도 만단위는 표시한다)
              if(man_count != 0 && (num_length - (i+1)) % 4 == 0)
              {
                    man_count = 0;
                    strTextWord = strTextWord + arrManWord[(num_length - (i+1)) / 4];
              }

              han_value += strTextWord;
        }

        if(alpadata != 0)
              han_value = "금 " + han_value + " 원";
        
        // 값 넣기 
        $("#txt_money").val( han_value);

        $("#limit_date").val( alpadata.limit_date);
	}

		

			
	// scm 대분류,중분류,제품 콤보박스 
	function selectmidcat(){
		var largecd = $("#scm_big_class").val();
		// 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
	  	productCombo("m", "scm_middle_class", "all", largecd);     
	
	  	$("#scm_middle_class").find("option").remove();
	  	$("#scm_product").find("option").remove();
	} 
	
	function selectproductlistcombo(){
	  	var margecd = $("#scm_middle_class").val();
	 // 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
	  	productCombo("p", "divproducttall", "all", margecd);     
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
		                     		<a class="btnType blue" href="javascript:oemModal1();" name="modal">
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
		                           <col width="17%">
		                           <col width="17%">
		                           <col width="17%">
	                               <col width="19%">
		                           <col width="10%">
		                           <col width="10%">
		                           <col width="10%">
		                        </colgroup>
		                        
		                        
		                        <thead>
		                        	<tr>
			                        	<th scope="col">견적서번호</th>
			                            <th scope="col">수주번호</th>
			                            <th scope="col">거래처</th>
			                            <th scope="col">제품이름</th>
			                            <th scope="col">단가</th>
			                            <th scope="col">부가세</th>
			                            <th scope="col">공급가액</th>
		                           	</tr>
		                        </thead>
	
		                        <tbody id="listOemManage"></tbody> <!--BizParnerCallBack으로 넘어감.여기는 틀만 만드는곳  -->
                     		</table>
		                  	<!-- 페이징에리어 -->
							<div class="paging_area"  id="OemPagination"></div>
						</div>
					</li>
				</ul> 
	            <!-- content end -->
	        </div>
			<h3 class="hidden">풋터 영역</h3>
	        <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
		</div>
	
		<!-- 모달팝업 ==  신규 등록 1 -->
		<div id="layer1" class="layerPop layerType2"  style="width: 800px;">
			<dl>
		    	<dt>
		        	<div id="divtitle" style="color:white">수주서 신규등록</div>
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
		                	<tr>
								<!-- 목록조회 외에 UPDATE, INSERT , DELETE 등을 위해 필요함  hidden 값  // INT가 아닌것도 있음  -->
								<td hidden=""><input type="text" class="inputTxt p100" name="receive_num" id="receive_num" /></td> 
		                     	<th scope="row">거래처 이름<span class="font_red">*</span></th>
		                     	<td hidden=""><input type="hidden" id="client_nm"></td>
		                     				
								<td><!-- 거래처 콤보박스   -->
									<select name="client_search1" id ='client_search1'></select>	
								</td>
		                	</tr>
		                  	<tr>
		                    	<th scope="row">대분류<span class="font_red">*</span></th>
                  					<td>
									<select id="scm_big_class" name="scm_big_class" onChange="javascript:selectmidcat();"></select>
								</td>
                             	<th scope="row">중분류<span class="font_red">*</span></th>
								<td>
									<select id="scm_middle_class" name="scm_middle_class" onChange="javascript:selectproductlistcombo();"></select>
								</td>
		                  	</tr>
			          
		                  	<tr>
                            	<th scope="row">제품<span class="font_red">*</span></th>
								<td>
									<select id="divproducttall" name="divproducttall"></select>
								</td>
								<th scope="row">수량</th>
		                    	<td colspan="3">
		                    		<input type='number' name="oem_cnt" id="oem_cnt"  />
                   			 	</td>
		                	</tr>
						</tbody>
					</table>
		            <div class="btn_areaC mt30">
		            	<a href="" class="btnType blue" id="btnUpdateOem" name="btn"><span>등록</span></a> 	
						<a href="" class="btnType gray"  id="btnCloseOem" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		<!-- 모달1 끝 -->
	</form>	   
	<jsp:include page="/WEB-INF/view/business/OeManagementModal.jsp"></jsp:include>
</body>
</html>