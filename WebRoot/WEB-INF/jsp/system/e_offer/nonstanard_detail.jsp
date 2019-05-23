<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="table table-striped table-bordered table-hover" id="fbTable">
    <thead>
    <tr>
        <td colspan="4"></td>
        <td colspan="7" style="text-align: center;">
            <c:if test="${forwardMsg!='view'}">
                <input type="button" value="申请" onclick="addFB();" class="btn-sm btn-success">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="调用" onclick="selFB();" class="btn-sm btn-success">
            </c:if>
        </td>
    </tr>
    <tr>
        <th style="width:5%;">序号</th>
        <th style="width:10%;">非标类型</th>
        <th style="width:10%;">非标描述</th>
        <th style="width:10%;">技术处理</th>
        <th style="width:10%;display: none">价格</th>
        <th style="width:10%;">单台报价</th>
        <th style="width:10%;">总价</th>
        <th style="width:10%;display: none">小计</th>
        <th style="width:10%;">打折</th>
        <th style="width:10%;">财务备注</th>
        <th style="width:10%;">操作</th>
    </tr>
    </thead>
    <tbody id="fbbody">
    </tbody>
    <tr>
        <td style="width:5%;">合计</td>
        <td style="width:10%;"></td>
        <td style="width:10%;"></td>
        <td style="width:10%;"></td>
        <td style="width:10%;display: none"></td>
        <td style="width:10%;"><span id="fbhj_dtbj"></span></td>
        <td style="width:10%;"><span id="fbhj_zj"></span></td>
        <td style="width:10%;display: none"></td>
        <td style="width:10%;"></td>
        <td style="width:10%;"></td>
        <td style="width:10%;"></td>
    </tr>
</table>
<div>
	<span style="">可打折合计： <span id="zj_kdz"></span></span>
	<span style="margin-left: 50px;">不可打折合计： <span id="zj_bkdz"></span></span>
</div>