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
	 <%-- <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
	    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/> --%>
	    
 
    <script type="text/javaScript" language="javascript" defer="defer">
        
    
    /* 글 목록 화면 function */
    function fn_egov_selectList() {
       	document.detailForm.action = "<c:url value='/egovShopList.do'/>";
       	document.detailForm.submit();
    }
        
      
    /* 글 등록 function ifans*/
    function fn_egov_save() {
        	frm = document.detailForm;
         frm.action = "<c:url value="${registerFlag == 'create' ? '/addVendor.do' : '/updateShop.do'}"/>";
         frm.submit();      
    }
        
    </script>
    
     <style>
						.main_title{
							text-align: center;
						}
						
						.main_list {
						    width: 700px;
						    margin: 0 auto;
						}
						
						.list_start {
						    text-align: center;
						}
						
						.list_detail {
						    display: inline-block;
						    width: 220px;
						    height: 260px;
							border: 1px solid;
						    margin-bottom: 5px;
						}
						
						.paging_start{
							text-align: center;
						}
  </style>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="sampleVO" id="detailForm" name="detailForm">
    <div id="content_pop">
    	<!-- 타이틀 -->
    	<div id="title">
    		<ul>
    	</div>
    	
    	
    	<div class="main_list">
		<!-- 상단 제목 -->
		<div class="main_title">
			<p>DIV 영역을 나눠보자.</p>
		</div>
		<!-- 리스트 -->
		<div class="list_start">
			<div class="list_detail"><p>1</p></div>
			<div class="list_detail"><p>2</p></div>
			<div class="list_detail"><p>3</p></div>
			<div class="list_detail"><p>4</p></div>
			<div class="list_detail"><p>5</p></div>
			<div class="list_detail"><p>6</p></div>
			<div class="list_detail"><p>7</p></div>
			<div class="list_detail"><p>8</p></div>
			<div class="list_detail"><p>9</p></div>
		</div>
	<!-- 하단 리스트 번호 -->
	<div class="paging_start">
		<div>1 2 3 4 5 </div>
	</div>
	</div>
    	
  		
    		
      
    
				<!-- 검색조건 유지 -->
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>

    
</form:form>
</body>
</html>