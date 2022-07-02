package kr.happyjob.study.business.vo;

public class EstimateProdVo {
    private String estimateNo;      // 견적서번호
    private String clientCd;        // 거래처코드
    private String productCd;       // 제품코드
    private int estimateCnt;        // 갯수
    private int unitCost;           // 단가
    private int price;              // 공급가액
    private int tax;                // 부가세
	private String ourDeadline;		// 납기일자
    
	public String getEstimateNo() {
		return estimateNo;
	}
	public String getClientCd() {
		return clientCd;
	}
	public String getProductCd() {
		return productCd;
	}
	public int getEstimateCnt() {
		return estimateCnt;
	}
	public int getUnitCost() {
		return unitCost;
	}
	public int getPrice() {
		return price;
	}
	public int getTax() {
		return tax;
	}
	public String getOurDeadline() {
		return ourDeadline;
	}

	@Override
	public String toString() {
		return "EstimateProd [estimateNo=" + estimateNo + ", clientCd=" + clientCd + ", productCd=" + productCd
				+ ", estimateCnt=" + estimateCnt + ", unitCost=" + unitCost + ", price=" + price + ", tax=" + tax + "]";
	}
}
