package com.dncrm.entity;

import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.Tools;

public class Page {

    private int showCount; // 每页显示记录数
    private int totalPage; // 总页数
    private int totalResult; // 总记录数
    private int currentPage; // 当前页
    private int currentResult; // 当前记录起始索引
    private boolean entityOrField; // true:需要分页的地方，传入的参数就是Page实体；false:需要分页的地方，传入的参数所代表的实体拥有Page属性
    private String pageStr; // 最终页面显示的底部翻页导航，详细见：getPageStr();
    private String pageStrForActiviti; // 最终页面显示的底部翻页导航，详细见：getPageStrForActiviti();
    private PageData pd = new PageData();
    private int formNo = 0;//

    public Page() {
        try {
            this.showCount = Integer.parseInt(Tools.readTxtFile(Const.PAGE));
        } catch (Exception e) {
            this.showCount = 15;
        }
    }

    public int getTotalPage() {
        if (totalResult % showCount == 0)
            totalPage = totalResult / showCount;
        else
            totalPage = totalResult / showCount + 1;
        return totalPage;
    }

    public void setTotalPage(int totalPage) {

        this.totalPage = totalPage;
    }

    public int getTotalResult() {

        return totalResult;
    }

    public void setTotalResult(int totalResult) {

        this.totalResult = totalResult;
    }

    public int getCurrentPage() {
        if (currentPage <= 0)
            currentPage = 1;
        if (currentPage > getTotalPage())
            currentPage = getTotalPage();
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {

        this.currentPage = currentPage;
    }
    public void setPageStr(String pageStr) {

        this.pageStr = pageStr;
    }
    public void setPageStrForActiviti(String pageStrForActiviti) {

        this.pageStrForActiviti = pageStrForActiviti;
    }

    public int getShowCount() {

        return showCount;
    }

    public void setShowCount(int showCount) {

        this.showCount = showCount;
    }

    public int getCurrentResult() {
        currentResult = (getCurrentPage() - 1) * getShowCount();
        if (currentResult < 0)
            currentResult = 0;
        return currentResult;
    }

    public void setCurrentResult(int currentResult) {

        this.currentResult = currentResult;
    }

    public boolean isEntityOrField() {

        return entityOrField;
    }

    public void setEntityOrField(boolean entityOrField) {

        this.entityOrField = entityOrField;
    }

    public PageData getPd() {

        return pd;
    }

    public void setPd(PageData pd) {

        this.pd = pd;
    }

    public int getFormNo() {
        return formNo;
    }

    public void setFormNo(int formNo) {
        this.formNo = formNo;
    }

    /**
     * 设置分页页面及跳转逻辑
     * @return
     */
    public String getPageStr() {
        StringBuffer sb = new StringBuffer();
        if (totalResult > 0) {
            sb.append("<div class=\"btn-group\" style=\"float:right\">");
            if (currentPage == 1) {
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\">共" + totalResult + "条</label>\n");
                sb.append("<input type=\"number\" style=\"width:70px;border-radius:3px;border-color:#1ab394\" id=\"toGoPage\" name=\"toGoPage\" placeholder=\"页码\" class=\"form-control m-b btn\">\n");
                sb.append("<button onclick=\"toFirstPage()\"class=\"btn btn-primary btn-outline\">跳转</button>\n");
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-step-backward\"></i></label>\n");
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-backward\"></i></label>\n");
            } else {
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\">共" + totalResult + "条</label>\n");
                sb.append("<input type=\"number\" style=\"width:70px;border-radius:3px;border-color:#1ab394\" id=\"toGoPage\" name=\"toGoPage\" placeholder=\"页码\" class=\"form-control m-b btn\">\n");
                sb.append("<button onclick=\"toFirstPage()\"class=\"btn btn-primary btn-outline\">跳转</button>\n");
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\" onclick=\"nextPage(1)\"><i class=\"fa fa-step-backward\"></i></button>\n");
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\" onclick=\"nextPage(" + (currentPage - 1) + ")\"><i class=\"fa fa-backward\"></i></button>\n");
            }
            int showTag = 5;// 分页标签显示数量
            int startTag = 1;
            if (currentPage > showTag) {
                startTag = currentPage - 1;
            }
            int endTag = startTag + showTag - 1;
            for (int i = startTag; i <= totalPage && i <= endTag; i++) {
                if (currentPage == i)
                    sb.append("<button class=\"btn btn-primary btn-outline active\">" + i + "</button>\n");
                else
                    sb.append("<button class=\"btn btn-primary btn-outline\" onclick=\"nextPage(" + i + ")\">" + i + "</button>\n");
            }
            if (currentPage == totalPage) {
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-forward\"></i></label>\n");
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-step-forward\"></i></label>\n");
            } else {
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\" onclick=\"nextPage(" + (currentPage + 1) + ")\"><i class=\"fa fa-forward\"></i></button>\n");
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\"onclick=\"nextPage(" + totalPage + ")\"><i class=\"fa fa-step-forward\"></i></button>\n");

            }
            sb.append("<label type=\"button\" class=\"btn btn-primary btn-outline page-nav\">共" + totalPage + "页</label>\n");
            sb.append("<div style=\"padding:10px;float:left\"></div>\n");

            sb.append("<select class=\"form-control m-b page-nav\" title=\"显示条数\" style=\"width:55px;float:left;\" onchange=\"changeCount(this.value)\">\n");
            sb.append("	<option value='" + showCount + "'>" + showCount
                    + "</option>\n");
            sb.append("	<option value='10'>10</option>\n");
            sb.append("	<option value='20'>20</option>\n");
            sb.append("	<option value='30'>30</option>\n");
            sb.append("	<option value='40'>40</option>\n");
            sb.append("	<option value='50'>50</option>\n");
            sb.append("	<option value='60'>60</option>\n");
            sb.append("	<option value='70'>70</option>\n");
            sb.append("	<option value='80'>80</option>\n");
            sb.append("	<option value='90'>90</option>\n");
            sb.append("	<option value='100'>100</option>\n");
            sb.append("	</select>\n");
            sb.append("	</div>\n");

            sb.append("<script type=\"text/javascript\">\n");

            // 换页函数
            sb.append("function nextPage(page){");
            sb.append("	if(true && document.forms["+formNo+"]){\n");
            sb.append("		var url = document.forms["+formNo+"].getAttribute(\"action\");\n");
            sb.append("		if(url.indexOf('?')>-1){url += \"&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + page + \"&"
                    + (entityOrField ? "showCount" : "page.showCount") + "="
                    + showCount + "\";\n");
            sb.append("		document.forms["+formNo+"].action = url;\n");
            sb.append("		document.forms["+formNo+"].submit();\n");
            sb.append("	}else{\n");
            sb.append("		var url = document.location+'';\n");
            sb.append("		if(url.indexOf('?')>-1){\n");
            sb.append("			if(url.indexOf('currentPage')>-1){\n");
            sb.append("				var reg = /currentPage=\\d*/g;\n");
            sb.append("				url = url.replace(reg,'currentPage=');\n");
            sb.append("			}else{\n");
            sb.append("				url += \"&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";\n");
            sb.append("			}\n");
            sb.append("		}else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + page + \"&"
                    + (entityOrField ? "showCount" : "page.showCount") + "="
                    + showCount + "\";\n");
            sb.append("		document.location = url;\n");
            sb.append("	}\n");
            sb.append("}\n");

            // 调整每页显示条数
            sb.append("function changeCount(value){");
            sb.append("	if(true && document.forms["+formNo+"]){\n");
            sb.append("		var url = document.forms["+formNo+"].getAttribute(\"action\");\n");
            sb.append("		if(url.indexOf('?')>-1){url += \"&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + \"1&"
                    + (entityOrField ? "showCount" : "page.showCount")
                    + "=\"+value;\n");
            sb.append("		document.forms["+formNo+"].action = url;\n");
            sb.append("		document.forms["+formNo+"].submit();\n");
            sb.append("	}else{\n");
            sb.append("		var url = document.location+'';\n");
            sb.append("		if(url.indexOf('?')>-1){\n");
            sb.append("			if(url.indexOf('currentPage')>-1){\n");
            sb.append("				var reg = /currentPage=\\d*/g;\n");
            sb.append("				url = url.replace(reg,'currentPage=');\n");
            sb.append("			}else{\n");
            sb.append("				url += \"1&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";\n");
            sb.append("			}\n");
            sb.append("		}else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + \"&"
                    + (entityOrField ? "showCount" : "page.showCount")
                    + "=\"+value;\n");
            sb.append("		document.location = url;\n");
            sb.append("	}\n");
            sb.append("}\n");

            // 跳转函数
            sb.append("function toFirstPage(){");
            sb.append("var toPaggeVlue = document.getElementById(\"toGoPage\").value;");
            sb.append("if(toPaggeVlue == ''){document.getElementById(\"toGoPage\").value=1;return;}");
            sb.append("if(isNaN(Number(toPaggeVlue))){document.getElementById(\"toGoPage\").value=1;return;}");
            sb.append("nextPage(toPaggeVlue);");
            sb.append("}\n");
            sb.append("</script>\n");
        }
        pageStr = sb.toString();
        return pageStr;
    }
    /**
     * 设置分页页面及跳转逻辑 for activiti
     * @return
     */
    public String getPageStrForActiviti() {
        StringBuffer sb = new StringBuffer();
        if (totalResult > 0) {
            sb.append("<div class=\"btn-group\" style=\"float:right\">");
            if (currentPage == 1) {
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\">共" + totalResult + "条</label>\n");
                sb.append("<input type=\"number\" style=\"width:70px;border-radius:3px;border-color:#1ab394\" id=\"toGoPage\" name=\"toGoPage\" placeholder=\"页码\" class=\"form-control m-b btn\">\n");
                sb.append("<button onclick=\"toFirstPage()\"class=\"btn btn-primary btn-outline\">跳转</button>\n");
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-step-backward\"></i></label>\n");
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-backward\"></i></label>\n");
            } else {
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\">共" + totalResult + "条</label>\n");
                sb.append("<input type=\"number\" style=\"width:70px;border-radius:3px;border-color:#1ab394\" id=\"toGoPage\" name=\"toGoPage\" placeholder=\"页码\" class=\"form-control m-b btn\">\n");
                sb.append("<button onclick=\"toFirstPage()\"class=\"btn btn-primary btn-outline\">跳转</button>\n");
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\" onclick=\"nextPage(1)\"><i class=\"fa fa-step-backward\"></i></button>\n");
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\" onclick=\"nextPage(" + (currentPage - 1) + ")\"><i class=\"fa fa-backward\"></i></button>\n");
            }
            int showTag = 5;// 分页标签显示数量
            int startTag = 1;
            if (currentPage > showTag) {
                startTag = currentPage - 1;
            }
            int endTag = startTag + showTag - 1;
            for (int i = startTag; i <= totalPage && i <= endTag; i++) {
                if (currentPage == i)
                    sb.append("<button class=\"btn btn-primary btn-outline active\">" + i + "</button>\n");
                else
                    sb.append("<button class=\"btn btn-primary btn-outline\" onclick=\"nextPage(" + i + ")\">" + i + "</button>\n");
            }
            if (currentPage == totalPage) {
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-forward\"></i></label>\n");
                sb.append("<label class=\"btn btn-primary btn-outline page-nav\"><i class=\"fa fa-step-forward\"></i></label>\n");
            } else {
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\" onclick=\"nextPage(" + (currentPage + 1) + ")\"><i class=\"fa fa-forward\"></i></button>\n");
                sb.append("<button type=\"button\" class=\"btn btn-primary btn-outline\"onclick=\"nextPage(" + totalPage + ")\"><i class=\"fa fa-step-forward\"></i></button>\n");

            }
            sb.append("<label type=\"button\" class=\"btn btn-primary btn-outline page-nav\">共" + totalPage + "页</label>\n");
            sb.append("<div style=\"padding:10px;float:left\"></div>\n");

            sb.append("<select class=\"form-control m-b page-nav\" title=\"显示条数\" style=\"width:55px;float:left;\" onchange=\"changeCount(this.value)\">\n");
            sb.append("	<option value='" + showCount + "'>" + showCount
                    + "</option>\n");
            sb.append("	<option value='10'>10</option>\n");
            sb.append("	<option value='20'>20</option>\n");
            sb.append("	<option value='30'>30</option>\n");
            sb.append("	<option value='40'>40</option>\n");
            sb.append("	<option value='50'>50</option>\n");
            sb.append("	<option value='60'>60</option>\n");
            sb.append("	<option value='70'>70</option>\n");
            sb.append("	<option value='80'>80</option>\n");
            sb.append("	<option value='90'>90</option>\n");
            sb.append("	<option value='100'>100</option>\n");
            sb.append("	</select>\n");
            sb.append("	</div>\n");

            sb.append("<script type=\"text/javascript\">\n");

            // 换页函数
            sb.append("function nextPage(page){");
            sb.append("	if(true && document.forms["+formNo+"]){\n");
            sb.append("		var url = document.forms["+formNo+"].getAttribute(\"action\");\n");
            sb.append("		if(url.indexOf('?')>-1){url += \"&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + page + \"&"
                    + (entityOrField ? "showCount" : "page.showCount") + "="
                    + showCount + "\";\n");
            //添加totalPage,totalResult参数
            sb.append("		url = url +  \"&"
                    + (entityOrField ? "totalPage" : "page.totalPage") + "="
                    + totalPage + "\";\n");
            sb.append("		url = url +  \"&"
                    + (entityOrField ? "totalResult" : "page.totalResult") + "="
                    + totalResult + "\";\n");
            sb.append("		document.forms["+formNo+"].action = url;\n");
            sb.append("		document.forms["+formNo+"].submit();\n");
            sb.append("	}else{\n");
            sb.append("		var url = document.location+'';\n");
            sb.append("		if(url.indexOf('?')>-1){\n");
            sb.append("			if(url.indexOf('currentPage')>-1){\n");
            sb.append("				var reg = /currentPage=\\d*/g;\n");
            sb.append("				url = url.replace(reg,'currentPage=');\n");
            sb.append("			}else{\n");
            sb.append("				url += \"&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";\n");
            sb.append("			}\n");
            sb.append("		}else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + page + \"&"
                    + (entityOrField ? "showCount" : "page.showCount") + "="
                    + showCount + "\";\n");
            //添加totalPage,totalResult参数
            sb.append("		url = url +  \"&"
                    + (entityOrField ? "totalPage" : "page.totalPage") + "="
                    + totalPage + "\";\n");
            sb.append("		url = url +  \"&"
                    + (entityOrField ? "totalResult" : "page.totalResult") + "="
                    + totalResult + "\";\n");
            sb.append("		document.location = url;\n");
            sb.append("	}\n");
            sb.append("}\n");

            // 调整每页显示条数
            sb.append("function changeCount(value){");
            sb.append("	if(true && document.forms["+formNo+"]){\n");
            sb.append("		var url = document.forms["+formNo+"].getAttribute(\"action\");\n");
            sb.append("		if(url.indexOf('?')>-1){url += \"&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + \"1&"
                    + (entityOrField ? "showCount" : "page.showCount")
                    + "=\"+value;\n");
            sb.append("		document.forms["+formNo+"].action = url;\n");
            sb.append("		document.forms["+formNo+"].submit();\n");
            sb.append("	}else{\n");
            sb.append("		var url = document.location+'';\n");
            sb.append("		if(url.indexOf('?')>-1){\n");
            sb.append("			if(url.indexOf('currentPage')>-1){\n");
            sb.append("				var reg = /currentPage=\\d*/g;\n");
            sb.append("				url = url.replace(reg,'currentPage=');\n");
            sb.append("			}else{\n");
            sb.append("				url += \"1&"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";\n");
            sb.append("			}\n");
            sb.append("		}else{url += \"?"
                    + (entityOrField ? "currentPage" : "page.currentPage")
                    + "=\";}\n");
            sb.append("		url = url + \"&"
                    + (entityOrField ? "showCount" : "page.showCount")
                    + "=\"+value;\n");
            sb.append("		document.location = url;\n");
            sb.append("	}\n");
            sb.append("}\n");

            // 跳转函数
            sb.append("function toFirstPage(){");
            sb.append("var toPaggeVlue = document.getElementById(\"toGoPage\").value;");
            sb.append("if(toPaggeVlue == ''){document.getElementById(\"toGoPage\").value=1;return;}");
            sb.append("if(isNaN(Number(toPaggeVlue))){document.getElementById(\"toGoPage\").value=1;return;}");
            sb.append("nextPage(toPaggeVlue);");
            sb.append("}\n");
            sb.append("</script>\n");
        }
        pageStr = sb.toString();
        return pageStr;
    }
}
