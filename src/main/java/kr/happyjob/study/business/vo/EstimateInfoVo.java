package kr.happyjob.study.business.vo;

public class EstimateInfoVo {
    private String estimateNo;      // 견적서번호
    private String clientCd;        // 거래처코드
    private String estimateDate;    // 작성일
    private int supplyVal;          // 전체 공급가액
    private int supplyTax;          // 부가세
    private int supplyCost;         // 단가
	private int sumTotal;			// 총 갯수
	private String remarks;			// 비고
    
	public String getEstimateNo() {
		return estimateNo;
	}
	public String getClientCd() {
		return clientCd;
	}
	public String getEstimateDate() {
		return estimateDate;
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
	public int getSumTotal() {
		return sumTotal;
	}
	public String getRemarks() {
		return remarks;
	}

	@Override
	public String toString() {
		return "EstimateInfoVo{" +
				"estimateNo='" + estimateNo + '\'' +
				", clientCd='" + clientCd + '\'' +
				", estimateDate='" + estimateDate + '\'' +
				", supplyVal=" + supplyVal +
				", supplyTax=" + supplyTax +
				", supplyCost=" + supplyCost +
				", sumTotal=" + sumTotal +
				", remarks='" + remarks + '\'' +
				'}';
	}
}
