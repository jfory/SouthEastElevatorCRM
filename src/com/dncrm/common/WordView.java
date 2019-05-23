package com.dncrm.common;

import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;
import org.apache.commons.beanutils.BeanMap;
import pl.jsolve.templ4docx.core.Docx;
import pl.jsolve.templ4docx.core.VariablePattern;
import pl.jsolve.templ4docx.variable.TableVariable;
import pl.jsolve.templ4docx.variable.TextVariable;
import pl.jsolve.templ4docx.variable.Variable;
import pl.jsolve.templ4docx.variable.Variables;

public class WordView extends AbstractView{
	private String exportFileName;
	private String templatePath;
	
	public WordView(String exportFileName, String templatePath) {
		this.exportFileName = exportFileName;
		this.templatePath = templatePath;
		init();
	}
	public WordView() {
		init();
	}
	//初始数据
	private void init() {
		setContentType("application/vnd.ms-word");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ServletOutputStream outputStream = response.getOutputStream(); 
		/*response.setHeader("content-disposition",
                "attachment;filename=" + exportFileName + ".docx");*/
		response.setHeader("content-disposition", "attachment;filename*=UTF-8''" + URLEncoder.encode(exportFileName + ".docx","UTF-8"));
		
//		FileOutputStream fileout=new FileOutputStream("/Users/XeonChan/Documents/fileout.docx"); 
		
		Docx docx = new Docx(templatePath);
		docx.setVariablePattern(new VariablePattern("${", "}"));
		// preparing variables
		Variables variables = new Variables();
//		variables.addTextVariable(new TextVariable("#{firstname}", "Lukasz"));
//		variables.addTextVariable(new TextVariable("#{lastname}", "Stypka"));
		insertDateinWordVariables(variables,model);
		// fill template
		docx.fillTemplate(variables);
		// save filled .docx file
		docx.save(outputStream);
//		docx.save(fileout);
		response.setContentType(getContentType());
		outputStream.flush();  
        outputStream.close();
//        fileout.flush();
//        fileout.close();
	}

	@Override
	protected boolean generatesDownloadContent() {
		// TODO Auto-generated method stub
		return true;
	}
	
	
	//把数据替换word的变量
	public void insertDateinWordVariables(Variables variables,Map<String, Object> model) {
		for (Map.Entry<String, Object> entry : model.entrySet()) {  
//		    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
		    //如果是列表
		    if(entry.getValue() instanceof List) {
			    	TableVariable tableVariable = null;
			    	tableVariable = new TableVariable();
			    	List<Object> temp = (List<Object>) entry.getValue();
			    	Map<Object, Object> m2 = null;
			    	if(temp.get(0) instanceof Map) {
			    		m2 = (Map<Object, Object>) temp.get(0);
			    	}else {
			    		m2 = new BeanMap(temp.get(0));
			    	}
			    	for (Object e : m2.keySet()) {
			    		List<Variable> nameColumnVariables = null;
	//		    		System.out.println("============"+new BeanMap(temp.get(0)).get("codefullname"));
			    		nameColumnVariables = new ArrayList<Variable>();
	//		    		nameColumnVariables.add(new TextVariable("#{"+e.getKey()+"}", e.getValue().toString()));
			    		for(int i=0;i<temp.size();i++) {
			    			Map m = null;
			    			if(temp.get(i) instanceof Map) {
			    				m = (Map<Object, Object>)temp.get(i);
			    			}else {
			    				m = new BeanMap(temp.get(i));
			    			}
			    			nameColumnVariables.add(new TextVariable("${"+e.toString()+"}",
			    					m.get(e.toString()).toString()));
			    		}
			    		tableVariable.addVariable(nameColumnVariables);
			    	}
			    	variables.addTableVariable(tableVariable);
		    }else {
		    		if(entry.getValue() != null) {
		    			variables.addTextVariable(new TextVariable("${"+entry.getKey()+"}", entry.getValue().toString()));
		    		}
		    }
		}  
	}
	
}
