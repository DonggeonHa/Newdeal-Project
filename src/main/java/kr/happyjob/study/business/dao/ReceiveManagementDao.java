package kr.happyjob.study.business.dao;

import kr.happyjob.study.business.dto.InsertTableSelectDto;
import kr.happyjob.study.business.dto.ReceiveListDto;
import kr.happyjob.study.business.dto.SelectClientListDto;
import kr.happyjob.study.business.model.OeManagementModel;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.EstimateInfoVo;
import kr.happyjob.study.business.vo.ReceiveInfoVo;

import java.util.List;
import java.util.Map;

public interface ReceiveManagementDao {
	/** 상세 계정 목록 조회 */
	public List<ErpClientVo> selectClientList(Map<String, Object> paramMap);

	//견적서 전체조회
	public List<ReceiveListDto> ReceiveList(Map<String, Object> paramMap) throws Exception;

	//견적서 전체 조회 카운트
	public int receiveCnt(Map<String, Object> paramMap);

	/** 견적생성시 tb_receive_info 정보 불러오기 */
	public InsertTableSelectDto InsertTableSelect(Map<String, Object> paramMap);

	/** receiveInfoVo 불러오기 */
	public ReceiveInfoVo InsertReceiveInfo(Map<String, Object> paramMap);

	/** 리스트 목록 단건 조회 => 견적서 상세조회 */
	public OeManagementModel selectOemList(Map<String, Object> paramMap);

	//모달 안 리스트 조회
	public List<OeManagementModel> oemListDetail (Map<String, Object> paramMap) throws Exception;
	
	//모달 안 리스트 조회 카운트
	public int oemDetailCnt(Map<String, Object> paramMap);

	// 계정금액 인서트 세번
	public int  insertAccSlip1(Map<String, Object> paramMap); // 단가
	public int  insertAccSlip2(Map<String, Object> paramMap); // 세금
	public int  insertAccSlip3(Map<String, Object> paramMap); // 공급가액
	
	/** 수주  안서트 */
	public int  receiveInfoInsert(Map<String, Object> paramMap);
	// 수주 제품 인서트 
	public int updateInsertOemList(Map<String, Object> paramMap);
	// scm order table 인서트  
	public int insertOrderOemList(Map<String, Object> paramMap);

	/** 단건수정 */
	public int updateOemList(Map<String, Object> paramMap);

	/** 단건 삭제 */
	public int deleteOemList(Map<String, Object> paramMap);
}
