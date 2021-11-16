<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

				<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui-custom.css'/>"  />
				<link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.jqgrid.css'/>" />
				<link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.multiselect.css'/>" />
				
				<script src="<c:url value='/js/jqgrid/jquery.js'/>" type="text/javascript"></script>
				<script src="<c:url value='/js/jqgrid/jquery-ui-custom.min.js'/>" type="text/javascript"></script>
				<script src="<c:url value='/js/jqgrid/jquery.layout.js'/>" type="text/javascript"></script>
				<script src="<c:url value='/js/jqgrid/grid.locale-en.js'/>" type="text/javascript"></script>
				<script type="text/javascript">
				   $.jgrid.no_legacy_api = true;
				   $.jgrid.useJSON = true;
				   
				</script>
				<script src="<c:url value='/js/jqgrid/ui.multiselect.js'/>" type="text/javascript"></script>
				<script src="<c:url value='/js/jqgrid/jquery.jqGrid.js'/>" type="text/javascript"></script>
				<script src="<c:url value='/js/jqgrid/jquery.tablednd.js'/>" type="text/javascript"></script>
				<script src="<c:url value='/js/jqgrid/jquery.contextmenu.js'/>" type="text/javascript"></script>
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
        	document.listForm.pageIndex.value = 1;
        	document.listForm.selectedId.value = goodsNum;
           	document.listForm.action = "<c:url value='/egovShopList.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	document.listForm.action = "<c:url value='/addGoodsSelect.do'/>";
           	document.listForm.submit();
        }
        

        /* 글 목록 화면 function */
        function fn_egov_selectList() {
        	
        	document.listForm.action = "<c:url value='/egovGoodsList.do'/>";
           	document.listForm.submit();
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovGoodsList.do'/>";
           	document.listForm.submit();
        }
        
        /* jqgrid function */
        function fn_egov_addGrid() {
           	document.listForm.action = "<c:url value='/addGrid.do'/>";
           	document.listForm.submit();
        }
        
       
	
    $(document).ready(function(){
							getgoodsList();
				});
				
			
				function getgoodsList(){
					
			        $.ajax({
			            type : "POST",            // HTTP method type(GET, POST) 형식이다.
			            url : "ajaxTest.do",      // 컨트롤러에서 대기중인 URL 주소이다.
			            data :$("#listForm").serialize(),            // Json 형식의 데이터이다.
			            datatype: "json",
			            /* async: this.asyncflag,  */
			         			success : function(data){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			                // 응답코드 > 0000
			                /* alert(data); */
			                alert("통신 성공")
			            },
			            error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			                alert("통신 실패.")
			            }
			        });		
					};
					

        
             
    </script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

    <form:form commandName="searchVO" id="listForm" name="listForm" method="post">

        <input type="hidden" name="selectedId" />
						
        <div id="content_pop">
        	<!-- 타이틀 -->
        	 
        	<div id="title">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/><spring:message code="list.sample2" /></li>
        		</ul>
        	</div>
        	 
        	<!-- // 타이틀 -->
        	<div id="search">
        		<ul>
        			<li>
        			  <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select path="searchCondition" cssClass="use">
        					<form:option value="1" label="상품명" />
        					<form:option value="0" label="상품번호" />
        				</form:select>
        			</li>
        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt"/>
                    </li>
        			<li>
        	            <span class="btn_blue_l">
        	                <a href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a>
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
        				<col width="300"/>
        				<col width="80"/>
        				<col width="100"/>
        				<col width="60"/>
        			</colgroup>
        			<tr>
        				<th align="center">No</th>
        				<th align="center"><spring:message code="title.sample.goodsNum" /></th>
        				<th align="center"><spring:message code="title.sample.goodsName" /></th>
        				<th align="center"><spring:message code="title.sample.imgUrl" /></th>
        				<th align="center">판매처</th>
        				
	
        			</tr>
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<!-- <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>-->
            			 <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.goodsNum}"/>')"><c:out value="${result.rN}"/></a></td>
            				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.goodsNum}"/>')"><c:out value="${result.goodsNum}"/></a></td>
            				<td align="left" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.goodsNum}"/>')"><c:out value="${result.goodsName}"/></a></td>
            				<td align="center" class="listtd"><img src ="${result.imgUrl}" width = "120" height = "120"/>&nbsp;</td>
            				<td align="center" class="listtd"><a href="javascript:fn_egov_select2('<c:out value="${result.goodsNum}"/>')"><input type="button" value="판매처"></input></a></td>
            				
            				
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- /List -->
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"/>
        		<form:hidden path="pageIndex" />
        	
        	</div>
        	<div id="sysbtn">
        	  <ul>
        	      <li>
        	          <span class="btn_blue_l">
        	              <a href="javascript:fn_egov_addView();"><spring:message code="button.create" /></a>
                          <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                      </span>
               </li>
                  
               <li>
        	          <span class="btn_blue_l">
        	              <a href="javascript:fn_egov_addGrid();"><spring:message code="button.jqgridtest" /></a>
                          <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                      </span>
               </li>
              </ul>
        	</div>
        </div>
    </form:form>
</body>
</html>
