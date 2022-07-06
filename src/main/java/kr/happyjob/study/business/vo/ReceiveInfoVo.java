package kr.happyjob.study.business.vo;

public class ReceiveInfoVo {
    private String receiveNum;      // 수주번호
    private String loginId;         // 로그인 아이디
    private String clientCd;        // 거래처코드
    private String estimateNo;      // 견적서번호
    private int supplyVal;          // 전체 공급가액
    private int supplyTax;          // 전체 부가세
    private int supplyCost;         // 단가
	private int supplyAmount;		// 총합계
    private String receiveDate;     // 수주일자
    private String regDate;         // 생성일자
    private String depositYN;       // 입금완료여부
    private int slipNo;             // 전표번호
    private String accountCd;       // 대분류코드
	private int sumTotal;			// 총 갯수
	private String remarks;         // 비고
    
	public String getReceiveNum() {
		return receiveNum;
	}
	public String getLoginID() {
		return loginId;
	}
	public String getClientCd() {
		return clientCd;
	}
	public String getEstimateNo() {
		return estimateNo;
	}
	public int getSupplyVal() {
		return supplyVal;
	}
	public int getSupplyTax() {
		return supplyTax;
	}
	public int getSupplyCost() {
		return supplyCost;
	}
	public String getReceiveDate() { return receiveDate; }
	public String getRegDate() {
		return regDate;
	}
	public String getDepositYN() {
		return depositYN;
	}
	public int getSlipNo() {
		return slipNo;
	}
	public String getAccountCd() {
		return accountCd;
	}
	public int getSumTotal() {
		return sumTotal;
	}
	public int getSupplyAmount() {
		return supplyAmount;
	}
	public String getRemarks() { return remarks; }
}
