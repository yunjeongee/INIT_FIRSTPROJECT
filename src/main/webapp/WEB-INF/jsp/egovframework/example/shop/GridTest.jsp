<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.jqgrid.css'/>" />
 
<script type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/jquery.jqGrid.min.js'/>"></script> --%>




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



<script>
$(document).ready(function() {
   
     var cnames = ['?????????','??????','????????????'];  /*???????????? ?????? ??????*/
     var data12 = {};
     var params = $("#listForm").serialize();
 
    $("#jqGrid").jqGrid({
        
        /* url: "jqGridTest.do", */
        datatype: "local",
        mtype:'POST',
        colNames : cnames,
        colModel:[
                  
                  {name:'goodsNum',index:'seq', width:55, key:true, align:"center"},
                  
                  {
                      name: 'imgUrl', index:'imgUrl',
                      width: 90,
                      fixed: true,
                      formatter: function (cellvalue, options, rowObject) {
                          if(cellvalue != null){
                          return "<img src='"+cellvalue+"' style='height:70px; width:70px;'/>"; 
                          }else{
                              return "<div style='text-align : center'>X</div>";
                          }
                      }
                  },
                  {name:'goodsName',index:'phone', width:100},                  

                  
                  ],
                  
        height: 480,
        rowNum: 5,
        width : 900,
        rowList: [10,20,30],
        pager: '#jqGridPager',
        rownumbers  : true,                     
        ondblClickRow : function(rowId, iRow, iCol, e) {
           
           
 
            if(iCol == 1) {
                alert(rowId +" ?????? ?????????.");
            }
        },
        
        viewrecords : true,
        caption:"JQGRID TABLE"
        });
    
    $("#request").on("click", function(){
          
        // json ???????????? ????????? set
        var params = {
               /*    name      : $("#name").val()
                , sex       : $("#sex").val()
                , age       : $("#age").val()
                , tellPh    : $("#tellPh").val() */
        }
            
        // ajax ??????
        $.ajax({
            type : "POST",            // HTTP method type(GET, POST) ????????????.
            url : "<c:url value='/ajaxTest.do'/>",      // ?????????????????? ???????????? URL ????????????.
            /* contentType: 'application/json' */
            data : data12,            // Json ????????? ???????????????.
            datatype: "json",
            /* async: this.asyncflag,  */
         			success : function(data){ // ?????????????????? ??????????????? success???????????? ???????????????. 'res'??? ???????????? ???????????????.
                // ???????????? > 0000
                /* alert(data); */
                 $('#jqGrid').jqGrid('clearGridData', true); 		
                 $('#jqGrid').jqGrid('setGridParam',{data:data.goodsList}).trigger('reloadGrid'); 
            },
            error : function(XMLHttpRequest, textStatus, errorThrown){ // ????????? ????????? ??????????????? error ???????????? ???????????????.
                alert("?????? ??????.")
            }
        });
    });
    
    });
    
    $(function(){
       
       
       
    });
    
</script>

</head>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm" method="post">
<input type="hidden" name="selectedId" value="1234"/>
<input type="hidden" name="gmgm" value="7777"/>
test
<div class="row">
   <div>
      <table id="jqGrid"></table>
      <div id="jqGridPager"></div>
   </div> 
</div>

                         <input type="button" value="??????" id="request"/>
                         
</form:form>                         
</body>
</html>