<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	#est_client_nm, #erp_copnm {
		background-color: #BBC1CD;
		font-weight:bolder;
		text-align: center;
	}  
</style>

<!-- 모달이 여러개라 id값 name값 다르게-->


<!-- 모달팝업2 ==  readOnly -->
<div id="layer2" class="layerPop layerType2"  style="width: 800px;">
	<dl>
    	<dt>
        	<div id="divtitle" style="color:white"><b>견적서 상세 조회</b></div>
     	</dt>
    	<dd class="content">
	        <!-- s : 여기에 내용입력 -->
	        <table class="row">
	        	<caption>caption</caption>
	        	<colgroup>
	            	<col width="15%">
	            	<col width="35%">
	            	<col width="15%">
	            	<col width="35%">
				</colgroup>
	
				<tbody>
	            	<tr>
	                	<th scope="row" colspan="2"> 
							<p id="cliName" />
	                	</th>
	                    <th scope="row" colspan="2">
							<p id="erp_copnm" />
	                    </th>
	                </tr>
	                <tr>
	                	<!-- 목록조회 외에 UPDATE, INSERT , DELETE 등을 위해 필요함  hidden 값  // INT가 아닌것도 있음  -->
	                	<td hidden="">
	                		<input type="text" class="inputTxt p100" name="estimateNo" id="estimateNo" />
	                	</td> 
	                  	   
	                  	<th scope="row">사업자등록번호</th>
	                  	<td class="inputTxt p100">
							<p id="copNo" />
	                    </td>
						<th scope="row">사업자등록번호</th>
	                 	<td class="inputTxt p100">
							<p id="erp_copnum"></p>
	                   	</td>
					</tr>
	              	<tr>
	                	<th scope="row">담당자</th>
	                 	<td>
							<p id="empNm"></p>
	                 	</td>
	                  	<th scope="row">담당자</th>
	                 	<td>
							<p id="erp_emp"></p>
	                 	</td>
					</tr>
	              	<tr>
	                	<th scope="row">주소</th>
	                 	<td>
							<p id="addr"></p>
	                 	</td>
	                 	<th scope="row">주소</th>
	                  	<td>
							<p id="erp_addr"></p>
	                  	</td>
	              	</tr>
	              	<tr>
	                	<th scope="row">나머지주소</th>
	                 	<td>
							<p id="addrDetail"></p>
	                 	</td>
	                 	<th scope="row">나머지주소</th>
	                  	<td>
							<p id="erp_addrDetail"></p>
	                  	</td>
	              	</tr>
	               	<tr> 	   
	               		<th scope="row">TEL</th>
	                  	<td class="inputTxt p100">
							<p id="empHp"></p>
	  					</td>
	  			 		<th scope="row">TEL</th>
	                 	<td class="inputTxt p100">
							<p id="erp_tel"></p>
	         			</td>
	              	</tr>
	       			<!-- 거래처 + erp 회사 정보 끝 -->
	       			<!--  한 칸 띄우기  -->
	        	  	<tr>
						<td colspan="4" class="inputTxt p100"></td>
	           		</tr>
	    			<tr>
	                	<td scope="row" colspan="4">
	                		<p id="bigo" />
	                 	</td>
	           		</tr>
	      			<tr>
	 			 		<th scope="row">견적작성일</th>
	                 	<td class="inputTxt p100" colspan="3">
							<p id="estimateDate"></p>
	             		</td>
	              	</tr>
	                <table class="col">
						<caption>caption</caption>
	                   	<colgroup>
	                    	<col width="35%">
	                      	<col width="15%">
	                       	<col width="10%">
	                      	<col width="10%">
	                      	<col width="10%">
	                      	<col width="10%">
	                      	<col width="10%">
	                   	</colgroup>
	                  	<thead>
	                    	<tr>
	                        	<th scope="col">품목정보</th>
	                         	<th rowspan="2">납기일</th>
	                         	<th colspan="5">공급가액</th>
	                      	</tr>
							<tr>
								<th scope="col">제품명</th>
								<th scope="col">수량</th>
								<th scope="col">단가</th>
								<th scope="col">공급가액</th>
								<th scope="col">부가세</th>
								<th scope="col">총금액</th>
							</tr>
	                   	</thead>
	                   	<!--  detail 끼워넣기  -->
	                	<tbody id="EstDetaillist"></tbody>    
	        		</table>
	        		<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnUpdateEst" name="btn"><span>수정</span></a>
	            		<a href="" class="btnType gray" id="btnCloseEst" name="btn"><span>취소</span></a>
	         		</div>
	   				<a href="" class="closePop"><span class="hidden">닫기</span></a>
				</tbody>
			</table>
		</dd>
	</dl>
</div>
<!-- 모달2 끝 -->

		  
