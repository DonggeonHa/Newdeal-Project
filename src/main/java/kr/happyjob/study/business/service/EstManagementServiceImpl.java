package kr.happyjob.study.business.service;

import kr.happyjob.study.business.dao.EstManagementDao;
import kr.happyjob.study.business.model.EstManagementModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class EstManagementServiceImpl implements EstManagementService{

	@Autowired
	EstManagementDao estManagementDao;
	
	//리스트 목록 조회
	@Override
	public List<EstManagementModel> estList(Map<String, Object> paramMap) throws Exception {
		return estManagementDao.estList(paramMap);
	}
	

	//리스트 목록 카운트  => 매퍼의 리스트 관계 확인
	@Override
	public int estCnt(Map<String, Object> paramMap) {
		return estManagementDao.estCnt(paramMap);
	}

	
	//단건조회
	@Override
	public EstManagementModel selectEstList(Map<String, Object> paramMap) {
		return estManagementDao.selectEstList(paramMap);
	}

	
	//단건 신규등록
	@Override
	public int insertEstList(Map<String, Object> paramMap) {
		return estManagementDao.insertEstList(paramMap);
	}

	//단건 업데이트
	@Override
	public int updateEstList(Map<String, Object> paramMap) {
		return estManagementDao.updateEstList(paramMap);
	}

	// 단건 삭제 
	@Override
	public int deleteEstList(Map<String, Object> paramMap) {
		return estManagementDao.deleteEstList(paramMap);
	}

	// 모달 안 리스트 뿌리기
	@Override
	public List<EstManagementModel> estListDetail(Map<String, Object> paramMap) throws Exception {
		return estManagementDao.estListDetail(paramMap);
	}
	// 모달 안 리스트 뿌리기 카운트 
	@Override
	public int estDetailCnt(Map<String, Object> paramMap) {
		return estManagementDao.estDetailCnt(paramMap);
	}

	// 견적서,견적 제품에  넘버 넣고 -> 이후 견적제품에 업데이트  
	@Override
	public int updateInsertEstList(Map<String, Object> paramMap) throws Exception {
		return estManagementDao.updateInsertEstList(paramMap);
	}
}