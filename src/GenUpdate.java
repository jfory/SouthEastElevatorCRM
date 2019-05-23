import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;


public class GenUpdate {
	public static List fileList = new ArrayList();
	public static TreeMap fileMap = new TreeMap();
	//最深一层路径写在最前面
	public static String[] sourceFolder = {"elcs/"};

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String webName = "";
		webName = "DNCRM";
//		webName = "smp";
//		webName = "smpweb"; 
//		webName = "FOS3";
		
		String outRoot = "F:/"+webName+"/";
		String inRoot = "D:/Work/DNCRMDEPLOY/更新文件列表/"+webName+"（"+new SimpleDateFormat("yyyy-MM-dd HHmmss").format(new Date())+"）更新包/"+webName+"/";
		String listFile = "D:/Work/DNCRMDEPLOY/DNCRM.txt";
//		String listFile = "c:/UpdateList/更新列表("+webName+")(2).txt";
		File lfile = new File(listFile); 
		if(!lfile.exists() || !lfile.isFile()){
			System.out.println("更新列表的txt文件未找到!");
			return;
		}
		FileInputStream fis = null; 
		InputStreamReader read = null;
		BufferedReader br = null;
		String lineData = "";
		String outFile = "";
		String inFile = "";
		try {
			fis = new FileInputStream(lfile);
			read = new InputStreamReader(fis);
			br = new BufferedReader(read);
			while(null != (lineData = br.readLine()) && !"".equals(lineData.trim())){
				lineData = lineData.trim();
				fileMap.put(lineData, "");
				if(lineData.startsWith("src/")){
					//保存java更新文件的源代码文件
					outFile = outRoot + lineData;
					inFile = inRoot.substring(0, inRoot.length()-1)+"-源代码" + lineData.substring(3);
					copyFile(outFile, inFile);
					//检查src下面的文件夹设置成了项目根文件夹
					for(int t=0,len=sourceFolder.length; t<len; t++){
						if(lineData.startsWith("src/"+sourceFolder[t])){
							int index = lineData.indexOf(sourceFolder[t]);
							lineData = lineData.substring(0,index)+lineData.substring(index+sourceFolder[t].length());
							break;
						}
					}
					
					//处理java编译出来的class更新文件路径
					lineData = "WebRoot/WEB-INF/classes"+lineData.substring(3);
					if(lineData.endsWith(".java")){
						lineData = lineData.substring(0, lineData.length()-4) + "class";
					}
				}else if (lineData.startsWith("resources/")){
					//保存java更新文件的源代码文件
					outFile = outRoot + lineData;
					inFile = inRoot.substring(0, inRoot.length()-1)+"-源代码" + lineData.substring(9);
					copyFile(outFile, inFile);
					//检查src下面的文件夹设置成了项目根文件夹
					for(int t=0,len=sourceFolder.length; t<len; t++){
						if(lineData.startsWith("resources/"+sourceFolder[t])){
							int index = lineData.indexOf(sourceFolder[t]);
							lineData = lineData.substring(0,index)+lineData.substring(index+sourceFolder[t].length());
							break;
						}
					}

					//处理java编译出来的class更新文件路径
					lineData = "WebRoot/WEB-INF/classes"+lineData.substring(9);
					if(lineData.endsWith(".java")){
						lineData = lineData.substring(0, lineData.length()-4) + "class";
					}
				}
				outFile = outRoot + lineData;
				inFile = inRoot + lineData.substring(8);
				copyFile(outFile, inFile);
			}
			//将更新列表文件一并到更新包文件夹中
			outFile = listFile;
			inFile = inRoot.substring(0, inRoot.length()-webName.length()-1)+lfile.getName();
			copyFile(outFile, inFile);
			System.out.println("文件复制结束!");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 打印未找到文件的记录
			if(fileList.isEmpty()){
				Object fileObj[] = fileMap.keySet().toArray();
				for (int i=fileMap.size()-1; i>=0 ; i--) {
					System.out.println(fileObj[i]);
				}
			}else{
				for(int i=0,len=fileList.size(); i<len; i++){
					System.out.println(fileList.get(i));
				}
				System.out.println("==========================================以上是更新列表中未找到对应文件的列表=====================================================");
			}
			
		}
	}
	
	public static void copyFile(String outFile, String inFile) throws Exception {
		File ofile = new File(outFile);
		File ifile = new File(inFile);
		if(ofile.isFile()){
			//是更新文件，则指定位置创建目录结构
			(new File(inFile.substring(0, inFile.lastIndexOf("/")))).mkdirs();
			InputStream is = new FileInputStream(ofile);
			OutputStream os = new FileOutputStream(ifile);
			byte[] buff = new byte[8192];
			int len = 0;
			while ((len = is.read(buff)) != -1) {
				os.write(buff, 0, len);
			}
			os.flush();
			os.close();
			is.close();
		}else{
			if(inFile.indexOf("-源代码")==-1){
				fileList.add(outFile);
			}
		}
	}

}
