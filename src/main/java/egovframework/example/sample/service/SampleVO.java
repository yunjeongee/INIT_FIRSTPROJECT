/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service;

/**
 * @Class Name : SampleVO.java
 * @Description : SampleVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public class SampleVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	/** 상품 번호 */
	private String goodsNum;
	
	/** 제조사 명 */
	private String manufactureName;
	
	/** 제조사 명 */
	private String manufactureCode;
	

	/** 소재 */
	private String material;
	
	/** 기능 */
	private String goodsFuntion;
	
	
	/** 상품 명 */
	private String goodsName;

	/** 판매처 이름 */
	private String vendorName;

    /** 판매처 코드 */
	private String vendorCode;

	/** 소비자 가격*/
	private String priceRetail;

	/** 배송비*/
	private String shoppingFee ;

	/** 상품 이미지 URL */
	private String imgUrl;
	
	/** 이미지 번호 */
	private String imgNum;
	
	
	public String getImgNum() {
		return imgNum;
	}

	public void setImgNum(String imgNum) {
		this.imgNum = imgNum;
	}


	/** 대표 이미지 URL */
	private String imgFirst;
	

	
	public String getImgFirst() {
		return imgFirst;
	}

	public void setImgFirst(String imgFirst) {
		this.imgFirst = imgFirst;
	}





	/** 할인명*/
	private String discountName ;

	/** 할인율 */
	private String discountRate;
	
	/** 할인시작일자 */
	private String discountStart;
	
	/** 할인종료일자 */
	private String discountEnd;
	
	
	
	
	public String getManufactureCode() {
		return manufactureCode;
	}

	public void setManufactureCode(String manufactureCode) {
		this.manufactureCode = manufactureCode;
	}
	
	public String getDiscountName() {
		return discountName;
	}

	public void setDiscountName(String discountName) {
		this.discountName = discountName;
	}

	public String getDiscountStart() {
		return discountStart;
	}

	public void setDiscountStart(String discountStart) {
		this.discountStart = discountStart;
	}

	public String getDiscountEnd() {
		return discountEnd;
	}

	public void setDiscountEnd(String discountEnd) {
		this.discountEnd = discountEnd;
	}
	
	
	

	public String getShoppingFee() {
		return shoppingFee;
	}

	public void setShoppingFee(String shoppingFee) {
		this.shoppingFee = shoppingFee;
	}

	
	public String getPriceRetail() {
		return priceRetail;
	}

	public void setPriceRetail(String priceRetail) {
		this.priceRetail = priceRetail;
	}
	

	public String getGoodsFuntion() {
		return goodsFuntion;
	}

	public void setGoodsFuntion(String goodsFuntion) {
		this.goodsFuntion = goodsFuntion;
	}

	
	
	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}
	

	public String getManufactureName() {
		return manufactureName;
	}

	public void setManufactureName(String manufactureName) {
		this.manufactureName = manufactureName;
	}
	

	public String getGoodsNum() {
		return goodsNum;
	}

	public void setGoodsNum(String goodsNum) {
		this.goodsNum = goodsNum;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(String discountRate) {
		this.discountRate = discountRate;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	
	
	
	
	 
	/** 아이디 */
	   private String id;

	   /** 이름 */
	   private String name;

	   /** 내용 */
	   private String description;

	   /** 사용여부 */
	   private String useYn;

	   /** 등록자 */
	   private String regUser;

	   public String getId() {
	      return id;
	   }

	   public void setId(String id) {
	      this.id = id;
	   }

	   public String getName() {
	      return name;
	   }

	   public void setName(String name) {
	      this.name = name;
	   }

	   public String getDescription() {
	      return description;
	   }

	   public void setDescription(String description) {
	      this.description = description;
	   }

	   public String getUseYn() {
	      return useYn;
	   }

	   public void setUseYn(String useYn) {
	      this.useYn = useYn;
	   }

	   public String getRegUser() {
	      return regUser;
	   }

	   public void setRegUser(String regUser) {
	      this.regUser = regUser;
	   }


}
