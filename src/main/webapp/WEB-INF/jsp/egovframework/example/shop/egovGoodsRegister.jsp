<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        
        /* ajax 이용해서 글 등록하기 */
        $(document).ready(function(){        
        
    				});
     
       function goGoodsList(){
        	
        	location.href= "egovGoodsList.do"
       
        }
        
       function insertGoods(){
		       
    	   	var goodsName = $("#goodsName").val();
        	var manufactureName = $("#manufactureName").val();
        	var manufactureCode = $("#manufactureCode").val();
        	var material = $("#material").val();
        	var goodsfunction = $("#goodsfunction").val();
        	
     
        if(manufactureName == ""){
        	alert("제조사를 입력해주세요.");
        	$("#manufactureName").focus();
        	return;
        }
        
        if(goodsName == ""){
        	
        	alert("상품명 입력해주세요.");
        	$("#goodsName").focus();
        	return;
        }
        
        if(goodsfunction == ""){
        	
        	alert("기능을 입력해주세요.");
        	$("#goodsfunction").focus();
        	return;
        }
        
        if(material == ""){
        	
        	alert("소재를 입력해주세요.");
        	$("#material").focus();
        	return;
        }
        
        var yn = confirm("상품을 등록하시겠습니까?");
        
        if(yn){
        	
        	  $.ajax({
                  type : "POST",            // HTTP method type(GET, POST) 형식이다.
                  url : "addGoods.do",      // 컨트롤러에서 대기중인 URL 주소이다.
                  data : $("#detailForm").serialize(),            // Json 형식의 데이터이다.
                  datatype: "json",          
               			success : function(data){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    alert("등록성공") 
               					insertGoodsCallback(data);
                  },
                  error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                     alert("등록실패")
                  }
              });
      			  }
       }
       
       
       
       
       function deleteGoods(){
		       
        var yn = confirm("상품을 삭제하시겠습니까?");
        
        if(yn){
        	
        	  $.ajax({
                  type : "POST",            // HTTP method type(GET, POST) 형식이다.
                  url : "deleteSample.do",      // 컨트롤러에서 대기중인 URL 주소이다.
                  data : $("#detailForm").serialize(),            // Json 형식의 데이터이다.
                  datatype: "json",          
               			success : function(data){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    alert("삭제성공") 
               					deleteGoodsCallback(data);
                  },
                  error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                     alert("삭제실패")
                  }
              });
      			  }
       }
       
       
       
       
        
        function insertGoodsCallback(data){
        	
        	if(data != null){
        		var result = data.result;
        		
        		if(result = "SUCCESS"){
        			alert("게시글 등록을 성공하였습니다.");
        			goGoodsList();
        		}
        		
        		else{
        			alert("게시글 등록을 실패하였습니다.");
        			return;
        			
        		}
      	}
    }
        
        function deleteGoodsCallback(data){
        	
        	if(data != null){
        		var result = data.result;
        		
        		if(result = "SUCCESS"){
        			alert("게시글 삭제를 성공하였습니다.");
        			goGoodsList();
        		}
        		
        		else{
        			alert("게시글 등록을 실패하였습니다.");
        			return;
        			
        		}
      	}
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
							
<!-- 										<tbody id="tbody">
											<tr>
												<th>등록<span class="t_red">*</span></th>
												<td><input id="manufacture_name" name="manufacture_name"
													value="" class="tbox01" /></td>
											</tr>
											<tr>
												<th>작성자<span class="t_red">*</span></th>
												<td><input id="goods_name" name="goods_name" value=""
													class="tbox01" /></td>
											</tr>
										</tbody> -->

					 <tr>
    					<td class="tbtd_caption"><label for="goodsNum"><spring:message code="title.sample.goodsNum" /></label></td>
    					<td class="tbtd_content">
    							<form:input path="goodsNum" maxlength="30" size ="60" cssClass="essentiality"/>
    							&nbsp;<form:errors path="goodsNum" />
    	    </td>
    		</tr> --%>
    		</tr>
      		
      		<tr>
    			<td class="tbtd_caption"><label for="manufactureName"><spring:message code="title.sample.manufactureName" /></label></td>
    			<td class="tbtd_content">
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
    		
    							<form:select path="manufactureCode" cssClass="use">
    							<option value = "none">--- 선택 ---</option>
    							<c:forEach var="manufacture" items="${resultManufacture}" varStatus="status">
    							<form:option value="${manufacture.manufactureCode}" label="${manufacture.manufactureName}" />				
    							</c:forEach>
     						</form:select> 					
     				</td>
     	</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="goodsName"><spring:message code="title.sample.goodsName" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="goodsName" maxlength="30" size ="60" cssClass="txt"/>
    				&nbsp;<form:errors path="goodsName" />
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
       
      <div class="btn_right mt15">
		       <button type="button" class="btn black mr5" onclick="javascript:goGoodsList();">목록으로</button>
		       <button type="button" class="btn black"  onclick="javascript:insertGoods();">등록하기</button>
		       <button type="button" class="btn black"  onclick="javascript:deleteGoods();">삭제하기</button>
						</div>
					</div>

    <!-- 검색조건 유지 -->
   <%--  <input type="hidden" name="imgUrl" value="<c:out value='${sampleVO.imgUrl}'/>"/> --%>
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> 
   

</form:form>


			<h1>파일 업로드</h1>
			<form action="fileupload", method="post" enctype="multipart/form-data">
			    <input type="file", name="uploadfile" placeholder="파일 선택" /><br/>
			    <input type="submit" value="업로드">
			</form>


</form:form>
</body>
</html>