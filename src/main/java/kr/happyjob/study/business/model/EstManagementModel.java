package kr.happyjob.study.business.model;

public class EstManagementModel {

	/** estimate_info 테이블 */
	private String estimate_no;			// 견적서번호
	private String client_cd; 			// 거래처코드
	private String estimate_date;		// 작성일
	private int supply_val;				// 전체체액
	private int supply_tax;				// 전체부가세
	private int supply_cost; 			// 전체단가

	/** estimate_prod 테이블 */
	private int estimate_cnt; 			// 갯수
	private int unit_cost;				// 단가
	private int price;					// 가액
	private int tax;					// 부가세

	/** tb_erp_client 테이블 */
	private String client_nm; 			// 거래처명
	private String cop_no1;				// 사업자등록번호1
	private String cop_no2;				// 사업자등록번호2
	private String cop_no3;				// 사업자등록번호3
	private String emp_nm;				// 담당자
	private String emp_hp;				// 담당자 휴대전화
	private String addr;				// 주소
	private String addr_detail;			// 상세주소

	/** tb_scm_product 테이블 */
	private String product_cd;
	private String product_nm; 			// scm 제품 정보테이블에서 조인 해 데려오는 데이터

	/** tb_scm_order 테이블 */
	private String order_cd;			// 주문코드
	private String loginID;				// 사용자ID
	private String order_date;			// 주문일자
	private String want_receive_date;	// 배송희망날짜
	private int order_cnt;				// 주문갯수
	private String deposit_yn;			// 입금 여부

	public String getEstimate_no() {
		return estimate_no;
	}
	public void setEstimate_no(String estimate_no) {
		this.estimate_no = estimate_no;
	}
	public String getClient_cd() {
		return client_cd;
	}
	public void setClient_cd(String client_cd) {
		this.client_cd = client_cd;
	}
	public String getEstimate_date() {
		return estimate_date;
	}
	public void setEstimate_date(String estimate_date) {
		this.estimate_date = estimate_date;
	}
	public int getSupply_val() {
		return supply_val;
	}
	public void setSupply_val(int supply_val) {
		this.supply_val = supply_val;
	}
	public int getSupply_tax() {
		return supply_tax;
	}
	public void setSupply_tax(int supply_tax) {
		this.supply_tax = supply_tax;
	}
	public int getSupply_cost() {
		return supply_cost;
	}
	public void setSupply_cost(int supply_cost) {
		this.supply_cost = supply_cost;
	}
	public int getEstimate_cnt() {
		return estimate_cnt;
	}
	public void setEstimate_cnt(int estimate_cnt) {
		this.estimate_cnt = estimate_cnt;
	}
	public int getUnit_cost() {
		return unit_cost;
	}
	public void setUnit_cost(int unit_cost) {
		this.unit_cost = unit_cost;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getTax() {
		return tax;
	}
	public void setTax(int tax) {
		this.tax = tax;
	}
	public String getClient_nm() {
		return client_nm;
	}
	public void setClient_nm(String client_nm) {
		this.client_nm = client_nm;
	}
	public String getCop_no1() {
		return cop_no1;
	}
	public void setCop_no1(String cop_no1) {
		this.cop_no1 = cop_no1;
	}
	public String getCop_no2() {
		return cop_no2;
	}
	public void setCop_no2(String cop_no2) {
		this.cop_no2 = cop_no2;
	}
	public String getCop_no3() {
		return cop_no3;
	}
	public void setCop_no3(String cop_no3) {
		this.cop_no3 = cop_no3;
	}
	public String getEmp_nm() {
		return emp_nm;
	}
	public void setEmp_nm(String emp_nm) {
		this.emp_nm = emp_nm;
	}
	public String getEmp_hp() {
		return emp_hp;
	}
	public void setEmp_hp(String emp_hp) {
		this.emp_hp = emp_hp;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddr_detail() {
		return addr_detail;
	}
	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}
	public String getProduct_cd() {
		return product_cd;
	}
	public void setProduct_cd(String product_cd) {
		this.product_cd = product_cd;
	}
	public String getProduct_nm() {
		return product_nm;
	}
	public void setProduct_nm(String product_nm) {
		this.product_nm = product_nm;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getWant_receive_date() {
		return want_receive_date;
	}
	public void setWant_receive_date(String want_receive_date) {
		this.want_receive_date = want_receive_date;
	}
	public int getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getDeposit_yn() {
		return deposit_yn;
	}
	public void setDeposit_yn(String deposit_yn) {
		this.deposit_yn = deposit_yn;
	}
	
	@Override
	public String toString() {
		return "EstManagementModel [estimate_no=" + estimate_no + ", client_cd=" + client_cd + ", estimate_date="
				+ estimate_date + ", supply_val=" + supply_val + ", supply_tax=" + supply_tax + ", supply_cost="
				+ supply_cost + ", estimate_cnt=" + estimate_cnt + ", unit_cost=" + unit_cost + ", price=" + price
				+ ", tax=" + tax + ", client_nm=" + client_nm + ", cop_no1=" + cop_no1 + ", cop_no2=" + cop_no2
				+ ", cop_no3=" + cop_no3 + ", emp_nm=" + emp_nm + ", emp_hp=" + emp_hp + ", addr=" + addr
				+ ", addr_detail=" + addr_detail + ", product_cd=" + product_cd + ", product_nm=" + product_nm
				+ ", order_cd=" + order_cd + ", loginID=" + loginID + ", order_date=" + order_date
				+ ", want_receive_date=" + want_receive_date + ", order_cnt=" + order_cnt + ", deposit_yn=" + deposit_yn
				+ "]";
	}
}
