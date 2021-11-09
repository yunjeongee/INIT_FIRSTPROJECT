<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovGoodsList.jsp
  * @Description : Sample List 화면
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
    <title><spring:message code="title.sample" /></title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <script type="text/javaScript" language="javascript" defer="defer">
     
        /* 글 수정 화면 function */
        function fn_egov_select(goodsNum) {
        	
        	document.listForm.selectedId.value = goodsNum;
           	document.listForm.action = "<c:url value='/updateSampleView.do'/>";
           	document.listForm.submit();
        }
        
        
        /* 판매처 목록,,? 상세화면 느낌 수정 화면 function */
        function fn_egov_select2(goodsNum) {        	
        	document.listForm.selectedId.value = goodsNum;
           	document.listForm.action = "<c:url value='/egovShopList.do'/>";
           	document.listForm.submit();
        }
        
        
        /* 판매처 수정 화면 function */
        function fn_egov_select3(vendorCode) {
       /*  	document.listForm.selectedId.value = goodsNum; */
           	document.listForm.selectedId.value = vendorCode;
           	document.listForm.action = "<c:url value='/updateShopView.do'/>";
           	document.listForm.submit();
        }
        
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	
           	document.listForm.action = "<c:url value='/addShopSelect.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
   				 /* 	ALERT (document.listForm.pageIndex.value); */
        	document.listForm.action = "<c:url value='/egovGoodsList.do'/>";
           	document.listForm.submit();
        }
    
        
       /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovShopList.do'/>";
           	document.listForm.submit();
        } 
        
        
       
    </script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
        <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
       


        <div id="content_pop">
        	<!-- 타이틀 -->
        	 
        	<div id="title">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/><spring:message code="list.sample" /></li>
        		</ul>
        	</div>
        	 
        	<!-- // 타이틀 -->
        	<div id="search">
        		<ul>
        			<li>
        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select path="searchCondition" cssClass="use">
        					<form:option value="1" label="판매처명" />
        					<form:option value="0" label="판매처번호" />
        				</form:select>
        			</li>
        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt"/>
                    </li>
        			<li>
        	            <span class="btn_blue_l">
        	                <a href="javascript:fn_egov_select2();"><spring:message code="button.search" /></a>
        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
        	            </span>
        	        </li>
                </ul>
        	</div>
        	<!-- List -->
        	<div id="table">
        		<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>
        				<col width="40"/>
        				<col width="100"/>
        				<col width="100"/>
        				<col width="80"/>
        				<col width="100"/>
        				<col width="60"/>
        			</colgroup>
        			<tr>
        				<th align="center">No</th>
        				<th align="center"><spring:message code="title.sample.vendorName" /></th>
        				<th align="center"><spring:message code="title.sample.vendorCode" /></th>
        				<th align="center"><spring:message code="title.sample.priceRetail" /></th>
        				<th align="center"><spring:message code="title.sample.shoppingFee" /></th>
        				
													<!-- title.sample.vendorName=판매처
													title.sample.vendorCode=판매처코드 
													title.sample.priceRetail=소비자 가격 
													title.sample.shoppingFee=배송비
													 -->	
													 
        			</tr>
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<%-- <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td> --%>
                <td align="center" class="listtd"><c:out value="${result.goodsNum}"/></a></td>
            				<td align="center" class="listtd"><a href="javascript:fn_egov_select3('<c:out value="${result.vendorCode}"/>')"><c:out value="${result.vendorName}"/></a></td>
            				<td align="center" class="listtd"><c:out value="${result.vendorCode}"/></a></td>
            				<td align="center" class="listtd"><c:out value="${result.priceRetail}"/></a></td>
            				<td align="center" class="listtd"><c:out value="${result.shoppingFee}"/></a></td>
            				
            				
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<form:hidden path="goodsNum" />
        	<!-- /List -->
     				<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        	
        	<div id="sysbtn">
        	  <ul>
        	      <li>
        	          <span class="btn_blue_l">
        	              <a href="javascript:fn_egov_selectList();"><spring:message code="button.goodslist" /></a>
                          <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                      </span>
                  </li>
                   <li>
        	          <span class="btn_blue_l">
        	              <a href="javascript:fn_egov_addView();"><spring:message code="button.create" /></a>
                          <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                      </span>
                  </li>
              </ul>
        	</div>
        </div>
 
					   <input type="hidden" name="selectedId" value="<c:out value='${searchVO.goodsNum}'/>"/>
        <%-- <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> --%>
 
    </form:form>
</body>
</html>
