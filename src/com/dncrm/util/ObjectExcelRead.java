package com.dncrm.util;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import  org.apache.poi.ss.usermodel.Sheet;
/*import org.apache.poi.hslf.model.Sheet;*/
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;


/**
 * 从EXCEL导入到数据库
 * 创建人：Simon创建时间：2014年12月23日
 */
public class ObjectExcelRead {

    /**
     * @param filepath //文件路径
     * @param filename //文件名
     * @param startrow //开始行号
     * @param startcol //开始列号
     * @param sheetnum //sheet
     * @return list
     */
    public static List<Object> readExcel(String filepath, String filename, int startrow, int startcol, int sheetnum) {
        List<Object> varList = new ArrayList<Object>();

        try {
        	//创建WorkBook
        	Workbook wb = null;
            File target = new File(filepath, filename);
            FileInputStream fi = new FileInputStream(target);
            //判断filename后缀(xls,xlsx)
            String excelSuff = filename.substring(filename.indexOf(".")+1,filename.length());
            if("xls".equals(excelSuff)){
            	wb = new HSSFWorkbook(fi);
            }else if("xlsx".equals(excelSuff)){
            	wb = new XSSFWorkbook(fi);
            }
            //HSSFSheet sheet = wb.getSheetAt(sheetnum);
            Sheet sheet = wb.getSheetAt(sheetnum);						//sheet 从0开始
            int rowNum = sheet.getLastRowNum() + 1;                    //取得最后一行的行号

            for (int i = startrow; i < rowNum; i++) {                    //行循环开始

                PageData varpd = new PageData();
                //HSSFRow row = sheet.getRow(i);                            
                Row row = sheet.getRow(i);								//行
                if (row == null||row.getFirstCellNum()==-1) {
                    continue;
                }
                int cellNum = row.getLastCellNum();                    //每行的最后一个单元格位置

                for (int j = startcol; j < cellNum; j++) {                //列循环开始

                    //HSSFCell cell = row.getCell(Short.parseShort(j + ""));
                	Cell cell = row.getCell(Short.parseShort(j + ""));
                    String cellValue = null;
                    if (null != cell) {
                        switch (cell.getCellType()) {                    // 判断excel单元格内容的格式，并对其进行转换，以便插入数据库
                            case 0:
                                cellValue = String.valueOf((int) cell.getNumericCellValue());
                                break;
                            case 1:
                                cellValue = cell.getStringCellValue();
                                break;
                            case 2:
                                cellValue = cell.getNumericCellValue() + "";
                                // cellValue = String.valueOf(cell.getDateCellValue());
                                break;
                            case 3:
                                cellValue = "";
                                break;
                            case 4:
                                cellValue = String.valueOf(cell.getBooleanCellValue());
                                break;
                            case 5:
                                cellValue = String.valueOf(cell.getErrorCellValue());
                                break;
                        }
                    } else {
                        cellValue = "";
                    }

                    varpd.put("var" + j, cellValue);

                }
                varList.add(varpd);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return varList;
    }
}
