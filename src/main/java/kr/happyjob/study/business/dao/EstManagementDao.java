package kr.happyjob.study.business.dao;

import kr.happyjob.study.business.dto.EstListDetailDto;
import kr.happyjob.study.business.dto.EstListDto;
import kr.happyjob.study.business.dto.SelectEstListDto;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.UserInfoVo;

import java.util.List;
import java.util.Map;

public interface EstManagementDao {
	
	//견적서 전체조회
	public List<EstListDto> estList(Map<String, Object> paramMap) throws Exception;
	//견적서 전체 조회 카운트
	public int estCnt(Map<String, Object> paramMap);

	/** 리스트 목록 단건 조회 => 견적서 상세조회 */
	public SelectEstListDto selectEstList(Map<String, Object> paramMap);

	//모달 안 리스트 조회
	public List<EstListDetailDto> estListDetail (Map<String, Object> paramMap) throws Exception;
	
	//모달 안 리스트 조회 카운트
	public int estDetailCnt(Map<String, Object> paramMap);

	/** 견적서 신규 저장 */
	public int  insertEstList(Map<String, Object> paramMap);
	// 견적제품 인서트 
	public int updateInsertEstList(Map<String, Object> paramMap);

	/** 단건수정 */
	public int updateEstList(Map<String, Object> paramMap);

	/** 단건 삭제 */
	public int deleteEstList(Map<String, Object> paramMap);

	/** 로그인 아이디 찾기 */
	public UserInfoVo searchLoginId(String loginId);

	/** 클라이언트 찾기 */
	public ErpClientVo searchClient(Map<String, Object> paramMap);
}
