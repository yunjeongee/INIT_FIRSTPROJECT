<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleRegister.jsp
  * @Description : Sample Register 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:set var="registerFlag" value="${empty sampleVO.vendorCode ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
	 <%--    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
	    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/> --%>
	    
 
    <script type="text/javaScript" language="javascript" defer="defer">
        
    
    /* 글 목록 화면 function */
    function fn_egov_selectList() {
       	document.detailForm.action = "<c:url value='/egovShopList.do'/>";
       	document.detailForm.submit();
    }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
           	document.detailForm.action = "<c:url value='/deleteSample.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
        
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addShop.do' : '/updateShop.do'}"/>";
                frm.submit();
            
        }
        
        	/* 판매처 등록 팝업창 function */
         function showPopup(){        	
   	    	 window.open("createVendor.do","test", "width=800, height=300, left=100, top=50");    	
        } 
        
        
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="sampleVO" id="detailForm" name="detailForm">
    <div id="content_pop">
    	<!-- 타이틀 -->
    	<div id="title">
    		<ul>
    			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                    <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                    <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                </li>
    		</ul>
    	</div>
    	
    	<!-- // 타이틀 -->
    	<h2>상품정보</h2>
    	<div id="table">
    	<table width="800" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
    		<colgroup>
    			<col width="150"/>
    			<col width="?"/>
    		</colgroup>
    	
    		
    		<tr>
    			<td class="tbtd_caption"><label for="goodsNum"><spring:message code="title.sample.goodsNum" /></label></td>
    			<td class="tbtd_content">
    			
    				<form:input path="goodsNum" maxlength="30" size ="60" cssClass="essentiality"/>
    				&nbsp;<form:errors path="goodsNum" />
    	    </td>
    		</tr>
    		
     	 	<tr>
    			<td class="tbtd_caption"><label for="vendorName"><spring:message code="title.sample.vendorName" /></label></td>
    			<td class="tbtd_content">  		       		
    				
    					<form:select path="vendorCode" cssClass="use">
    					<option value = "none">----- 선택 -----</option>
    					<c:forEach var="vendor" items="${resultVendor}" varStatus="status">
    					<form:option value="${vendor.vendorCode}" label="${vendor.vendorName}" />				
    					</c:forEach>
    				</form:select>
    			
    				<%-- <form:input path="vendorName" maxlength="30" size ="60" cssClass="txt"/>
    				&nbsp;<form:errors path="vendorName" />--%>
    				
    			<input type = "button" value = "판매처 등록" onclick ="showPopup();"/>
    			
   
    			</td>
    		</tr>
    		
     		
    		<tr>
    			<td class="tbtd_caption"><label for="priceRetail"><spring:message code="title.sample.priceRetail" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="priceRetail" maxlength="30" size ="60" cssClass="txt"/>
    				&nbsp;<form:errors path="priceRetail" />
    			</td>
    		</tr>
        
    		
    		<tr>
    			<td class="tbtd_caption"><label for="shoppingFee"><spring:message code="title.sample.shoppingFee" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="shoppingFee" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="shoppingFee" /> 
    			</td>
    		</tr>

    		
<%--     		<tr>
    			<td class="tbtd_caption"><label for="discountRate"><spring:message code="title.sample.discountRate" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="discountRate" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="discountRate" /> 
    			</td>
    		</tr>  --%>
    		
    		
    		
    		
    	</table>
      </div>
      
    	<div id="sysbtn">
    		<ul> 
             			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_selectList();"><spring:message code="button.vendorlist" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
                
       
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_save();">
                            <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                            <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                        </a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<c:if test="${registerFlag == 'modify'}">
                    <li>
                        <span class="btn_blue_l">
                            <a href="javascript:fn_egov_delete();"><spring:message code="button.delete" /></a>
                            <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                        </span>
                    </li>
    			</c:if>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:document.detailForm.reset();"><spring:message code="button.reset" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
            </ul>
    	</div>
    </div>
    <%-- <form:hidden path="goodsNum" />
     --%><!-- 검색조건 유지 -->
   <%--  <input type="hidden" name="imgUrl" value="<c:out value='${sampleVO.imgUrl}'/>"/> --%>
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
   <%--  <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> --%>
     <input type="hidden" name="selectedId" value="<c:out value='${searchVO.goodsNum}'/>"/>

    
</form:form>
</body>
</html>