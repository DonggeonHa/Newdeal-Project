package kr.happyjob.study.business.vo;

public class ScmProductVo {
    private String productCd;		// 제품코드
    private String mCtCd;			// 중분류코드
    private String supplyCd;		// 공급처코드
    private String productNm;		// 제품명
    private String detail;			// 상세정보
    private int purchasePrice;		// 원가
    private int price;				// 단가
    private int stock;				// 재고갯수
    
	public String getProductCd() {
		return productCd;
	}
	public String getmCtCd() {
		return mCtCd;
	}
	public String getSupplyCd() {
		return supplyCd;
	}
	public String getProductNm() {
		return productNm;
	}
	public String getDetail() {
		return detail;
	}
	public int getPurchasePrice() {
		return purchasePrice;
	}
	public int getPrice() {
		return price;
	}
	public int getStock() {
		return stock;
	}
	
	@Override
	public String toString() {
		return "ScmProduct [productCd=" + productCd + ", mCtCd=" + mCtCd + ", supplyCd=" + supplyCd + ", productNm="
				+ productNm + ", detail=" + detail + ", purchasePrice=" + purchasePrice + ", price=" + price
				+ ", stock=" + stock + "]";
	}
}
