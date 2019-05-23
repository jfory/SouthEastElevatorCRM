package com.dncrm.common;

import com.dncrm.entity.nonstandrad.NonStandardBean;
import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.jxls.common.Context;
import org.springframework.web.servlet.view.AbstractView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

public class ExcelView extends AbstractView {
    private String exportFileName;
    private String templatePath;

    public ExcelView(String exportFileName, String templatePath) {
        this.exportFileName = exportFileName;
        this.templatePath = templatePath;
        init();
    }

    public ExcelView() {
        init();
    }

    //初始数据
    private void init() {
        setContentType("application/vnd.ms-excel");
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
                                           HttpServletResponse response) throws Exception {
        // TODO Auto-generated method stub
        ServletOutputStream outputStream = response.getOutputStream();
        response.setHeader("content-disposition",
                "attachment;filename=" + exportFileName + ".xlsx");

        InputStream is = new FileInputStream(new File(templatePath));

        //Context context = new Context();
        //insertDateinExcelVariables(context, model);

        //OutputStream op = new FileOutputStream("F:/test.xlsx");

        Workbook workbook = new XLSTransformer().transformXLS(is, model);

        Sheet sheet = workbook.getSheetAt(0);

        int lastRow = sheet.getLastRowNum();

        //合并单元格
        for (int i = 0; i <= lastRow; i++) {
            switch (sheet.getRow(i).getCell(0, Row.MissingCellPolicy
                    .CREATE_NULL_AS_BLANK).getCellTypeEnum()) {
                case STRING:
                    if (model.get("excelType") != null) {
                        switch ((String) model.get("excelType")) {
                            case "itemDetailReport":
                                Map<String, Map<String, int[][]>> map = (Map<String
                                        , Map<String, int[][]>>) model.get("map");
                                switch (sheet.getRow(i).getCell(0).getStringCellValue()) {
                                    case "北区营销中心":
                                        sheet.addMergedRegion(new CellRangeAddress(i
                                                , i + map.get("北区营销中心").size() - 1, 0, 0));
                                        i = i + map.get("北区营销中心").size();
                                        break;

                                    case "西区营销中心":
                                        sheet.addMergedRegion(new CellRangeAddress(i
                                                , i + map.get("西区营销中心").size() - 1, 0, 0));
                                        i = i + map.get("西区营销中心").size();
                                        break;


                                    case "南区营销中心":
                                        sheet.addMergedRegion(new CellRangeAddress(i
                                                , i + map.get("南区营销中心").size() - 1, 0, 0));
                                        i = i + map.get("南区营销中心").size();
                                        break;

                                    case "东区营销中心":
                                        sheet.addMergedRegion(new CellRangeAddress(i
                                                , i + map.get("东区营销中心").size() - 1, 0, 0));
                                        i = i + map.get("东区营销中心").size();
                                        break;

                                    default:
                                        break;
                                }
                                break;

                            case "feiyi":
                                switch (sheet.getRow(i).getCell(0).getStringCellValue()) {
                                    case "备注":
                                        sheet.addMergedRegion(new CellRangeAddress(i, i + 2, 0, 0));
                                        sheet.addMergedRegion(new CellRangeAddress(i, i + 2, 1, 8));
                                        break;
                                    case "非标需求":
                                        List<NonStandardBean> a = (List<NonStandardBean>) model.get("psdh");
                                        int fbxqList_size = a.size();
                                        if (a.isEmpty()) {
//                                	合同非标需求
                                            sheet.addMergedRegion(new CellRangeAddress(i
                                                    , i + 1, 0, 0));
                                            //合并内容标题
                                            sheet.addMergedRegion(new CellRangeAddress(i, i, 1, 7));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 2, 5));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 6, 7));
                                            break;
                                        }
                                        //合并非标需求
                                        sheet.addMergedRegion(new CellRangeAddress(i
                                                , i + fbxqList_size, 0, 0));
                                        //合并内容标题
                                        sheet.addMergedRegion(new CellRangeAddress(i, i, 1, 7));
                                        //合并有效评审单号
//                                sheet.addMergedRegion(new CellRangeAddress(i, i, 7, 7));

                                        //合并非标需求内容的单元格
                                        int start = 0;
                                        int end = 0;
                                        int c = 0;
                                        int count = 0;
                                        /*for (int j = i + 1; j <= fbxqList_size + i; j++) {
                                            NonStandardBean nonStandardBean = a.get(count);
                                            String content = nonStandardBean.getContent();
                                            String nonstandrad = nonStandardBean.getNonstandrad();
                                            if ((content.equals("") || content == null) && (nonstandrad.equals("") || nonstandrad == null)) {
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 2, 5));
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 6, 7));
                                                break;
                                            }
                                            if (content.equals("") || content == null) {
                                                end = j;
                                            } else {
                                                start = j;
                                            }
                                            count++;
                                        }
                                        if (end < start) {
                                            end = start;
                                        }
                                        if (end > start) {
                                            sheet.addMergedRegion(new CellRangeAddress(start, end, 1, 1));
                                            sheet.addMergedRegion(new CellRangeAddress(start, end, 8, 8));
                                        }

                                        for (int j = i + 1; j <= fbxqList_size + i; j++) {
                                            if (j == start) {
                                                String content = sheet.getRow(end).getCell(6).getStringCellValue();
                                                for (int k = start; k <= end; k++) {
                                                    sheet.getRow(k).getCell(6).setCellValue(content);
                                                }
                                                sheet.addMergedRegion(new CellRangeAddress(start, end, 2, 5));
                                                sheet.addMergedRegion(new CellRangeAddress(start, end, 6, 7));
                                                j = end;
                                            } else {
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 2, 5));
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 6, 7));
                                            }
                                        }*/
                                        
                                        int s = 0;
                                        int e = 0;
                                        int h = 0;//缓存前一个
                                        int xh = 1;
                                        
                                        for (int j = i + 1; j <= fbxqList_size + i; j++) {
                                            NonStandardBean nonStandardBean = a.get(count);
                                            String content = nonStandardBean.getContent();
                                            String nonstandrad = nonStandardBean.getNonstandrad();
                                            String number = nonStandardBean.getNumber();
                                            if("".equals(content)
                                            		&& "".equals(nonstandrad)
                                            		&& "".equals(number)) {
                                            	if(s == 0) {
                                            		s = j - 1;
                                            	}
                                            	
                                            } else {
                                            	e = j - 1;
                                            	
                                            	if(s != 0) {
                                            		if(s < e) {
                                                        sheet.getRow(s).getCell(1).setCellValue(xh++);
                                            			sheet.addMergedRegion(new CellRangeAddress(s, e, 1, 1));
                                                        sheet.addMergedRegion(new CellRangeAddress(s, e, 2, 5));
                                                        sheet.addMergedRegion(new CellRangeAddress(s, e, 6, 7));
                                                        sheet.addMergedRegion(new CellRangeAddress(s, e, 8, 8));
                                            		}
                                            	} else {
                                            		if(h != 0) {
                                                        sheet.getRow(h).getCell(1).setCellValue(xh++);
                                                        sheet.addMergedRegion(new CellRangeAddress(h, h, 2, 5));
                                                        sheet.addMergedRegion(new CellRangeAddress(h, h, 6, 7));
                                            		}
                                            	}
                                            	
                                            	s = 0;
                                            	
                                            	h = j;
                                            }

                                            count++;
                                        }
                                        
                                        if(s != 0) {//
                                    		if(s < (fbxqList_size + i)) {

                                                sheet.getRow(s).getCell(1).setCellValue(xh++);
                                    			sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 1, 1));
                                                sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 2, 5));
                                                sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 6, 7));
                                                sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 8, 8));
                                    		}
                                    	} else {
                                    		if(h != 0) {
                                                sheet.getRow(h).getCell(1).setCellValue(xh++);
                                                sheet.addMergedRegion(new CellRangeAddress(h, h, 2, 5));
                                                sheet.addMergedRegion(new CellRangeAddress(h, h, 6, 7));
                                    		}
                                    	}
                                        
                                        break;

                                    default:
                                        break;
                                }
                                break;

                            case "feiyue":
                                switch (sheet.getRow(i).getCell(0).getStringCellValue()) {
                                    case "备注":
                                        sheet.addMergedRegion(new CellRangeAddress(i, i + 2, 0, 0));
                                        sheet.addMergedRegion(new CellRangeAddress(i, i + 2, 1, 7));
                                        break;

                                    case "常规非标":
                                        //Excel中生成的空行数
                                        int addRowCount = 0;
                                        if ((boolean) model.get("showCGFBEmptyRow")) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_JXCLBH").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_MTBH443").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 6));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_MTBHSUS304").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 6));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_MTBH15SUS304").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 6));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_MTBH1215").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 6));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_JXHL").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_DLSB").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_DZCZ").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_KMGD").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_DKIP65").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_PKM").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_GTJX").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_ZFSZ2000").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_ZFSZ3000").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_ZFSZAQB").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_TDYJ").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_JJFAJMK").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        if (!model.get("CGFB_JJFACXK").toString().isEmpty()) {
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 1, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1 + addRowCount
                                                    , i + 1 + addRowCount, 5, 7));
                                            addRowCount += 1;
                                        }
                                        break;

                                    case "非标需求":
                                        List<NonStandardBean> a = (List<NonStandardBean>) model.get("psdh");
                                        int fbxqList_size = a.size();
                                        if (a.isEmpty()) {
//                                    	合同非标需求
                                            sheet.addMergedRegion(new CellRangeAddress(i
                                                    , i + 1, 0, 0));
                                            //合并内容标题
                                            sheet.addMergedRegion(new CellRangeAddress(i, i, 1, 6));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 2, 4));
                                            sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 5, 6));
                                            break;
                                        }
                                        //合并非标需求
                                        sheet.addMergedRegion(new CellRangeAddress(i
                                                , i + fbxqList_size, 0, 0));
                                        //合并内容标题
                                        sheet.addMergedRegion(new CellRangeAddress(i, i, 1, 6));
                                        //合并有效评审单号
//                                    sheet.addMergedRegion(new CellRangeAddress(i, i, 7, 7));

                                        //合并非标需求内容的单元格
                                        int start = 0;
                                        int end = 0;
                                        int c = 0;
                                        int count = 0;
                                        /*for (int j = i + 1; j <= fbxqList_size + i; j++) {
                                            NonStandardBean nonStandardBean = a.get(count);
                                            String content = nonStandardBean.getContent();
                                            String nonstandrad = nonStandardBean.getNonstandrad();
                                            if ((content.equals("") || content == null) && (nonstandrad.equals("") || nonstandrad == null)) {
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 2, 4));
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 5, 6));
                                                break;
                                            }
                                            if (content.equals("") || content == null) {
                                                end = j;
                                            } else {
                                                start = j;
                                            }
                                            count++;
                                        }
                                        if (end < start) {
                                            end = start;
                                        }
                                        if (end > start) {
                                            sheet.addMergedRegion(new CellRangeAddress(start, end, 1, 1));
                                            sheet.addMergedRegion(new CellRangeAddress(start, end, 7, 7));
                                        }

                                        for (int j = i + 1; j <= fbxqList_size + i; j++) {
                                            if (j == start) {
                                                String content = sheet.getRow(end).getCell(5).getStringCellValue();
                                                for (int k = start; k <= end; k++) {
                                                    sheet.getRow(k).getCell(5).setCellValue(content);
                                                }
                                                sheet.addMergedRegion(new CellRangeAddress(start, end, 2, 4));
                                                sheet.addMergedRegion(new CellRangeAddress(start, end, 5, 6));
                                                j = end;
                                            } else {
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 2, 4));
                                                sheet.addMergedRegion(new CellRangeAddress(j, j, 5, 6));
                                            }
                                        }*/
                                        
                                        int s = 0;
                                        int e = 0;
                                        int h = 0;//缓存前一个
                                        int xh = 1;
                                        
                                        for (int j = i + 1; j <= fbxqList_size + i; j++) {
                                            NonStandardBean nonStandardBean = a.get(count);
                                            String content = nonStandardBean.getContent();
                                            String nonstandrad = nonStandardBean.getNonstandrad();
                                            String number = nonStandardBean.getNumber();
                                            if("".equals(content)
                                            		&& "".equals(nonstandrad)
                                            		&& "".equals(number)) {
                                            	if(s == 0) {
                                            		s = j - 1;
                                            	}
                                            	
                                            } else {
                                            	e = j - 1;
                                            	
                                            	if(s != 0) {
                                            		if(s < e) {
                                                        sheet.getRow(s).getCell(1).setCellValue(xh++);
                                            			sheet.addMergedRegion(new CellRangeAddress(s, e, 1, 1));
                                                        sheet.addMergedRegion(new CellRangeAddress(s, e, 2, 4));
                                                        sheet.addMergedRegion(new CellRangeAddress(s, e, 5, 6));
                                                        sheet.addMergedRegion(new CellRangeAddress(s, e, 7, 7));
                                            		}
                                            	} else {
                                            		if(h != 0) {
                                                        sheet.getRow(h).getCell(1).setCellValue(xh++);
                                                        sheet.addMergedRegion(new CellRangeAddress(h, h, 2, 4));
                                                        sheet.addMergedRegion(new CellRangeAddress(h, h, 5, 6));
                                            		}
                                            	}
                                            	
                                            	s = 0;
                                            	
                                            	h = j;
                                            }

                                            count++;
                                        }
                                        
                                        if(s != 0) {//
                                    		if(s < (fbxqList_size + i)) {

                                                sheet.getRow(s).getCell(1).setCellValue(xh++);
                                    			sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 1, 1));
                                                sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 2, 4));
                                                sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 5, 6));
                                                sheet.addMergedRegion(new CellRangeAddress(s, fbxqList_size + i, 7, 7));
                                    		}
                                    	} else {
                                    		if(h != 0) {
                                                sheet.getRow(h).getCell(1).setCellValue(xh++);
                                                sheet.addMergedRegion(new CellRangeAddress(h, h, 2, 4));
                                                sheet.addMergedRegion(new CellRangeAddress(h, h, 5, 6));
                                    		}
                                    	}
                                        
                                        
                                        break;
                                }
                                break;
                        }
                        break;
                    }

                default:
                    break;
            }
        }
        
        if("1".equals(model.get("isUpdateFormula"))) {
            workbook.setForceFormulaRecalculation(true);//强制整个Excel在你打开WPS或者Office的一瞬间，重新计算更新一下函数公式
        }

        workbook.write(outputStream);
        //JxlsHelper.getInstance().processTemplate(is, outputStream, context);
        response.setContentType(getContentType());
        outputStream.flush();
        outputStream.close();
    }

    @Override
    protected boolean generatesDownloadContent() {
        // TODO Auto-generated method stub
        return true;
    }


    //把数据替换Excel的变量
    public void insertDateinExcelVariables(Context context, Map<String, Object> model) {
        for (Map.Entry<String, Object> entry : model.entrySet()) {
            if (entry.getValue() != null) {
                context.putVar(entry.getKey(), entry.getValue());
            }


        }
    }

}
