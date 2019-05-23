package com.dncrm.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.POIXMLDocumentPart.RelationPart;
import org.apache.poi.POIXMLException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.poifs.crypt.HashAlgorithm;
import org.apache.poi.xwpf.usermodel.Borders;
import org.apache.poi.xwpf.usermodel.Document;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.TextAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFactory;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeaderFooter;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRelation;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.XmlObject;
import org.apache.xmlbeans.XmlToken;
import org.apache.xmlbeans.impl.values.XmlAnyTypeImpl;
import org.openxmlformats.schemas.drawingml.x2006.main.CTNonVisualDrawingProps;
import org.openxmlformats.schemas.drawingml.x2006.main.CTPoint2D;
import org.openxmlformats.schemas.drawingml.x2006.main.CTPositiveSize2D;
import org.openxmlformats.schemas.drawingml.x2006.picture.CTPicture;
import org.openxmlformats.schemas.drawingml.x2006.wordprocessingDrawing.CTAnchor;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTDrawing;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTHdrFtr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTHdrFtrRef;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTP;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTabStop;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STHdrFtr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTabJc;
import org.springframework.web.servlet.view.AbstractView;

import com.dncrm.util.Const;
import com.dncrm.util.PathUtil;

public class WordViewNew extends AbstractView{
	
	private String exportFileName;
	private String templatePath;
	
	public WordViewNew(String exportFileName, String templatePath) {
		this.exportFileName = exportFileName;
		this.templatePath = templatePath;
		init();
	}
	
	public WordViewNew() {
		init();
	}
	
	//初始数据
	private void init() {
		setContentType("application/vnd.ms-word");
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		ServletOutputStream outputStream = response.getOutputStream(); 
		response.setHeader("content-disposition", "attachment;filename*=UTF-8''" + URLEncoder.encode(exportFileName + ".docx","UTF-8"));
		System.out.println(templatePath);
		InputStream is = new FileInputStream(new File(templatePath));
		
		XWPFDocument doc = new XWPFDocument(is);
		
		String htApprove = PathUtil.getClasspath()+Const.FILEPATHFILE+"Contract/ht_approve.png";
		
		List<XWPFFooter> footerList = doc.getFooterList();
		if(footerList.size() == 0) {
			//没有页脚，创建页脚
			XWPFRelation relation = XWPFRelation.FOOTER;
            int i = getRelationIndex(doc, relation);

			XWPFFooter wrapper = (XWPFFooter) doc.createRelationship(relation,
                    XWPFFactory.getInstance(), i);
            wrapper.setXWPFDocument(doc);
	        
            String blipId = wrapper.addPictureData(new FileInputStream(new File(htApprove)), XWPFDocument.PICTURE_TYPE_PNG);
			XWPFRun r = wrapper.createParagraph().createRun();
			CTDrawing drawing = r.getCTR().addNewDrawing();
			drawing.set(XmlToken.Factory.parse(getPicXml(doc.getNextPicNameNumber(Document.PICTURE_TYPE_PNG), blipId, 60, 60)));
            
	        CTHdrFtr ftr = buildHdrFtr(STHdrFtr.DEFAULT.toString(), null, wrapper);
	        
			CTHdrFtrRef ref = doc.getDocument().getBody().getSectPr().addNewFooterReference();
	        ref.setType(STHdrFtr.DEFAULT);
	        ref.setId(doc.getRelationId(wrapper));
	        wrapper.setHeaderFooter(ftr);
		} else {
			
			/* 2
			 * XWPFFooter xwpfFooter = doc.getFooterArray(0);
			XWPFParagraph paragraph = xwpfFooter.createParagraph();
			
			XWPFRun run = paragraph.createRun();
			
			XWPFPicture xwpfPicture = run.addPicture(new FileInputStream(new File(htApprove)), XWPFDocument.PICTURE_TYPE_PNG, "docx_img_", Units.toEMU(120),Units.toEMU(120));
			
			String blipID = "";
			for(XWPFPictureData picturedata : xwpfFooter.getAllPackagePictures()) {
			   blipID = xwpfFooter.getRelationId(picturedata);
			   System.out.println(blipID); //the XWPFPictureData are already there
			}
			xwpfPicture.getCTPicture().getBlipFill().getBlip().setEmbed(blipID); //now they have a blipID also
			*/
			
			XWPFFooter footer = doc.getFooterArray(0);
	        XWPFParagraph paragraph = footer.createParagraph();
			
	        //XWPFRun run = paragraph.createRun();
	        //XWPFPicture xwpfPicture = run.addPicture(new FileInputStream(new File(htApprove)), XWPFDocument.PICTURE_TYPE_PNG, "docx_img_", Units.toEMU(50),Units.toEMU(50));
	        String blipId = footer.addPictureData(new FileInputStream(new File(htApprove)), XWPFDocument.PICTURE_TYPE_PNG);
			//createPicture(blipId,
			//		doc.getNextPicNameNumber(Document.PICTURE_TYPE_PNG), 80, 80, paragraph);
	        
	        //run.addTab();
			
	        XWPFRun r = paragraph.createRun();
			CTDrawing drawing = r.getCTR().addNewDrawing();
			drawing.set(XmlToken.Factory.parse(getPicXml(doc.getNextPicNameNumber(Document.PICTURE_TYPE_PNG), blipId, 60, 60)));
			
		}
		
		//XWPFParagraph createParagraph = doc.createParagraph();
		
		//setParagraphAlignInfo(createParagraph, ParagraphAlignment.RIGHT, TextAlignment.BOTTOM);
		
		//XWPFPicture xwpfPicture = createParagraph.createRun().addPicture(new FileInputStream(new File(htApprove)), XWPFDocument.PICTURE_TYPE_PNG, "docx_img_", Units.toEMU(120),Units.toEMU(120));
		
		
		//XWPFParagraph createParagraph = doc.createParagraph();
		//String blipId = createParagraph.getDocument().addPictureData(new FileInputStream(new File(htApprove)), XWPFDocument.PICTURE_TYPE_PNG);
		//createPicture(blipId,
		//		doc.getNextPicNameNumber(Document.PICTURE_TYPE_PNG), 150, 150, createParagraph);
		
		doc.enforceFillingFormsProtection();
		doc.enforceFillingFormsProtection(UUID.randomUUID().toString(), HashAlgorithm.sha1);
		
		doc.write(outputStream);
        response.setContentType(getContentType());
        outputStream.flush();
        outputStream.close();
        doc.close();
	}
	
	public List<CTPicture> getCTPictures(XmlObject o) {
	        List<CTPicture> pictures = new ArrayList<CTPicture>();
	        XmlObject[] picts = o.selectPath("declare namespace pic='" 
	            + CTPicture.type.getName().getNamespaceURI() + "' .//pic:pic");
	        for (XmlObject pict : picts) {
	            if (pict instanceof XmlAnyTypeImpl) {
	                // Pesky XmlBeans bug - see Bugzilla #49934
	                try {
	                    pict = CTPicture.Factory.parse(pict.toString());
	                } catch (XmlException e) {
	                    throw new POIXMLException(e);
	                }
	            }
	            if (pict instanceof CTPicture) {
	                pictures.add((CTPicture) pict);
	            }
	        }
	        return pictures;
	}
	
	public void createPicture(String blipId, int id, int width, int height,
			XWPFParagraph paragraph) throws InvalidFormatException, XmlException {
		final int EMU = 9525;
		width *= EMU;
		height *= EMU;
		// String blipId =
		// getAllPictures().get(id).getPackageRelationship().getId();
		/*if (paragraph == null) {
			paragraph = createParagraph();
		}*/
		
		//CTInline inline = paragraph.createRun().getCTR().addNewDrawing()
		//		.addNewInline();
		CTAnchor ctAnchor = paragraph.createRun().getCTR().addNewDrawing().addNewAnchor();
		
		//ctAnchor.setLocked(true);
		//ctAnchor.setLayoutInCell(true);
		//ctAnchor.setBehindDoc(true);
		//ctAnchor.setAllowOverlap(true);
		//org.openxmlformats.schemas.drawingml.x2006.wordprocessingDrawing.CTPosH po = ctAnchor.addNewPositionH();
		CTAnchor inline = ctAnchor;
		
		String picXml = ""
				+ "<a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">"
				+ "   <a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">"
				+ "      <pic:pic xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">"
				+ "         <pic:nvPicPr>" + "            <pic:cNvPr id=\""
				+ id
				+ "\" name=\"img_"
				+ id
				+ "\"/>"
				+ "            <pic:cNvPicPr/>"
				+ "         </pic:nvPicPr>"
				+ "         <pic:blipFill>"
				+ "            <a:blip r:embed=\""
				+ blipId
				+ "\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\"/>"
				+ "            <a:stretch>"
				+ "               <a:fillRect/>"
				+ "            </a:stretch>"
				+ "         </pic:blipFill>"
				+ "         <pic:spPr>"
				+ "            <a:xfrm>"
				+ "               <a:off x=\"0\" y=\"0\"/>"
				+ "               <a:ext cx=\""
				+ width
				+ "\" cy=\""
				+ height
				+ "\"/>"
				+ "            </a:xfrm>"
				+ "            <a:prstGeom prst=\"rect\">"
				+ "               <a:avLst/>"
				+ "            </a:prstGeom>"
				+ "         </pic:spPr>"
				+ "      </pic:pic>"
				+ "   </a:graphicData>" + "</a:graphic>";
		// CTGraphicalObjectData graphicData =
		// inline.addNewGraphic().addNewGraphicData();
		XmlToken xmlToken = null;
		try {
			xmlToken = XmlToken.Factory.parse(picXml);
		} catch (XmlException xe) {
			xe.printStackTrace();
		}
		inline.set(xmlToken);
		inline.setLocked(true);
		inline.setLayoutInCell(true);
		inline.setBehindDoc(true);
		inline.setAllowOverlap(true);
		inline.setRelativeHeight(0);
		// graphicData.set(xmlToken);
		inline.setDistT(0);
		inline.setDistB(0);
		inline.setDistL(0);
		inline.setDistR(0);
		CTPositiveSize2D extent = inline.addNewExtent();
		extent.setCx(width);
		extent.setCy(height);
		CTNonVisualDrawingProps docPr = inline.addNewDocPr();
		docPr.setId(id);
		docPr.setName("docx_img_ " + id);
		docPr.setDescr("docx Picture");
		CTPoint2D addNewGraphic = inline.addNewSimplePos();
		addNewGraphic.setX(0);
		addNewGraphic.setY(0);
	}
	
	private String getPicXml(int id, String blipId, int width, int height) {
		final int EMU = 9525;
		width *= EMU;
		height *= EMU;
		/*return "<anchor allowOverlap=\"true\" layoutInCell=\"false\" locked=\"false\" behindDoc=\"false\" relativeHeight=\"0\" simplePos=\"false\" distR=\"0\" distL=\"0\" distB=\"0\" distT=\"0\">" + 
				"	<simplePos y=\"0\" x=\"0\"/>" + 
				"	<positionH relativeFrom=\"margin\">" + 
				"		<align>right</align>" + 
				"	</positionH>" + 
				"	<positionV relativeFrom=\"page\">" + 
				"		<posOffset>360000</posOffset>" + 
				"	</positionV>" + 
				"	<extent cy=\""+
				width + "\" cx=\""+
				height +"\"/>" + 
				"	<effectExtent b=\"0\" r=\"0\" t=\"0\" l=\"0\"/>" + 
				"	<wrapNone/>" + 
				"	<docPr descr=\"docx Picture\" name=\"docx_img_ "+
				id +"\" id=\""+
				id +"\"/>" + 
				"	<cNvGraphicFramePr>" + 
				"		<a:graphicFrameLocks noChangeAspect=\"true\" xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" />" + 
				"	</cNvGraphicFramePr>" + 
				"	<a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">" + 
				"		<a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\" xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">" + 
				"			<pic:pic xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">" + 
				"				<pic:nvPicPr>" + 
				"					<pic:cNvPr name=\"img_"+
				id+"\" id=\""+
				id + "\"/>" + 
				"					<pic:cNvPicPr/>" + 
				"				</pic:nvPicPr>" + 
				"				<pic:blipFill>" + 
				"					<a:blip r:embed=\""+
				blipId +"\"/>" + 
				"					<a:stretch>" + 
				"						<a:fillRect/>" + 
				"					</a:stretch>" + 
				"				</pic:blipFill>" + 
				"				<pic:spPr>" + 
				"					<a:xfrm>" + 
				"						<a:off y=\"0\" x=\"0\"/>" + 
				"						<a:ext cy=\""+
				width +"\" cx=\""+
				height +"\"/>" + 
				"					</a:xfrm>" + 
				"					<a:prstGeom prst=\"rect\">" + 
				"						<a:avLst/>" + 
				"					</a:prstGeom>" + 
				"				</pic:spPr>" + 
				"			</pic:pic>" + 
				"		</a:graphicData>" + 
				"	</a:graphic>" + 
				"</anchor>";*/
		return "<wp:anchor locked=\"true\" layoutInCell=\"true\" behindDoc=\"true\" allowOverlap=\"true\" relativeHeight=\"0\" distT=\"0\" distB=\"0\" distL=\"0\" distR=\"0\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:mc=\"http://schemas.openxmlformats.org/markup-compatibility/2006\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:w10=\"urn:schemas-microsoft-com:office:word\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\" xmlns:w15=\"http://schemas.microsoft.com/office/word/2012/wordml\" xmlns:wne=\"http://schemas.microsoft.com/office/word/2006/wordml\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:wp14=\"http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing\" xmlns:wpc=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\" xmlns:wpg=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\" xmlns:wpi=\"http://schemas.microsoft.com/office/word/2010/wordprocessingInk\" xmlns:wps=\"http://schemas.microsoft.com/office/word/2010/wordprocessingShape\" xmlns:wpsCustomData=\"http://www.wps.cn/officeDocument/2013/wpsCustomData\">" + 
				"  <wp:simplePos x=\"0\" y=\"0\"/>" + 
				"  <wp:positionH relativeFrom=\"margin\">" + 
				"  <wp:align>right</wp:align>" + 
				"  </wp:positionH>" + 
				"  <wp:positionV relativeFrom=\"margin\">" + 
				"  <wp:align>bottom</wp:align>" + 
				"  </wp:positionV>"+
				"  <wp:extent cx=\""+width+"\" cy=\""+height+"\"/>" + 
				"  <wp:docPr id=\""+id+"\" name=\"docx_img_ "+id+"\" descr=\"docx Picture\"/>" + 
				"  <a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">" + 
				"    <a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">" + 
				"      <pic:pic xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">" + 
				"        <pic:nvPicPr>" + 
				"          <pic:cNvPr id=\""+id+"\" name=\"img_"+id+"\"/>" + 
				"          <pic:cNvPicPr/>" + 
				"        </pic:nvPicPr>" + 
				"        <pic:blipFill>" + 
				"          <a:blip r:embed=\""+blipId+"\"/>" + 
				"          <a:stretch>" + 
				"            <a:fillRect/>" + 
				"          </a:stretch>" + 
				"        </pic:blipFill>" + 
				"        <pic:spPr>" + 
				"          <a:xfrm>" + 
				"            <a:off x=\"0\" y=\"0\"/>" + 
				"            <a:ext cx=\""+width+"\" cy=\""+height+"\"/>" + 
				"          </a:xfrm>" + 
				"          <a:prstGeom prst=\"rect\">" + 
				"            <a:avLst/>" + 
				"          </a:prstGeom>" + 
				"        </pic:spPr>" + 
				"      </pic:pic>" + 
				"    </a:graphicData>" + 
				"  </a:graphic>" + 
				"</wp:anchor>";
		
	}
	
	/**
	 * @Description: 设置段落对齐
	 */
	public void setParagraphAlignInfo(XWPFParagraph p,
			ParagraphAlignment pAlign, TextAlignment valign) {
		if (pAlign != null) {
			p.setAlignment(pAlign);
		}
		if (valign != null) {
			p.setVerticalAlignment(valign);
		}
	}
	
	
	public void createFooter(XWPFDocument document, String telephone, String orgAddress) throws Exception {
        /*CTSectPr sectPr = document.getDocument().getBody().addNewSectPr();
        XWPFHeaderFooterPolicy headerFooterPolicy = new XWPFHeaderFooterPolicy(document, sectPr);
        XWPFFooter footer =  headerFooterPolicy.createFooter(STHdrFtr.DEFAULT);*/
        XWPFFooter footer = document.getFooterArray(0);
        XWPFParagraph paragraph = footer.createParagraph();
        paragraph.setAlignment(ParagraphAlignment.LEFT);
        paragraph.setVerticalAlignment(TextAlignment.CENTER);
        paragraph.setBorderTop(Borders.THICK);
        CTTabStop tabStop = paragraph.getCTP().getPPr().addNewTabs().addNewTab();
        tabStop.setVal(STTabJc.RIGHT);
        int twipsPerInch =  1440;
        tabStop.setPos(BigInteger.valueOf(6 * twipsPerInch));
    }
	
    private int getRelationIndex(XWPFDocument doc, XWPFRelation relation) {
        int i = 1;
        for (RelationPart rp : doc.getRelationParts()) {
            if (rp.getRelationship().getRelationshipType().equals(relation.getRelation())) {
                i++;
            }
        }
        return i;
    }
    
    private CTHdrFtr buildHdrFtr(String pStyle, XWPFParagraph[] paragraphs, XWPFHeaderFooter wrapper) {
        CTHdrFtr ftr = wrapper._getHdrFtr();
        if (paragraphs != null) {
            for (int i = 0; i < paragraphs.length; i++) {
                CTP p = ftr.addNewP();
                ftr.setPArray(i, paragraphs[i].getCTP());
            }
//        } else {
//            CTP p = ftr.addNewP();
//            CTBody body = doc.getDocument().getBody();
//            if (body.sizeOfPArray() > 0) {
//                CTP p0 = body.getPArray(0);
//                if (p0.isSetRsidR()) {
//                    byte[] rsidr = p0.getRsidR();
//                    byte[] rsidrdefault = p0.getRsidRDefault();
//                    p.setRsidP(rsidr);
//                    p.setRsidRDefault(rsidrdefault);
//                }
//            }
//            CTPPr pPr = p.addNewPPr();
//            pPr.addNewPStyle().setVal(pStyle);
        }
        return ftr;
    }
	
}
