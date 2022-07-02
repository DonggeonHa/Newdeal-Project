package kr.happyjob.study.business.service;

import kr.happyjob.study.business.dao.OeManagementDao;
import kr.happyjob.study.business.model.OeManagementModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class OeManagementServiceImpl implements OeManagementService{
	@Autowired
	OeManagementDao oeManagementDao;
	
	//리스트 목록 조회
	@Override
	public List<OeManagementModel> oemList(Map<String, Object> paramMap) throws Exception {
		
		List<OeManagementModel> listOem = oeManagementDao.oemList(paramMap);
		
		System.out.println("==================");
		System.out.println("listOem "+  listOem);
		System.out.println("listOem.size() "+listOem.size());
		System.out.println("==================");
		return listOem;
	}
	

	//리스트 목록 카운트  => 매퍼의 리스트 관계 확인
	@Override
	public int oemCnt(Map<String, Object> paramMap) {
		return oeManagementDao.oemCnt(paramMap);
	}

	//단건조회
	@Override
	public OeManagementModel selectOemList(Map<String, Object> paramMap) {
		return oeManagementDao.selectOemList(paramMap);
	}

	
	//단건 신규등록
	@Override
	public int insertOemList(Map<String, Object> paramMap) {
		return oeManagementDao.insertOemList(paramMap);
	}

	//단건 업데이트
	@Override
	public int updateOemList(Map<String, Object> paramMap) {
		return oeManagementDao.updateOemList(paramMap);
	}

	// 단건 삭제 
	@Override
	public int deleteOemList(Map<String, Object> paramMap) {
		return oeManagementDao.deleteOemList(paramMap);
	}

	// 모달 안 리스트 뿌리기
	@Override
	public List<OeManagementModel> oemListDetail(Map<String, Object> paramMap) throws Exception {
		return oeManagementDao.oemListDetail(paramMap);
	}
	
	// 모달 안 리스트 뿌리기 카운트 
	@Override
	public int oemDetailCnt(Map<String, Object> paramMap) {
		return oeManagementDao.oemDetailCnt(paramMap);
	}

	// 계정금액 인서트 3번  
	@Override
	public int insertAccSlip1(Map<String, Object> paramMap) {
		return oeManagementDao.insertAccSlip1(paramMap);
	}

	@Override
	public int insertAccSlip2(Map<String, Object> paramMap) {
		return oeManagementDao.insertAccSlip2(paramMap);
	}

	@Override
	public int insertAccSlip3(Map<String, Object> paramMap) {
		return oeManagementDao.insertAccSlip3(paramMap);
	}
	
	//수주서 인서트
	@Override
	public int updateInsertOemList(Map<String, Object> paramMap) throws Exception {
		return oeManagementDao.updateInsertOemList(paramMap);
	}

	// order table에 인서트
	@Override
	public int insertOrderOemList(Map<String, Object> paramMap) {
		return oeManagementDao.insertOrderOemList(paramMap);
	}
}
