package kr.happyjob.study.business.service;

import kr.happyjob.study.business.dao.ReceiveManagementDao;
import kr.happyjob.study.business.dto.InsertTableSelectDto;
import kr.happyjob.study.business.dto.ReceiveListDto;
import kr.happyjob.study.business.dto.SelectClientListDto;
import kr.happyjob.study.business.model.OeManagementModel;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.ReceiveInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReceiveManagementServiceImpl implements ReceiveManagementService {
	@Autowired
    ReceiveManagementDao receiveManagementDao;

	@Override
	/** 상세 계정 목록 조회 */
	public List<ErpClientVo> selectClientList(Map<String, Object> paramMap) {
		return receiveManagementDao.selectClientList(paramMap);
	}
	
	//리스트 목록 조회
	@Override
	public List<ReceiveListDto> ReceiveList(Map<String, Object> paramMap) throws Exception {
		return receiveManagementDao.ReceiveList(paramMap);
	}

	//리스트 목록 카운트  => 매퍼의 리스트 관계 확인
	@Override
	public int receiveCnt(Map<String, Object> paramMap) {
		return receiveManagementDao.receiveCnt(paramMap);
	}

	@Override
	/** 견적생성시 tb_receive_info 정보 불러오기 */
	public InsertTableSelectDto InsertTableSelect(Map<String, Object> paramMap) { return receiveManagementDao.InsertTableSelect(paramMap); }

	/** receiveInfoVo 불러오기 */
	@Override
	public ReceiveInfoVo InsertReceiveInfo(Map<String, Object> paramMap) { return receiveManagementDao.InsertReceiveInfo(paramMap); }

	//단건조회
	@Override
	public OeManagementModel selectOemList(Map<String, Object> paramMap) {
		return receiveManagementDao.selectOemList(paramMap);
	}

	
	//단건 신규등록
	@Override
	public int receiveInfoInsert(Map<String, Object> paramMap) {
		return receiveManagementDao.receiveInfoInsert(paramMap);
	}

	//단건 업데이트
	@Override
	public int updateOemList(Map<String, Object> paramMap) {
		return receiveManagementDao.updateOemList(paramMap);
	}

	// 단건 삭제 
	@Override
	public int deleteOemList(Map<String, Object> paramMap) {
		return receiveManagementDao.deleteOemList(paramMap);
	}

	// 모달 안 리스트 뿌리기
	@Override
	public List<OeManagementModel> oemListDetail(Map<String, Object> paramMap) throws Exception {
		return receiveManagementDao.oemListDetail(paramMap);
	}
	
	// 모달 안 리스트 뿌리기 카운트 
	@Override
	public int oemDetailCnt(Map<String, Object> paramMap) {
		return receiveManagementDao.oemDetailCnt(paramMap);
	}

	// 계정금액 인서트 3번  
	@Override
	public int insertAccSlip1(Map<String, Object> paramMap) {
		return receiveManagementDao.insertAccSlip1(paramMap);
	}

	@Override
	public int insertAccSlip2(Map<String, Object> paramMap) {
		return receiveManagementDao.insertAccSlip2(paramMap);
	}

	@Override
	public int insertAccSlip3(Map<String, Object> paramMap) {
		return receiveManagementDao.insertAccSlip3(paramMap);
	}
	
	//수주서 인서트
	@Override
	public int updateInsertOemList(Map<String, Object> paramMap) throws Exception {
		return receiveManagementDao.updateInsertOemList(paramMap);
	}

	// order table에 인서트
	@Override
	public int insertOrderOemList(Map<String, Object> paramMap) {
		return receiveManagementDao.insertOrderOemList(paramMap);
	}
}
