package kr.happyjob.study.business.vo;

public class ReceiveProdVo {
    private String receiveNum;     // 수주번호
    private String productCd;      // 제품코드
    private String estimateNo;     // 견적서번호
    private String clientCd;       // 거래처코드
    private String loginID;         // 로그인 아이디
    private int slipNo;            // 전표번호
    private int estimateCnt;       // 수량
    private int unitCost;          // 단가
    private int tax;                // 부가세
    private int price;              // 공급가액
    private String limitDate;      // 납기일자
    private String remarks;         // 비고
    
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
	public String getLoginID() {
		return loginID;
	}
	public int getSlipNo() {
		return slipNo;
	}
	public int getEstimateCnt() {
		return estimateCnt;
	}
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
	public String getRemarks() {
		return remarks;
	}
	
	@Override
	public String toString() {
		return "ReceiveProd [receiveNum=" + receiveNum + ", productCd=" + productCd + ", estimateNo=" + estimateNo
				+ ", clientCd=" + clientCd + ", loginID=" + loginID + ", slipNo=" + slipNo + ", estimateCnt="
				+ estimateCnt + ", unitCost=" + unitCost + ", tax=" + tax + ", price=" + price + ", limitDate="
				+ limitDate + ", remarks=" + remarks + "]";
	}
}
