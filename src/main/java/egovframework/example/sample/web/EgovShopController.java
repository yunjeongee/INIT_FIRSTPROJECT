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
package egovframework.example.sample.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import egovframework.example.sample.service.EgovShopService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
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

@Controller
public class EgovShopController {

	/** EgovSampleService */
	@Resource(name = "shopService")
	private EgovShopService shopService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * 상품 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/egovGoodsList.do")
	public String selectGoodsList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = shopService.selectGoodsList(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = shopService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "shop/egovGoodsList";
	}
	
	/**
	 * 판매 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/egovShopList.do")
	public String selectShopList(@RequestParam("selectedId") String goodsNum , @ModelAttribute("searchVO") SampleVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		/*
		SampleVO sampleVO = new SampleVO();		
		sampleVO.setGoodsNum(goodsNum);
		*/
		
		/* 기본 리스트에서 넘어가는거 - searchVO로 연결 goodsNum값을 가져오지 못했을 때.. 이유 넘어오는게 뭔지 생각해봐*/
		searchVO.setGoodsNum(goodsNum);
		model.addAttribute(goodsNum);
		
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = shopService.selectShopList(searchVO);
		model.addAttribute("resultList", sampleList);	
		
		int totCnt = shopService.selectShopListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "shop/egovShopList";
	}
	
	/**
	 * 글 등록 화면을 조회한다. addSampleselect
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 *//*
	@RequestMapping(value = "/addSample.do", method = RequestMethod.GET)
	public String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		model.addAttribute("sampleVO", new SampleVO());
		return "sample/egovSampleRegister";
	}

	*/
	
	
	
	/**
	 * 상품  등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/addGoodsSelect.do")
	public String addGoodsView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		
		SampleVO sampleVO = new SampleVO();		
		model.addAttribute("sampleVO", new SampleVO());
		
		List<?> manufacture = shopService.selectManufacture(sampleVO);
		model.addAttribute("resultManufacture",manufacture);
		
		
		System.out.println("----------------"+sampleVO);
				
		return "shop/egovGoodsRegister";
	
	}
	
	

	
	/**
	 * 상품을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addGoods.do")
	public String addGoods(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

/*		// Server-Side Validation
		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "shop/egovGoodsRegister";
		}*/
		/*System.out.println(sampleVO.getGoodsNum());*/
		shopService.insertGoods(sampleVO);
		status.setComplete();
		return "forward:/egovGoodsList.do";
	}
	
	
	
	/**
	 * 상픔리스트의 판매처 상세 목록 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/addShopSelect.do")
	public String addShopView(String goodsNum, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
/*		model.addAttribute("sampleVO", new SampleVO());*/
		
		SampleVO sampleVO = new SampleVO();		
		sampleVO.setGoodsNum(goodsNum);
		model.addAttribute(selectGoods(sampleVO, searchVO));
	
		List<?> vendor = shopService.selectVendor(sampleVO);
		model.addAttribute("resultVendor", vendor);
	
	
		
		return "shop/egovShopRegister";
	}

	
	
	/**
	 * 상품의  판매처 상세 항목을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/addShop.do")
	public String addShop(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
/*		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "shop/egovShopRegister";
		}*/

		shopService.insertShop(sampleVO);
		status.setComplete();
		return "forward:/egovShopList.do";
	}
	
	/**
	 * 새로운 판매처  추가 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/createVendor.do")
	public String addVendorView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		
		SampleVO sampleVO = new SampleVO();		
		model.addAttribute("sampleVO", new SampleVO());
		
		List<?> manufacture = shopService.selectManufacture(sampleVO);
		model.addAttribute("resultManufacture",manufacture);
				
		return "shop/createVendor";
	
	}
	
	
	/**
	 * 새로운 판매처를 추가 등록.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/addVendor.do")
	public String addVendor(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
/*		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "shop/egovShopRegister";
		}*/

		shopService.insertVendor(sampleVO);
		status.setComplete();
		return "forward:/egovShopRegister.do";
	}
	

	
	/**
	 * 새로운 이미지를 추가 등록.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/addImage.do")
	public String addImage(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
/*		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "shop/egovShopRegister";
		}*/

		shopService.insertImage(sampleVO);
		status.setComplete();
		
		return "forward:/egovGoodsRegister.do";
	}
	
	
	
	

	/**
	 * 글 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	
	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String goodsNum, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();		
		sampleVO.setGoodsNum(goodsNum);
		
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute(selectGoods(sampleVO, searchVO));
		
		List<?> manufacture = shopService.selectManufacture(sampleVO);
		model.addAttribute("resultManufacture",manufacture);
		
		List<?> img = shopService.selectImage(sampleVO);
		model.addAttribute("ImageList",img);
		
		
		/*List<?> vendor = shopService.selectVendor(sampleVO);
		model.addAttribute("resultVendor", vendor);
		*/
			
		System.out.println(goodsNum);
		return "shop/egovGoodsRegister";
	}
	
	/**
	 * 판매처 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	
	@RequestMapping("/updateShopView.do")
	public String updateShopView(String goodsNum, @RequestParam("selectedId") String vendorCode, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		
		SampleVO sampleVO = new SampleVO();		
		sampleVO.setGoodsNum(goodsNum);	
		sampleVO.setVendorCode(vendorCode);
		
		System.out.println(searchVO);
		System.out.println(sampleVO);
		
		List<?> vendor = shopService.selectVendor(sampleVO);
		model.addAttribute("resultVendor", vendor);
		
		
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute(selectShop(sampleVO, searchVO));
		System.out.println(model);
		
		return "shop/egovShopRegister";
	}
	
	
		
 /*	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();
		sampleVO.setId(id);
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute(selectSample(sampleVO, searchVO));
		return "sample/egovSampleRegister";
	}*/

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	public SampleVO selectGoods(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return shopService.selectGoods(sampleVO);
	}
	
	/**
	 * 판매처글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */

	public SampleVO selectShop(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return shopService.selectShop(sampleVO);
	}
	
	
	/**
	 * 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateSample.do")
	public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

/*		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "shop/egovGoodsRegister";
		}*/

		shopService.updateSample(sampleVO);
		status.setComplete();
		return "forward:/egovGoodsList.do";
	}
	
	
	/**
	 * 판매처 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateShop.do")
	public String updateShop(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

/*		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "shop/egovShopRegister";
		}
*/
		shopService.updateShop(sampleVO);
		status.setComplete();
		return "forward:/egovShopList.do";
	}


	
	/**
	 * 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
	@RequestMapping("/deleteSample.do")
	public String deleteSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {

		shopService.deleteSample(sampleVO);

		status.setComplete();

	
		return "forward:/egovGoodsList.do";
	}

	/**
	 * 판매처를 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
	@RequestMapping("/deleteShop.do")
	public String deleteShop(SampleVO sampleVO, SessionStatus status) throws Exception {

		shopService.deleteShop(sampleVO);
		status.setComplete();

	
		return "forward:/egovShopList.do";
	}
	
	/**
	 * 이미지를 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
/*	@RequestMapping("/deleteImage.do")
	public String deleteImage22(SampleVO sampleVO, SessionStatus status, @RequestParam("selectedId2") String imgNum) throws Exception {

		sampleVO.setImgNum(imgNum);
		shopService.deleteImage(sampleVO);
		status.setComplete();
		
		System.out.println(imgNum + "--------------------");

	
		return "forward:/egovGoodsRegister.do";
	}*/
	
	@RequestMapping(value = "/deleteImage.do", method=RequestMethod.POST)
    public ModelAndView deleteImage(SampleVO sampleVO,
        HttpServletRequest request,HttpServletResponse response, @RequestParam("imgNum") String imgNum, @RequestParam("goodsNum") String goodsNum) 
    throws Exception {
		
		sampleVO.setImgNum(imgNum);
		shopService.deleteImage(sampleVO);
		
		
		System.out.println(imgNum + "----------imgNum----------");

		sampleVO.setGoodsNum(goodsNum);

		System.out.println(goodsNum + "-----------------goodsNum-------");
			
		List<?> img = shopService.selectImage(sampleVO);		
	    
	    ModelAndView mav = new ModelAndView("jsonView");
	    mav.addObject("ImageList", img);
	    return mav;
  
	}
	

	/*-----------파일업로드------------- */
	
/*	@RequestMapping(value = "/fileupload.do", method = RequestMethod.POST)
	public String upload(MultipartFile uploadfile, @RequestParam("selectedId") String goodsNum, HttpServletRequest request, Model model) throws Exception{
	 
	    SampleVO sampleVO = new SampleVO();
	    
		saveFile(uploadfile, goodsNum, request);
		System.out.println(goodsNum);
		
		return "forward:/updateSampleView.do";
	}*/
	
	
	@RequestMapping(value = "/fileupload.do", method=RequestMethod.POST)
    public ModelAndView upload(SampleVO sampleVO,
        HttpServletRequest request,HttpServletResponse response, MultipartFile uploadfile, @RequestParam("selectedId") String goodsNum) 
    throws Exception {
		
		
		sampleVO.setGoodsNum(goodsNum);

		saveFile(uploadfile, goodsNum, request);
		System.out.println(goodsNum + "-----------------goodsNum-------");
			
		List<?> img = shopService.selectImage(sampleVO);		
	    
	    ModelAndView mav = new ModelAndView("jsonView");
	    mav.addObject("ImageList", img);
	    return mav;
  
	}
	
/*	@RequestMapping(value = "/ajaxTest.do", method=RequestMethod.POST)
    public ModelAndView ajaxTest2(SampleVO sampleVO,
        HttpServletRequest request,HttpServletResponse response) 
    throws Exception {

        HashMap<String,Object> params = new HashMap<String,Object>();

    List<?> sampleList = shopService.selectGoodsList(sampleVO);
    

    ModelAndView mav = new ModelAndView("jsonView");
    mav.addObject("goodsList", sampleList);
    return mav;
  
	}
	*/
	
	/*private static final String UPLOAD_PATH = "C:\\Work\\JAVA\\eGovFrameDev-3.7.0-64bit\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\INIT_FIRSTPROJECT\\images\\egovframework\\fileupload";*/
	
	private String saveFile(MultipartFile file, String goodsNum, HttpServletRequest request) throws Exception{
	   
		// 파일 이름 변경
	    UUID uuid = UUID.randomUUID();
	 
	    String saveName = uuid + "_" + file.getOriginalFilename();
	    
	    
	    
	    // 저장할 File 객체를 생성(껍데기 파일)ㄴ
	    /*File saveFile = new File(UPLOAD_PATH,saveName); // 저장할 폴더 이름, 저장할 파일 이름*/
	    
	    String uploadPath = request.getSession().getServletContext().getRealPath("/");
	    File saveFile = new File(uploadPath + "fileupload/", saveName);
	    
	    SampleVO sampleVO = new SampleVO();
	    
	    sampleVO.setGoodsNum(goodsNum);
	    sampleVO.setImgUrl(saveName);
	    shopService.insertImage(sampleVO);
	  
	    try {
	        file.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }

	    return saveName;
	} // end saveFile(
	
	


	
	
	
	/**
	 * GridTest.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/jqGridTest.do", produces = "application/text; charset=UTF-8")
    public @ResponseBody String jqGridTest(SampleDefaultVO searchVO,
        HttpServletRequest request,HttpServletResponse response,      
            @RequestParam int    rows,
            @RequestParam int    page,
            @RequestParam String sidx,
            @RequestParam String  sord
    ) throws Exception {

  
		/* HashMap<String,Object> params = new HashMap<String,Object>(); */
    
    List<?> sampleList = shopService.selectGoodsList(searchVO);

    String value = "";


      ObjectMapper mapper = new ObjectMapper();

     Map<String, Object> modelMap = new HashMap<String, Object>();
        
     modelMap.put("rows", sampleList);  /*.put("key값", value값)*/


     value = mapper.writeValueAsString(modelMap);

    return value;
    }

	
	@RequestMapping(value = "/addGrid.do" )
	 public String addGrid(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
	    
		
		return "shop/GridTest";
	}
	
	/**
	 * Ajax Test.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	
/*	@RequestMapping(value = "/ajaxTest.do", produces = "application/text; charset=UTF-8")
    public @ResponseBody String ajaxTest(@ModelAttribute("searchVO") SampleDefaultVO searchVO,
        HttpServletRequest request,HttpServletResponse response
    ) throws Exception {

        HashMap<String,Object> params = new HashMap<String,Object>();

    List<?> sampleList = shopService.selectGoodsList(searchVO);

    String value = "";

    ObjectMapper mapper = new ObjectMapper();

    Map<String, Object> modelMap = new HashMap<String, Object>();
            
    modelMap.put("rows", sampleList);
             
    value = mapper.writeValueAsString(modelMap);
        
    return value;
    }*/
	
	
	@RequestMapping(value = "/ajaxTest.do", method=RequestMethod.POST)
    public ModelAndView ajaxTest(SampleVO sampleVO,
        HttpServletRequest request,HttpServletResponse response) 
    throws Exception {

    /*    HashMap<String,Object> params = new HashMap<String,Object>();*/

    List<?> sampleList = shopService.selectGoodsList(sampleVO);
    

    ModelAndView mav = new ModelAndView("jsonView");
    mav.addObject("goodsList", sampleList);
    return mav;
  
	}
	   
}
