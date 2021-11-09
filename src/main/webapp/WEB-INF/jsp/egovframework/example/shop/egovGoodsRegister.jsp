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
    <c:set var="registerFlag" value="${empty sampleVO.goodsNum ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
        
    
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/egovGoodsList.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() { 			
        				alert()
            document.detailForm.action = "<c:url value='/deleteSample.do'/>";
           	document.detailForm.submit(); 
        } 
        
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;     			
        /*   if(!validateSampleVO(frm)){
                return;
            }else{  */
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addGoods.do' : '/updateSample.do'}"/>";
                frm.submit();
            /* } */
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
    	
    		
<%--     		<tr>
    			<td class="tbtd_caption"><label for="goodsNum"><spring:message code="title.sample.goodsNum" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="goodsNum" maxlength="30" size ="60" cssClass="essentiality"/>
    				&nbsp;<form:errors path="goodsNum" />
    	    </td>
    		</tr> --%>
      		
      		<tr>
    			<td class="tbtd_caption"><label for="manufactureName"><spring:message code="title.sample.manufactureName" /></label></td>
    			<td class="tbtd_content">
    			
    					<form:select path="manufactureCode" cssClass="use">
    					<option value = "none">--- 선택 ---</option>
    					<c:forEach var="manufacture" items="${resultManufacture}" varStatus="status">
    					<form:option value="${manufacture.manufactureCode}" label="${manufacture.manufactureName}" />				
    					</c:forEach>
    					<tr>
    			<td class="tbtd_caption"><label for="goodsNum"><spring:message code="title.sample.goodsNum" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="goodsNum" maxlength="30" size ="60" cssClass="txt"/>
    				&nbsp;<form:errors path="goodsNum" />
    	    </td>
    		</tr>
    		
    		<tr>
    			<td class="tbtd_caption"><label for="goodsName"><spring:message code="title.sample.goodsName" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="goodsName" maxlength="30" size ="60" cssClass="txt"/>
    				&nbsp;<form:errors path="goodsName" />
    	    </td>
    		</tr>
   		

    					
	   		<%--<form:select path="vendorCode" cssClass="use">
	    					<c:forEach var="vendor" items="${resultVendor}" varStatus="status">
	    					<form:option value="${vendor.vendorCode}" label="${vendor.vendorName}" />				
	    					</c:forEach>
    	 --%>
    			
    				
    				</form:select>
    			</td>
    		</tr>
    		
    		
    		 <tr>
    			<td class="tbtd_caption"><label for="goodsFuntion"><spring:message code="title.sample.goodsFuntion" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="goodsFuntion" maxlength="30" size ="60" cssClass="txt"/>
    				&nbsp;<form:errors path="goodsFuntion" />
    			</td>
    		</tr>
    		
    		<tr>
    			<td class="tbtd_caption"><label for="material"><spring:message code="title.sample.material" /></label></td>
    			<td class="tbtd_content"> 
				<form:input path="material" maxlength="30" size ="60" cssClass="txt"/>
    				&nbsp;<form:errors path="material" />
    		</tr>
    		


<%--     		<tr>
    			<td class="tbtd_caption"><label for="imgUrl"><spring:message code="title.sample.imgUrl" /></label></td>
    			<td class="tbtd_content">	
                <img src ="${sampleVO.imgUrl}" width = "120" height = "120"/>&nbsp;
    			</td>
    		</tr> --%>
    		
    	</table>
      </div>
      
    	<div id="sysbtn">
    		<ul>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_selectList();"><spring:message code="button.list" /></a>
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
    <!-- 검색조건 유지 -->
   <%--  <input type="hidden" name="imgUrl" value="<c:out value='${sampleVO.imgUrl}'/>"/> --%>
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> 
   



</form:form>
</body>
</html>