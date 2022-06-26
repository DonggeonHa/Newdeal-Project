package kr.happyjob.study.accounting.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/accounting")



public class DvController {
	
	/* 지출결의서  초기화면  호출(신청페이지)   : 권한 - 회계 총무 / 관리자 / 임원 */
	
	@RequestMapping("empDv.do")
	public String initEmpDv(HttpSession session) throws Exception {
		

		
		return "accounting/dvmain"; /* 호출할 jsp 파일명 */
	}
	
	
	
	
}

	



