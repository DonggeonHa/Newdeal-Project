package kr.happyjob.study.business.vo;

public class ReceiveProdVo {
    private String receiveNum;     // 수주번호
    private String productCd;      // 제품코드
    private String estimateNo;     // 견적서번호
    private String clientCd;       // 거래처코드
    private int receiveProductCnt;       // 수량
    private int unitCost;          // 단가
    private int tax;                // 부가세
    private int price;              // 공급가액
    private String limitDate;      // 납기일자
	private int sumAmount;			// 합계
    
	public String getReceiveNum() {
		return receiveNum;
	}
	public String getProductCd() {
		return productCd;
	}
	public String getEstimateNo() {
		return estimateNo;
	}
	public String getClientCd() {
		return clientCd;
	}
	public int getReceiveProductCnt() { return receiveProductCnt; }
	public int getUnitCost() {
		return unitCost;
	}
	public int getTax() {
		return tax;
	}
	public int getPrice() {
		return price;
	}
	public String getLimitDate() {
		return limitDate;
	}
	public int getSumAmount() {
		return sumAmount;
	}
}
