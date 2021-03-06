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
 * @  ?????????      ?????????              ????????????
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           ????????????
 *
 * @author ????????????????????? ???????????? ?????????
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
	 * ?????? ????????? ????????????. (pageing)
	 * @param searchVO - ????????? ????????? ?????? SampleDefaultVO
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
	 * ?????? ????????? ????????????. (pageing)
	 * @param searchVO - ????????? ????????? ?????? SampleDefaultVO
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
		
		/* ?????? ??????????????? ??????????????? - searchVO??? ?????? goodsNum?????? ???????????? ????????? ???.. ?????? ??????????????? ?????? ????????????*/
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
	 * ??? ?????? ????????? ????????????. addSampleselect
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ??????  ?????? ????????? ????????????.
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ????????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ?????????????????? ????????? ?????? ?????? ??? ?????? ????????? ????????????.
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ?????????  ????????? ?????? ????????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ????????? ?????????  ?????? ?????? ????????? ????????????.
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ????????? ???????????? ?????? ??????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ????????? ???????????? ?????? ??????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ??? ??????????????? ????????????.
	 * @param id - ????????? ??? id
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	
	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String goodsNum, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();		
		sampleVO.setGoodsNum(goodsNum);
		
		// ???????????? CoC ??? ?????? sampleVO
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
	 * ????????? ??????????????? ????????????.
	 * @param id - ????????? ??? id
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
		
		
		// ???????????? CoC ??? ?????? sampleVO
		model.addAttribute(selectShop(sampleVO, searchVO));
		System.out.println(model);
		
		return "shop/egovShopRegister";
	}
	
	
		
 /*	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();
		sampleVO.setId(id);
		// ???????????? CoC ??? ?????? sampleVO
		model.addAttribute(selectSample(sampleVO, searchVO));
		return "sample/egovSampleRegister";
	}*/

	/**
	 * ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - ????????? ??????
	 * @exception Exception
	 */
	public SampleVO selectGoods(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return shopService.selectGoods(sampleVO);
	}
	
	/**
	 * ??????????????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - ????????? ??????
	 * @exception Exception
	 */

	public SampleVO selectShop(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return shopService.selectShop(sampleVO);
	}
	
	
	/**
	 * ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateSample.do")
	public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model,SessionStatus status)
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
	 * ?????????????????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateImageFirst.do")
	public String updateImageFirst(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model,
			@RequestParam("selectedId") String goodsNum, @RequestParam("imgNum") String imgNum, SessionStatus status)
			throws Exception {

		sampleVO.setGoodsNum(goodsNum);
		sampleVO.setImgNum(imgNum);	
		shopService.updateImageN(sampleVO);
		System.out.println(imgNum + "----------------------------------------*************************************");
		shopService.updateImageFirst(sampleVO);
		
		status.setComplete();
		return "forward:/egovGoodsList.do";
	}
	
	
	
	/**
	 * ????????? ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ???????????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	 * ???????????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
	
	
	
	


	/*-----------???????????????------------- */
	
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
	   
		// ?????? ?????? ??????
	    UUID uuid = UUID.randomUUID();
	 
	    String saveName = uuid + "_" + file.getOriginalFilename();
	    
	    
	    
	    // ????????? File ????????? ??????(????????? ??????)???
	    /*File saveFile = new File(UPLOAD_PATH,saveName); // ????????? ?????? ??????, ????????? ?????? ??????*/
	    
	    String uploadPath = request.getSession().getServletContext().getRealPath("/");
	    File saveFile = new File(uploadPath + "fileupload/", saveName);
	    
	    SampleVO sampleVO = new SampleVO();
	    
	    sampleVO.setGoodsNum(goodsNum);
	    sampleVO.setImgUrl(saveName);
	    shopService.insertImage(sampleVO);
	  
	    try {
	        file.transferTo(saveFile); // ????????? ????????? saveFile????????? ????????? ??????
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }

	    return saveName;
	} // end saveFile(
	
	


	
	
	
	/**
	 * GridTest.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
        
     modelMap.put("rows", sampleList);  /*.put("key???", value???)*/


     value = mapper.writeValueAsString(modelMap);

    return value;
    }

	
	@RequestMapping(value = "/addGrid.do" )
	 public String addGrid(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
	    
		
		return "shop/GridTest";
	}
	
	/**
	 * Ajax Test.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
