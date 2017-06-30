<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.springframework.context.i18n.LocaleContextHolder"%>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="${static_path}/css/keywordsLayer.css?v_time=${v_time}"/>
    <link rel="stylesheet" type="text/css" href="${static_path}/css/multilayer-presale.css?v_time=${v_time}">
    <script type="text/javascript" src="${static_path}/js/iax-template.js?v_time=${v_time}"></script>
    <script type="text/javascript" src="${static_path}/js/keywordsLayer.js?v_time=${v_time}q"></script>
    <script type="text/javascript" src="${static_path}/js/multilayer-presale.js?v_time=${v_time}"></script>
    <script type="text/javascript" src="${static_path}/js/Sortable.js?v_time=${v_time}"></script>
	<script type="text/javascript" src="${static_path}/js/jQuery-File-Upload-9.11.2/js/vendor/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${static_path}/js/jQuery-File-Upload-9.11.2/js/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="${static_path}/js/jQuery-File-Upload-9.11.2/js/jquery.fileupload.js"></script>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=62a73830c63e6a4953da07f6dc92d898&plugin=AMap.Autocomplete,AMap.PlaceSearch"></script>
</head>
<body>
<%
    String lang  = LocaleContextHolder.getLocale().getLanguage();
    request.setAttribute("lang", lang);
    System.out.println("=======lang:"+lang);
%>

<div class="x-main">
    <div class="x-body" id="x-body">
        <div class="page_title">
            <div id="breadcrumb" class="row">
                <!-- Top left headings and links -->
            </div>
            <div class="row">
                <div class="client-row"><h1><s:message code="audiencePlan.form.title" /> </h1></div>
            </div>
        </div>
        <!-- Page title -->
        <!--                   feature 相关                    -->
        <form:form modelAttribute="audiencePlan" method="post" id="primaryForm" enctype="multipart/form-data" class="form-horizontal" action="${path}/audiencePlan/${action}">
            <input type="hidden" name="planId" id="planId" value="${audiencePlan.planId}"/>
            <input type="hidden" name="name" id="name" value="${audiencePlan.name}"/>
            <input type="hidden" name="clientId" id="clientId" value="1001"/>
            <div class="feature-main">
                <div class="feature-content" >
                    <div class="feature-inner" style="margin:0">
                        <div class="feature-detail feature-plan">
                            <div class="feature-plan-search toggle-down">
                                <div class="feature-plan-search-title">
                                    <i class="fa fa-caret-down"></i>
                                    <span class="round" aria-hidden="true">1</span>
                                    <label><s:message code="audiencePlan.form.defineBrand" /> </label>
                                </div>
                                <jsp:include page="include/ownBrand.jsp"></jsp:include>
                            </div>
                            <!-- define my competitiors-->
                            <div class="feature-plan-search">
                                <div class="feature-plan-search-title">
                                    <i class="fa fa-caret-right"></i>
                                    <span class="round" aria-hidden="true">2</span>
                                    <label><s:message code="audiencePlan.form.defineCompetitors"/></label>
                                </div>
                                <div class="feature-plan-search-content hide">
                                    <!-- my competitor container-->
                                    <div class="plan-container">
                                        <label class="plan-title">
                                            <s:message code="audiencePlan.form.tellCompetitors"/>
                                        </label>
                                        <div class="competitors" id="competitors">
                                            <jsp:include page="editCompetitor.jsp"></jsp:include>
                                        </div>
                                        <div class="addCompetitors plan-group">
                                            <button type="button" class="btn btn-success addCompetitor" onclick="addCompetitor();">
                                                <i class="fa fa-plus"></i>
                                                <s:message code="audiencePlan.form.competitor"/>
                                            </button>
                                        </div>
                                    </div>
                                    <!-- my competitor container end-->
                                </div>
                            </div>
                            <!-- advanced settings -->
                            <div class="feature-plan-search">
                                <div class="feature-plan-search-title">
                                    <i class="fa fa-caret-right"></i>
                                    <span class="round" aria-hidden="true">3</span>
                                    <label><s:message code="audiencePlan.form.advancedSetting"/></label>
                                </div>
                                <jsp:include page="include/advancedSetting.jsp"></jsp:include>
                            </div>
                            <div class="clearboth"></div>
                        </div>

                    </div>
                </div>
                <div class="clearboth"></div>
                <div style="height:70px"></div>
            </div>
        </form:form>
    </div>
    <!-- footer -->
    <div class="clearfooter"></div>
    <div class="myfooter" style="text-align:left;position: fixed;height: 100px;bottom: 0;">
        <div class="split-area"></div>
        <div class="page-opt">
            <button type="button" class="btn btn-success" disabled><s:message code="audiencePlan.form.save"/></button>
            <button type="button" class="btn btn-cancel"><s:message code="audiencePlan.form.Cancel"/></button>
        </div>
    </div>
</div>
<script type="text/javascript">


    $(function(){
        $(document).on("focus",".plans input",function() {
            if($(this).parent().next().hasClass("warn-message")){
                $(this).parent().next().removeClass("hide");
            }
        })
        $(document).on("blur",".plans input",function() {
            if($(this).parent().next().hasClass("warn-message")){
                $(this).parent().next().addClass("hide");
            }
        })
        $(document).on("click",".feature-main .feature-plan-search-title",function(){
            $(this).parent().parent().find(".feature-plan-search-content").slideUp();
            var $fa = $(this).find(".fa");
            var isUp = $fa.hasClass("fa-caret-right");
            $(this).parent().parent().find(".fa-caret-down").removeClass("fa-caret-down").addClass("fa-caret-right");
            $(this).parent().parent().find(".toggle-down").removeClass("toggle-down");

            if(isUp){
                $fa.removeClass("fa-caret-right").addClass("fa-caret-down");
                $(this).parent().addClass("toggle-down");
                $(this).next().slideDown();
            }else{
                $fa.removeClass("fa-caret-down").addClass("fa-caret-right");
                $(this).parent().removeClass("toggle-down");
                $(this).next().slideUp();
            }

        })

        //category choose option
        var data= ${audiencePlan.interestLab};
        //初始化 category 下拉框
        var doms = "";

        function makeDom(data){
            for(var i=0;i<data.length;i++){
                try{
                    doms += '<li><a href="javascript:;" data-id="'+data[i].audience_id+'">'+data[i].name+'</a>';
                    if(data[i]["children"] != null && data[i]["children"].length>0){
                        doms += '<ul class="childs" style="display:none">';
                        makeDom(data[i]["children"]);
                        doms += '</ul>';
                    }
                    doms += "</li>";
                }catch(e){}
            }
            return doms;
        }
        makeDom(data);
        $("#category").parent().find(".dropdown-tree-category .parent_layer .tree").html(doms);
        $("#category").parent().find(".parent_layer .tree ul").each(function(index, element) {
            var ulContent = $(element).html();
            if(ulContent){
                $(element).prev().after('<i  class="fa fa-plus-square"></i>') ;
            }
        });


        $(document).on("click",".dropdown-stop",function(){
            $(this).parent().hasClass("open") ? $(this).parent().removeClass("open") : $(this).parent().addClass("open") ;
        })

        $(document).on("hover",".tree-stop",function(){
            $("body").unbind("mousedown");
        })
        $(document).on("hoverover",".tree-stop",function(){
            $("body").bind("mousedown",function(){
                $(".tree-stop").removeClass("open");
            })
        })

        $(document).on("click",".dropdown-tree-category .tree li>a",function(e){
            e = e||window.event;
            var target = e.target||e.srcElement;
            if (target.nodeName=="I") return;
            var $dropdown = $(this).parents(".dropdown");
            var text = $(this).text();
            var type = $dropdown.find(".dropdown-toggle").attr("data-type");
            if(type === "plan"){
                if($(this).parent().find(".childs:first").prev()[0] && $(this).parent().find(".childs:first").prev()[0].nodeName =="SPAN") return;
                $(this).parents(".tree").find(".active").removeClass("active");
                $(this).parent().addClass("active");
                var lis = $(this).parent().find(".childs").html();
                $(this).parents(".tree").parent().nextAll().each(function(){
                    $(this).find(".tree").empty();
                    if ($(this).find(".tree").parent().find("[name='plan_text']").length>0) {
                        $(this).find(".tree").parent().find("[name='plan_text']").val("");
                    }
                })
                $(this).parents(".tree").parent().next().find(".tree").html(lis);
                if ($(this).parents(".tree").prev()[0].nodeName=="INPUT") {
                    var parentText = $(this).parents(".childs").prev().text()+" / ";
                    var text = $(this).parent().find("a:first").text();
                    $(this).parents(".tree").prev().val(parentText+text);
                };
                var index = $(this).parents(".tree").parent().index();
                if (index!=$(this).parents(".dropdown-tree-category").find(".tree").length-1) {
                    return;
                };

                var keyWords = $(this).attr("data-keywords");
                var dataId = $(this).attr("data-id");
                if(keyWords){
                  var layer_div = $(this).parents(".choose-from-plan").next();
                  var result =  keyWords.split(",")
                  fillKeyWords(layer_div,result);
                }
                if (dataId){
                    var type = 'product';
                    if (dataId == 'all'){
                        dataId = $(this).attr("data-brand-id");
                        type = 'brand';
                    }
                    var isCompetitorProduct = $(this).parents(".choose-from-plan").parent().attr("class") == "competitor_products";
                    console.log(isCompetitorProduct);
                    if (isCompetitorProduct){
                       var  maxCompetitorIndex = parseInt($(".competitors .plan-competitor").find(".maxCompetitorIndex").last().val());
                      addCompetitorProduct(maxCompetitorIndex,dataId,type);
                    }else{
                       addProduct(dataId,type);
                    }
                }

                //choose plan 赋值，要把关联的父节点信息一起显示，目前只是把内容赋值进去
                var parentLayerText = $dropdown.find('.parent_layer').find(".active").find("a:first").text() + " / ";
                var parent = $(this).parents(".dropdown-tree-category").find("[name='plan_text']").map(function(){
                    return $(this).val();
                }).get().join(" / ")
                if($(this).parents(".parent_layer").length>0){
                    parentLayerText = $(this).text();
                    parent = "";
                }
                var aHtml = "";//"<a href='javascript:;' class='bluelink' style='margin-left:10px;' onclick='$(this).parent().empty();'>Remove</a>"
                $dropdown.find(".dropdown-plan-infos").html(parentLayerText+parent+aHtml);
            }else{
                //categories赋值
                $dropdown.find(".dropdown-toggle").html(text+'<span class="caret arrow-down"></span>');
                $dropdown.find("input:first").val($(this).attr("data-id")).change();
            }
            $dropdown.removeClass("open");
        })
        $(document).on("click",".dropdown-tree-category .tree li>i",function(e){
            e = e || window.event;
            var target = e.target || e.srcElement;
            e.stopPropagation();
            if (target.nodeName == "I") {
                if ($(this).hasClass("fa-plus-square")) {
                    $(this).removeClass("fa-plus-square").addClass("fa-minus-square");
                    $(this).next().show();
                }else{
                    $(this).removeClass("fa-minus-square").addClass("fa-plus-square");
                    $(this).next().hide();
                }
            };
        })

        //category choose option end

        //子选项显示隐藏
        $(document).on("click",".showHideIco",function(){
            var isShow = $(this).hasClass("fa-plus-square");
            if(isShow){
                $(this).removeClass("fa-plus-square").addClass("fa-minus-square");
                $(this).parent().find(".plans").slideDown();
            }else{
                $(this).removeClass("fa-minus-square").addClass("fa-plus-square");
                $(this).parent().find(".plans").slideUp();
            }
        })


        //***********************my brand 相关逻辑
        //至少要填第一步my brand 中的name, category, keywords
        $(document).on("change","[id='ownBrandName']",function(){
            var value = $(this).val();
            if ($.trim(value)!="") {
                justifyBrand();
            }else{
                $(".page-opt").find(".btn-success").attr("disabled",true);
            }
        })
        $(document).on("change","[id='category']",function(){
            var value = $(this).val();
            if ($.trim(value)!="") {
                justifyBrand();
            }else{
                $(".page-opt").find(".btn-success").attr("disabled",true);
            }
        })
        $(document).on("change",".brandResult",function(){
            var value = $(this).val();
            if ($.trim(value)!="") {
                justifyBrand();
            }else{
                $(".page-opt").find(".btn-success").attr("disabled",true);
            }
        })
        function justifyBrand(){
            var brandName = $("[id='ownBrandName']").val();
            var brandCategory = $("[id='category']").val();
            var brandResult = $(".brandResult").val();
            if ($.trim(brandName)=="" || $.trim(brandCategory)=="" || $.trim(brandResult)=="" ) {
                $(".page-opt").find(".btn-success").attr("disabled",true);
            }else{
                $(".page-opt").find(".btn-success").attr("disabled",false);
            }
        }

        //***********************product description suggest 相关逻辑
        $(document).on("change",".product-suggest [id='product']",function(){
            var json = eval("("+$(this).parent().parent().find("[name='product_json']").val()+")");
            json.product = $(this).val();
            $(this).parent().parent().find("[name='product_json']").val(JSON.stringify(json)).change();
        })
        $(document).on("change",".product-suggest [name='enter_history']",function(){
            var json = eval("("+$(this).parents(".product-suggest-con").find("[name='product_json']").val()+")");
            json.category = $(this).val();
            $(this).parents(".product-suggest-con").find("[name='product_json']").val(JSON.stringify(json)).change();
            //将之前的enter_history的值放到下拉框中
            var historyArr = $("[name='enter_history']").map(function(){
                if ($(this).val()!="") {
                    return $(this).val();
                };
            }).get();
            historyArr = IAX_TOOL.outRepeat(historyArr);
            var lisHtml = historyArr.map(function(data,i){
                return "<li data-value='"+data+"'><a href='javascript:;'>"+data+"</a></li>";
            }).join("");
            $(this).parents(".product-suggest").attr("data-hide","hide");
            $(".product-suggest").each(function(){
                if (!$(this).attr("data-hide")) {
                    $(this).find(".dropdown-menu").html(lisHtml);
                };
            })
            $(this).parents(".product-suggest").attr("data-hide","");
            $(this).parents(".product-suggest-area").find("[id='productCategory']").val($(this).val());
        })



        $(document).on("click",".product-suggest .bluelink",function(){
            var $con = $(this).parents(".products-con");
            var $planCon = $(this).parents(".plan-container");
            var $planGroup = $(this).parents(".plan-group")
            var index = $(this).parent().parent().index();
            $(this).parent().parent().remove();
            var productId = $(this).parent().find("[id='productId']").val();
            if(productId != null && productId != undefined){
                $("#primaryForm").append('<input type="hidden" name="deleteProductIds" value="' + productId + '" />');
            }
            resetSuggestIndex($con);
            //如果是competitor中的product，则额外要判断plus competitor的状态
            if($planGroup.parent().hasClass("plan-competion-con")){
                var data = $planGroup.parent().parent().find("[name=competitor_json]").val();
                var json = eval("("+data+")");
                if (json.products && json.products.length>0) {
                    for (var i = 0,flag=true; i < json.products.length; flag ? i++ : i) {
                        if(json.products[i] && index == json.products[i].index){
                            json.products.splice(i,1);
                            flag = false;
                        }else{
                            flag = true;
                        }
                    };
                };
                $planGroup.parent().parent().find("[name=competitor_json]").val(JSON.stringify(json)).change();
            }
        })
        function resetSuggestIndex(_this){
            $(_this).find(".product-suggest-con").each(function(i){
                $(this).attr("id","row_product_"+i);
                $(this).find(".product-suggest-index").text("#"+(i+1));
            })
        }


        $(document).on("click",".enter-select-con .dropdown-menu li",function(){
            var text = $(this).find("a").text();
            var value = $(this).attr("data-value");
            $(this).parents(".enter-select-con").find("input:first").val(value);
            $(this).parents(".enter-select-con").find(".enter-select-enter").find("input").show().val(text).change();
            $(this).parents(".enter-select-con").find(".enter_placeholder").hide();
        })

        $(document).on("click",".enter-select-enter .enter_placeholder",function(){
            $(this).hide();
            $(this).next().show();
            $(this).next().focus();
        })
        $(document).on("blur",".enter-select-enter input",function(){
            var inputVal = $(this).val();
            if($.trim(inputVal)==""){
                $(this).hide();
                $(this).prev().show();
                $(this).prev().focus();
            }
        })

        $(document).on("click",".product-suggest-enter-area",function(e){
            e = e || window.event;
            // e.stopPropagation();
            var $input = $(this).find(".selected-search").length>0 ? $(this).find(".selected-search input") : $(this).find("input");
            !$input.is(":hidden") && $input.focus();
        })

        $(document).on("click",".product-suggest-enter-area .fa-plus-circle",function(){
            var addInput = $(this).next().val();
            var $selectArea = $(this).parent().find(".selected-area");
            if($selectArea.find(".selected-tag").length>0){
                //如果已经输入，则取ul里面的input
                addInput = $selectArea.find("input").val();
                $selectArea.find("input").val("");
            }
            addText($selectArea,addInput);

        })
        //输入框回车
        $(document).on("keyup",".product-suggest-enter-area input",function(e){
            e = e || window.event;
            if(e.keyCode==13){
                $(this).parents(".product-suggest-enter-area").find(".fa-plus-circle").click();
            }
        })
        function addText($selectArea,addInput){
            var limit = 10;
            var currentLength = $selectArea.find(".selected-tag").length;
            var searchHtml = '';
            if ($.trim(addInput)=="") {return;};
            if($selectArea.find(".selected-tag").length==0){
                //如果还没有输入description，则隐藏初始input，增加新的input到ul里面
                $selectArea.prev().val("");
                $selectArea.prev().hide();
                searchHtml = '<li class="selected-search"><input type="text" class="hide-enter" /></li>';
            }
            searchHtml!="" && $selectArea.append(searchHtml);
            //超过上限不能增加且显示提示信息
            if(currentLength==limit-1){
                $selectArea.parent().find(".fa-plus-circle").hide();
                $selectArea.find("input").hide();
                $selectArea.parent().addClass("suggest-warnning");
                $selectArea.next().find(".area-mesage").text("You can add max. "+limit+" descriptions");
            }
                var productKeyWords = $selectArea.parent().parent().parent().find("input.productKeyWords");
                if(productKeyWords.val() == null || productKeyWords.val() == ""){
                    productKeyWords.val(addInput);
                }
                else{
                    productKeyWords.val(productKeyWords.val()+","+addInput);
                }
            $selectArea.find(".selected-search").before('<li class="selected-tag"><span>'+addInput+'</span><i class="fa fa-close" aria-hidden="true"></i></li>');
            $selectArea.next().find("button").attr("disabled",false);
            suggestChange($selectArea);
        }
        $(document).on("click",".product-suggest-enter-area .area-button .btn-success",function(){
        	var array = [];
        	for(var a = 0; a < $(this).parent().parent().find("ul span").length; a++){
        		array.push($(this).parent().parent().find("ul span").eq(a).html());
        	}
        	if(array.length <= 0){
                return;
            }
            var $suggestArea = $(this).parent().parent().next();
            //ajax请求suggest数据
            $.ajax({
		        type: 'get',
		        dataType: "json",
				url: "${path}/ajax/getKeywords?keyWord=" + array.join(","),
				success: function(data){
//					console.log(data);
		            var successData = data;
		            if (successData.length>0) {
		                $suggestArea.find(".suggest-area-init").hide();
		                $suggestArea.find(".selected-area").empty();
		                for(var i=0,j=successData.length-1;i<=j;i++){
		                    var tagHtml = '<li class="selected-tag"><span class="fa fa-angle-left"></span><span>'+successData[i]+'</span></li>';
		                    $suggestArea.find(".selected-area").append(tagHtml);
		                }
		            };
				}
			})
        })
        $(document).on("click",".selected-area .fa-close",function(){
            var limit = 10;
            var str = $(this).parent().find("span").html();
            var $selectArea = $(this).parents(".selected-area");
            var currentLength = $selectArea.find(".selected-tag").length;
            //去除提示信息，回复增加按钮
            if (currentLength==limit) {
                $selectArea.find(".selected-search input").show();
                $selectArea.parent().find(".fa-plus-circle").show();
                $selectArea.parent().removeClass("suggest-warnning");
                $selectArea.next().find(".area-mesage").text("");
            };
            $(this).parent().remove();
            //如果是最后一个，则要吧ul里面搜索框变成初始搜索框
            if (currentLength == 1) {
                $selectArea.empty();
                $selectArea.prev().show();
                $selectArea.next().find("button").attr("disabled",true);
            };
            var productKeyWords = $selectArea.parent().parent().parent().find("input.productKeyWords");
            var array = productKeyWords.val().split(",");
            var index = $.inArray(str,array);
            if(index >= 0){
            	array.splice(index,1);
                productKeyWords.val(array.join(","))
            }
            suggestChange($selectArea);
        })
        $(document).on("click",".selected-area .fa-angle-left",function(){
            var addInput = $(this).next().text();
            var $enterArea = $(this).parents(".product-suggest-suggest-area").prev();
            var $selectArea = $enterArea.find(".selected-area");
            var currentSuggestLength = $(this).parents(".selected-area").find(".selected-tag").length;
            var limit = 10;
            var currentLength = $selectArea.find(".selected-tag").length;

            //等于上限不添加
            if (currentLength == limit) {
                return;
            };

            addText($selectArea,addInput)

            //如果之前suggest为1的时候，就要回复初始化信息
            if (currentSuggestLength == 1) {
                $(this).parents(".selected-area").prev().show();
            };
            $(this).parent().remove();

        })

        //**************************product description suggest 相关逻辑 end

        //**************************competitors 相关逻辑 begin

        $(document).on("change",".plan-competitor [id='competitorName']",function(){
            var json = eval("("+$(this).parents(".plan-competitor").find("[name='competitor_json']").val()+")");
            json.competitorName = $(this).val();
            $(this).parents(".plan-competitor").find("[name='competitor_json']").val(JSON.stringify(json)).change();
        })

        $(document).on("change",".plan-competitor [id='result']",function(){
            var json = eval("("+$(this).parents(".plan-competitor").find("[name='competitor_json']").val()+")");
            json.keywordResult = $(this).val();
            $(this).parents(".plan-competitor").find("[name='competitor_json']").val(JSON.stringify(json)).change();
        })
        $(document).on("change",".plan-competitor [name='product_json']",function(){
            var json = eval("("+$(this).parents(".plan-competitor").find("[name='competitor_json']").val()+")");
            //根据产品index找到对应产品并修改
            var product_json = eval("("+$(this).val()+")");
            var isNew = true;
            if (!json.products) {
                json.products = [];
                json.products.push(product_json);
            }else{
                for(var i=0;i<json.products.length;i++){
                    if (product_json.index == json.products[i].index) {
                        json.products[i] = product_json;
                        isNew = false;
                    };
                }
                if (isNew) {
                    json.products.push(product_json);
                };
            }
            $(this).parents(".plan-competitor").find("[name='competitor_json']").val(JSON.stringify(json)).change();
        })
        $(document).on("change",".plan-competitor [name='competitor_json']",function(){
            watchPlusCompetitor($(this).parents(".plan-container").find(".addCompetitor"));
        })
        function watchPlusCompetitor($btn){
            var isDisabled = false;
            $btn.parents(".plan-container").find("[name='competitor_json']").each(function(){
                if (!isDisabled) {
                    isDisabled = verifyCompetitor($(this).val());
                };
            })
            $btn.attr("disabled",isDisabled);
        }
        function verifyCompetitor(value){
            var json = eval("("+value+")");
            var isDisabled = false;
            if(!json.keywordResult || !json.competitorName){
                isDisabled = true;
            }
            return isDisabled;
        }
//初始化keywordsLayer插件
        $("[name='keywordsLayer']").each(function(){
        	var valueStr = $(this).attr("data-keywords");
        	var array = valueStr.split(",");
        	var values = [];
        	for(var i = 0; i < array.length; i++){
        		values.push({"name": array[i]});
        	}
            initkeyLayer(this,values);
        })

        //移除competitor
        $(document).on("click",".plan-info-edit [name='removeCompetitor']",function(){
            var content = $(this).parent().prev().text();
            var id = $(this).parents(".plan-competitor").attr("id");
            var paramJson = {
                'title' : 'Confirm to remove this competitor?',
                'content' : content,
                'cancel' : "Cancel",
                'save' : "Remove",
                'fn' : 'removeCompetitor("'+id+'");',
            }
            IAX_TOOL.confirmBox(paramJson);
        })


        //编辑competitor
        $(document).on("click",".plan-competitor .fa-arrow",function(){
            var isHide = $(this).parent().find(".plan-info label").is(":hidden");
            if (isHide) {
                $(this).parent().find(".plan-competion-con").slideUp();
                $(this).parent().find(".plan-info label").show();
                $(this).removeClass("fa-caret-down").addClass("fa-caret-right");
            }else{
                $(this).parent().find(".plan-competion-con").slideDown();
                $(this).parent().find(".plan-info label").hide();
                $(this).removeClass("fa-caret-right").addClass("fa-caret-down");
            }

        })

        $("#region_city").chosen();

        //location输入提示。。。
        var auto = new AMap.Autocomplete({
            input: "tipinput"
        });
        //advanced settings 添加location
        $(document).on("click",".plus-area .btn",function() {
            var length = $(this).parent().parent().find("input").length,max=5;
            var id = "tipinput_"+new Date().getTime();
            var $clone= $('<div style="position:relative"><input type="text" value="" id="'+id+'" placeholder="Search" name="Locations" class="location"><i class="fa fa-remove input-remove"></i></div>');
            $(this).parent().before($clone);
            if (length == max-1) {
                $(this).parent().hide();
            }
            $clone.find("input").focus();
            new AMap.Autocomplete({
                input: id
            });
        })
        $(document).on("click",".input-remove",function(){
            $(this).parent().parent().find(".plus-area").show();
            $(this).parent().remove();
        })

        //保存计划
        $(document).on("click",".page-opt .btn-success",function(){
            var brandName = $("[id='ownBrandName']").val();
            var date = new Date().Format("yyyyMMdd");
            var params = [],paramsJson={};
            var value = $("#primaryForm").find("[name='name']").val();
            paramsJson.input={'label':'Plan Name','name':'name','value':value? value : (brandName+'_'+date)};
            params.push(paramsJson);
            var paramJson = {
                'title' : 'Do you want to save this plan?',
                'params' :params,
                'cancel' : "Cancel",
                'save' : "Save",
                'fn' : "savePlan(this)",
                'callbackFun':setBtnDisabled
            }
            IAX_TOOL.confirmBox(paramJson);
        })
        function setBtnDisabled(){
            var $form = $(".modal").find("form");
            $form.on("keyup","[name='name']",function(){
                if($(this).val()!=""){
                    $form.parents(".modal").find(".btn-success").attr("disabled",false);
                }else{
                    $form.parents(".modal").find(".btn-success").attr("disabled",true);
                }
            })
        }
        //取消计划
        $(document).on("click",".page-opt .btn-cancel",function(){
            var paramJson = {
                'title' : 'Your plan has been saved.',
                'content' : 'Back to Audience Plan List?',
                'cancel' : "Cancel",
                'save' : "Go back to Plan List",
                'fn' : "cancelPlan()"
            }
            IAX_TOOL.confirmBox(paramJson);
        })

        //显示隐藏相关

        $(document).on("click",".select-radio-con input",function(){

            var beforeRadio = $(this).parent().parent().find("[checked='checked']");
            var _this = this;
             rollBackRadio = rockBackRadioCheck.bind(_this);
            if (beforeRadio.val() != $(this).val()){
            if ($(this).parents(".plans").children(".keywords-con").length > 0){
                clearKeyWords = emptyKeyWords.bind(_this);
                var paramJson = {
                    'title' : '<s:message code="audiencePlan.form.changeKeywordsInputType" />',
                    'cancel' : "No",
                    'save' : "Yes",
                    'fnCancel': "rollBackRadio()",
                    'fn' : "clearKeyWords()"
                }
                IAX_TOOL.confirmBox(paramJson);
            }

            if($(this).parents(".plans").children(".products").length > 0 || $(this).parents(".plans").children(".competitor_products").length > 0){
                clearProducts = emptyProduct.bind(_this);
                var paramJson = {
                    'title' : '<s:message code="audiencePlan.form.changeProuductInputType" />',
                    'cancel' : "No",
                    'save' : "Yes",
                    'fnCancel': "rollBackRadio()",
                    'fn' : "clearProducts()"
                }
                IAX_TOOL.confirmBox(paramJson);
            }

            if($(this).parents(".plans").children(".location-con").length > 0){
                clearRegion = emptyRegion.bind(_this);
                var paramJson = {
                    'title' : '<s:message code="audiencePlan.form.changeLocationInputType" />',
                    'cancel' : "No",
                    'fnCancel': "rollBackRadio()",
                    'save' : "Yes",
                    'fn' : "clearRegion()"
                }
                IAX_TOOL.confirmBox(paramJson);
            }

            }
        });

        $('.fileStyle').fileupload({
        	add: fileAdd,
        	autoUpload: false,
            dataType: 'json',
            done: fileDone
        });
        //新增时默认添加ownBrand产品和competitor
        <c:if test="${action eq 'create' }">
        addProduct();
        addCompetitor();
        </c:if>
        //编辑时填充产品历史category，初始化product_json，填充关键词
        <c:if test="${action eq 'update'}">
        $(".products-con .product-suggest-con").each(function () {
            $(this).find("#product").change();
            $(this).find(".product-suggest [name='enter_history']").change();
            $(this).find(".enter_placeholder").hide();
            $(this).find(".enter_placeholder").next().show();
            suggestChange($(this).find(".selected-area"));
        })
        </c:if>
    });



   //清空关键词
    var clearKeyWords;
    function emptyKeyWords() {
        $(this).parents(".plans").find(".keywords-con .parent_layer .tree").empty();
        $(this).parents(".plans").find(".keywords-con #result").val("").change();
        var _this = $(this);
        showPlanOrUpload(_this);
    }
   //清空产品
    var clearProducts;
    function emptyProduct() {
        var isCompetitorProduct = $(this).parents(".plans").children(".competitor_products").length > 0 ? true : false;
        if (isCompetitorProduct){
            $(this).parents(".plans").find(".competitor_products .products-con").children().remove();
            var data = $(this).parents(".plan-competitor").find("[name='competitor_json']").val();
            var json = eval("("+data+")");
            if (json.products && json.products.length>0) {
                json.products = [];
                $(this).parents(".plan-competitor").find("[name='competitor_json']").val(JSON.stringify(json)).change();
            }
            var competitorIndex = $(this).parents(".plan-competitor").find(".maxCompetitorIndex").val();
            if ($(this).parents(".plans").children(".competitor_products").find(".product-suggest-con").length == 0 && $(this).val() == '0' ){
              addCompetitorProduct(competitorIndex);
            }
        }else{
            $(this).parents(".plans").find(".products .products-con").children().remove();
            if ($(this).parents(".plans").children(".products").find(".product-suggest-con").length == 0 && $(this).val() == '0' ){
                addProduct();
            }
        }
        var _this = $(this);
        showPlanOrUpload(_this);
    }
    //清空location
    var clearRegion;
    function emptyRegion() {
        var region = $(this).parents(".plans").find(".location-con .location-suggest-con #region_city");
        region.val("1156110000");
        region.trigger("liszt:updated");
        var keywords = $(this).parents(".plans").find(".location-con .location-suggest-con:nth-child(2)");
        if (keywords.find(".input-remove").length > 0){
            keywords.find(".input-remove").each(function(){
                $(this).trigger("click");
            })
        }
        keywords.find("#tipinput").val("");
        keywords.find("#regionInput").val("");
        var _this = $(this);
        showPlanOrUpload(_this);
    }

    function showPlanOrUpload(_this) {
        var target = $(_this).attr("data-target");
        $(_this).parents(".plans").find(".uploadfile").parent().hide();
        $(_this).parents(".plans").find(".chooseplan").parent().hide();
        if (target!="") {
            $(_this).parents(".plans").find("."+target).parent().show();
        }

        var beforeRadio = $(_this).parent().parent().find("[checked='checked']");
        beforeRadio.removeAttr("checked");
        $(_this).attr("checked","checked");
    }

    var rockRaio;
    function rockBackRadioCheck(){
        $(this).parent().parent().find("[checked='checked']").attr("checked",true);
    }

    function fileAdd(e, data) {
        var uploadErrors = [];
        
        var fileType = data.files[0].name.split('.').pop(), allowdtypes = 'xlsx';
        /* if (allowdtypes.indexOf(fileType) < 0) {
            uploadErrors.push(data.files[0].name+' : '+'<spring:message code='public.fileTypeError'/>');
        }
        if(uploadErrors.length == 0 && data.originalFiles[0]['size'] && data.originalFiles[0]['size'] > 1048576*4) {
            uploadErrors.push(data.files[0].name+' : '+'<spring:message code='public.maxfilesize'/>');
        } */
        if(uploadErrors.length > 0) {
        	$.each(uploadErrors, function (index, error) {
                $("#errorMessange").html('<p style="color: red;">' + error + '</p>');
            });
        	return false;
        } else {
            data.submit();
        }
	}

    function fileDone(e, data) {
    	var result = data["result"]["result"];
    	var layer_div = $(this).parent().parent().next().next();
        fillKeyWords(layer_div,result);
    }

    //填充导入关键词
    function fillKeyWords(layer_div,result) {
        //清空原来的关键词
        $(layer_div).parents(".plans").find(".keywords-con .parent_layer .tree").empty();
        $(layer_div).parents(".plans").find(".keywords-con #result").val("").change();
        //填充导入的关键词
        for(var index = 0; layer_div.find(".tree").eq(0).find("li").length <= 20 && result.length > index; index++){
            var label = result[index];
            var input_val = layer_div.children().first().val();
            if(input_val != null && input_val.length > 0){
                input_val += "," + label;
            }
            else{
                input_val = label;
            }
            layer_div.children().first().val(input_val);
            layer_div.find(".parent_layer .tree").append('<li><span title="'+label+'">&nbsp;'+label+'</span><input type="text" class="keywords_input" style="display:none" value="'+label+'"><label class="delete"><i class="fa fa-remove"></i></label></li>')
        }
        layer_div.find("#result").change();
        layer_div.find(".btn-success").attr("disabled", false);
    }



    //取消计划
    function cancelPlan(){
        window.location = "${path}/audiencePlan";
    }
    //保存plan
    function savePlan(_this) {
        //组装location值
        var location ="";
        $(".location-suggest-con .location").each(function () {
            console.log($(this).val());
            if ($.trim($(this).val()) != ""){
                if (location == ""){
                    location = $(this).val();
                }else {
                    location = location + "," +$(this).val();
                }
            }
        })
        $("#regionInput").val(location);
        //子form获取值
        var $form = $("#primaryForm");
        var $subForm = $(_this).parents(".modal").find("form");
        var value = $subForm.find("[name='name']").val();
        $form.find("[name='name']").val(value);
        $("#primaryForm").submit();
    }

    //删除competitor
    function removeCompetitor(id){
        var $btn = $("#"+id).parent().find(".addCompetitor");
        var $parent = $("#"+id).parent();
        var brandId = $("#"+id).find("[id='brandId']").val();
        if(brandId != null && brandId != undefined){
            $("#primaryForm").append('<input type="hidden" name="deleteBrandIds" value="' + brandId + '" />');
        }
        $("#"+id).remove();
        var isDisabled = false;
        $btn.parents(".plan-container").find("[name='competitor_json']").each(function(){
            if (!isDisabled) {
                var json = eval("("+$(this).val()+")");
                if(!json.keywordResult || !json.competitorName){
                    isDisabled = true;
                }
            };
        })
        $btn.attr("disabled",isDisabled);
        resetCompetitorIndex($parent);
    }

    function resetCompetitorIndex(_this) {
        $(_this).find(".plan-competitor").each(function(i){
            var id = i+1;
            $(this).find(".plan-title").text("Competitor "+id);
        })
    }

    function uploadFile(_this){
        $(_this).parent().find('.uploadText').text(_this.value);
//        $(_this).parent().find('.uploadText').next().show();
    }
    function removeUpload(_this){
        $(_this).hide();
        $(_this).prev().text("");
        $(_this).parent().parent().find(".fileStyle").val("");
    }

    function addCompetitor(){
        var competitorIndex = $(".competitors").children(".plan-competitor").length +1;
        var maxCompetitorIndex = competitorIndex;
        if (competitorIndex > 1){
            maxCompetitorIndex = parseInt($(".competitors .plan-competitor").find(".maxCompetitorIndex").last().val());
            maxCompetitorIndex += 1;
        }
        //把之前展开的comeptitor都缩放成一行
        $(".competitors").children(".plan-competitor").each(function(){
                $(this).find(".plan-info").remove();
                $(this).find(".fa-arrow").remove();
                var html = '<div class="plan-info">'+
                    '  <label>'+$(this).find("[id=competitorName]").val()+'</label>'+
                    '  <div class="plan-info-edit">'+
                    '    <a href="javascript:;" class="bluelink" name="removeCompetitor">Remove</a>'+
                    '  </div>'+
                    '</div>';
                $(this).find(".plan-title").before('<i class="fa fa-arrow fa-caret-right"></i>');
                $(this).find(".plan-title").after(html);
                $(this).find(".plan-competion-con").hide();
        })
        $.post("${path}/ajax/addCompetitor",{index:competitorIndex,maxCompetitorIndex:maxCompetitorIndex}, function(html){
            $(".competitors").append(html);
            //初始化chooseplan
            $("#competitorBox_"+ maxCompetitorIndex).find("input[name='choosePlan']").each(function () {
                $(this).parent().find(".dropdown-tree-category .parent_layer .tree").html(choosePlanDom);
            });
            //初始化关键词插件
            var $keycon = $("#competitorBox_"+ maxCompetitorIndex).find("[name='keywordsLayer']");
            initkeyLayer($keycon);
            addCompetitorProduct(maxCompetitorIndex);

            $('.fileCompetitor').fileupload({
            	add: fileAdd,
            	autoUpload: false,
                dataType: 'json',
                done: fileDone
            });
        },"html")
    }


    function addProduct(dataId,type){
        var $proCon = $(".products");
        $(".addOwnBrandProduct").parent().find(".area-mesage").remove();
        if(validateProduct($proCon)){
            var productIndex = $(".products .products-con").children(".row").length;
            var maxProductIndex = 0;
            if (productIndex > 0){
                maxProductIndex = parseInt($(".products .products-con").find(".maxProductIndex").last().val());
                maxProductIndex += 1;
            }
            var params = {index:productIndex,brandIndex:0,maxProductIndex:maxProductIndex};
            if (dataId && type){
                params["dataId"] = dataId;
                params["type"] = type;
            }
            $.post("${path}/ajax/addProduct",params,function(html){
                $(".products .products-con").append(html);
                if (dataId && type){
                    $(".products .products-con .product-suggest-con").each(function () {
                        $(this).find("#product").change();
                        $(this).find(".product-suggest [name='enter_history']").change();
                        $(this).find(".enter_placeholder").hide();
                        $(this).find(".enter_placeholder").next().show();
                        suggestChange($(this).find(".selected-area"));
                    })
                }else{
                    //将之前的enter_history的值放到下拉框中
                    $(".products .products-con #row_product_"+productIndex).find(".doself").append(fillEnterSelect());
                }
            },"html");
        }else{
            $(".addOwnBrandProduct").after('<label class="area-mesage">'+'<s:message code="audiencePlan.form.emptyProductTip" />' +'</label>');
        }
    }

    function addCompetitorProduct(competitorIndex,dataId,type) {
        var $proCon = $("#competitorBox_"+competitorIndex+" .competitor_products");
        $(".addCompetitorProduct").parent().find(".area-mesage").remove();
        if(validateProduct($proCon)){
            var productIndex = $("#competitorBox_"+competitorIndex+" .competitor_products .products-con").children(".row").length;
            var maxProductIndex = 0;
            if (productIndex > 0){
                maxProductIndex = parseInt($("#competitorBox_"+competitorIndex+" .competitor_products .products-con").find(".maxProductIndex").last().val());
                maxProductIndex += 1;
            }
            var params = {index:productIndex,brandIndex:competitorIndex,maxProductIndex:maxProductIndex};
            if (dataId && type){
                params["dataId"] = dataId;
                params["type"] = type;
            }
            $.post("${path}/ajax/addProduct",params,function(html){
                $("#competitorBox_"+competitorIndex+" .competitor_products .products-con").append(html);
                if (dataId && type){
                    $("#competitorBox_"+competitorIndex+" .competitor_products .products-con .product-suggest-con").each(function () {
                        $(this).find("#product").change();
                        $(this).find(".product-suggest [name='enter_history']").change();
                        $(this).find(".enter_placeholder").hide();
                        $(this).find(".enter_placeholder").next().show();
                        suggestChange($(this).find(".selected-area"));
                    })
                }else{
                    $("#competitorBox_"+competitorIndex+" .competitor_products .products-con #row_product_"+productIndex).find(".doself").append(fillEnterSelect());

                }
            },"html");
        }else{
            $(".addCompetitorProduct").after('<label class="area-mesage">'+'<s:message code="audiencePlan.form.emptyProductTip" />' +'</label>');
        }
    }

    function suggestChange($selectArea){
        var $con = $selectArea.parents(".product-suggest-con");
        var json = eval("("+$con.find("[name='product_json']").val()+")");
        var desArr = $selectArea.find(".selected-tag").map(function(){
            return $(this).find("span").text();
        }).get();
        json.desArr = desArr;
        $con.find("[name='product_json']").val(JSON.stringify(json)).change();
    }

    function fillEnterSelect() {
        var historyArr = $("[name='enter_history']").map(function(){
            if ($(this).val()!="") {
                return $(this).val();
            };
        }).get();
        historyArr = IAX_TOOL.outRepeat(historyArr);
        var lisHtml = historyArr.map(function(data,i){
            return "<li><a href='javascript:;'>"+data+"</a></li>";
        }).join("");

        return lisHtml;
    }
    
    function validateProduct(_this) {
        //验证之前的是否已经填写完毕
        var isDone = true;
        $(_this).find("[name='product_json']").each(function(i){
            var json = eval("("+$(this).val()+")");
            if (!json.category || !json.product || !json.desArr) {
                isDone = false;
            };
            if (json.desArr && json.desArr.length==0) {
                isDone = false;
            };
        })
        return isDone;
    }
    function initkeyLayer(_this) {
        var keyWords = [];
//        修改时回填数据
        var keyWordsData = $(_this).attr("data-keyWords");

        if (keyWordsData !=null && keyWordsData != "" && typeof(keyWordsData) != "undefined"){
            keyWords = JSON.parse(keyWordsData);
        }
        new keywordsLayer({
            container: $(_this),
            lang: "${lang}", //"CN" "EN"
            values: keyWords,
            result: $(_this).prev(),
            maxKeywords: 20,
            path:"${path}/ajax/getKeywords?keyWord=",
            callback:keywordsLayerCall.bind(_this),
        })
    };

    function keywordsLayerCall(ids){
        $(this).prev().change();
    }

    function callBackFun(ids){
        if(ids.length>0){
            $(".feature-plan-search-submit .btn-success").attr("disabled",false);
        }else{
            $(".feature-plan-search-keywords .error-msg").show();
            $(".feature-plan-search-submit .btn-success").attr("disabled",true);
        }
    }
    
    function clickFile(){
//    	console.log("dsakfjlksd");
    }
    



   //加载chooseplan数据
    var choosePlanDom = makeChoosePlanDom(${audiencePlanModelList});
    function makeChoosePlanDom(planData) {
        var choosePlanDoms = "";
        for (var i = 0; i < planData.length; i++) {
            try {
                choosePlanDoms += '<li><a href="javascript:;">' + planData[i].name + '</a>';
                if (planData[i]["brandModelList"] != null && planData[i]["brandModelList"].length > 0) {
                    choosePlanDoms += '<ul class="childs" style="display:none">';
                    var chooseOwnPlanDoms = '<li> <span>'+'<s:message code="audiencePlan.form.myBrand"/>' +'</span> <ul class="childs">';
                    var chooseCompetitorPlanDoms = '<li> <span>'+'<s:message code="audiencePlan.form.competitors"/>' +'</span> <ul class="childs">';
                    for (var j = 0; j < planData[i]["brandModelList"].length; j++) {
                        if (planData[i]["brandModelList"][j].competitor == "true") {
                            chooseCompetitorPlanDoms += '<li><a href="javascript:;" data-keywords="' + planData[i]["brandModelList"][j].keyWords + '">' + planData[i]["brandModelList"][j].name + '</a>';
                            if (planData[i]["brandModelList"][j]["productModelList"] != null && planData[i]["brandModelList"][j]["productModelList"].length > 0) {
                                chooseCompetitorPlanDoms += '<ul class="childs" style="display:none"> <li><a href="javascript:;" data-id="all" data-brand-id="'+planData[i]["brandModelList"][j].brandId+'">All</a> <ul class="childs">';
                                for (var k = 0; k < planData[i]["brandModelList"][j]["productModelList"].length; k++) {
                                    chooseCompetitorPlanDoms += '<li><a href="javascript:;" data-id="' + planData[i]["brandModelList"][j]["productModelList"][k].productId + '">' + planData[i]["brandModelList"][j]["productModelList"][k].name + '</a> </li>';
                                }
                                chooseCompetitorPlanDoms += '</ul> </li></ul>';
                            }
                            chooseCompetitorPlanDoms += "</li>";
                        }else{
                            chooseOwnPlanDoms += '<li><a href="javascript:;" data-keywords="' + planData[i]["brandModelList"][j].keyWords + '">' + planData[i]["brandModelList"][j].name + '</a>';
                            if (planData[i]["brandModelList"][j]["productModelList"] != null && planData[i]["brandModelList"][j]["productModelList"].length > 0) {
                                chooseOwnPlanDoms += '<ul class="childs" style="display:none"> <li> <a href="javascript:;" data-id="all" data-brand-id="'+planData[i]["brandModelList"][j].brandId+'">All</a> <ul class="childs">';
                                for (var k = 0; k < planData[i]["brandModelList"][j]["productModelList"].length; k++) {
                                    chooseOwnPlanDoms += '<li><a href="javascript:;" data-id="' + planData[i]["brandModelList"][j]["productModelList"][k].productId + '">' + planData[i]["brandModelList"][j]["productModelList"][k].name + '</a> </li>';
                                }
                                chooseOwnPlanDoms += '</ul> </li></ul>';
                            }
                            chooseOwnPlanDoms += "</li>";
                        }
                    }
                    chooseOwnPlanDoms += '</ul> </li>';
                    chooseCompetitorPlanDoms += '</ul> </li>';
                    choosePlanDoms += chooseOwnPlanDoms + chooseCompetitorPlanDoms + '</ul>';
                }
                choosePlanDoms += "</li>";
            } catch (e) {
            }
        }

        return choosePlanDoms;
    }
    $("#primaryForm").find("input[name='choosePlan']").each(function () {
        $(this).parent().find(".dropdown-tree-category .parent_layer .tree").html(choosePlanDom);
    });






</script>

</body>

</html>
