package com.dncrm.listener.workflow;

import com.dncrm.common.MailUtil;
import com.dncrm.service.system.workflow.TaskAssignService;
import com.dncrm.util.PageData;
import com.dncrm.util.SelectByRole;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * 由于发邮件时间比较久，为不影响操作体验，加个线程发邮件
 */
public class ThreadMail implements Runnable {
    private String[] mailtos;
    private String subject;
    private String content;
    private List<PageData> plist;
    private TaskAssignService taskAssignService;
    private String user_id;
    private Map<String,Object> variablesMap;
    @Override
    public void run() {
        SelectByRole sbr = new SelectByRole();
        try {
            long btime=System.currentTimeMillis();
            if (plist!=null&&plist.size()>0){

                List<PageData> uslist=taskAssignService.findUsersByRoleIds(plist);
                String emailstr=",";//用于过滤重复
                if(uslist!=null&&uslist.size()>0){
                    List<String> mailList=new ArrayList<String>();
                    //将用户邮箱获取出来用于发送邮件
                    for (PageData uspd:uslist){
                        boolean re = sbr.findUserListQX(uspd.getString("USER_ID"),user_id);
                        if(uspd.getString("EMAIL")!=null&&!"".equals(uspd.getString("EMAIL"))&&re){
                            if(emailstr.indexOf(","+uspd.getString("EMAIL")+",")==-1){
                                mailList.add(uspd.getString("EMAIL"));
                                emailstr=emailstr+uspd.getString("EMAIL")+",";
                            }
                        }
                    }
                    if(mailList!=null&&mailList.size()>0){
                        String [] mailto=new String[mailList.size()];
                        mailList.toArray(mailto);
                        MailUtil.sendMail(mailto,subject,content);
                    }
                    long etime=System.currentTimeMillis();

                    System.out.println("endTime:"+etime);
                    System.out.println("endTime-beginTime:"+(etime-btime));
                }
            }else {
                if(variablesMap!=null&&variablesMap.get("approved")!=null){
                    PageData pd=new PageData();
                    pd.put("user_id",user_id);
                    List<PageData> uslist=taskAssignService.findUsersByRoleIds(pd);
                    if(uslist!=null&&uslist.size()>0){
                        PageData uspd=uslist.get(0);
                        if(uspd.getString("EMAIL")!=null&&!"".equals(uspd.getString("EMAIL"))){
                            MailUtil.sendMail(uspd.getString("EMAIL"),subject,content);
                        }
                    }
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public String[] getMailtos() {
        return mailtos;
    }

    public void setMailtos(String[] mailtos) {
        this.mailtos = mailtos;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<PageData> getPlist() {return plist;}

    public void setPlist(List<PageData> plist) {this.plist = plist;}

    public TaskAssignService getTaskAssignService() {
        return taskAssignService;
    }

    public void setTaskAssignService(TaskAssignService taskAssignService) {
        this.taskAssignService = taskAssignService;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public Map<String, Object> getVariablesMap() {
        return variablesMap;
    }

    public void setVariablesMap(Map<String, Object> variablesMap) {
        this.variablesMap = variablesMap;
    }
}