/*

 @Name: layui WebIM 1.0.0
 @Author：贤心
 @Date: 2014-04-25
 @Blog: http://sentsin.com
 
 */
 
;!function(win, undefined){
	var locat = (window.location+'').split('/'); 
	if('main'== locat[3]){
		locat =  locat[0]+'//'+locat[2];
	}else{
		locat =  locat[0]+'//'+locat[2]+'/'+locat[3];
	};
	
	var bothRoster = [];
	var toRoster = [];
	var unreadMsgCount = 0;
	var unreadMsgContent = [];
	var currentUserId;
	var currentuser_name;
	var currentUserFace;
	var options ={};
	
	var myDate = new Date();
	myDate.getYear();        //获取当前年份(2位)
	myDate.getFullYear();    //获取完整的年份(4位,1970-????)
	myDate.getMonth();       //获取当前月份(0-11,0代表1月)
	myDate.getDate();        //获取当前日(1-31)
	myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
	myDate.getTime();        //获取当前时间(从1970.1.1开始的毫秒数)
	myDate.getHours();       //获取当前小时数(0-23)
	myDate.getMinutes();     //获取当前分钟数(0-59)
	myDate.getSeconds();     //获取当前秒数(0-59)
	myDate.getMilliseconds();    //获取当前毫秒数(0-999)
	myDate.toLocaleDateString();     //获取当前日期
	var mytime=myDate.toLocaleTimeString();     //获取当前时间
	myDate.toLocaleString( );        //获取日期与时间
	
	function getSysTime(){
		return myDate.toLocaleString( ); 
	}
//	web-im init and login start
	Easemob.im.config = {
 		    /*
 		        The global value set for xmpp server
 		    */
 		    xmppURL: 'im-api.easemob.com',
 		    /*
 		        The global value set for Easemob backend REST API
 		        "http://a1.easemob.com"
 		    */
 		    apiURL: 'https://a1.easemob.com',
 		    /*
 		        连接时提供appkey
 		    */
// 		    appkey: "easemob-demo#chatdemoui",
 		    appkey: "sst#test",
 		    /*
 		     * 是否使用https 
 		     */
 		    https : true,
 		    /*
 		     * 是否使用多resource
 		     */
 		    multiResources: false

 		}
 	//login
 	conn = new Easemob.im.Connection({
		multiResources: Easemob.im.config.multiResources,
		https : Easemob.im.config.https,
		url: Easemob.im.config.xmppURL
	});
    
			var user_name = $("#hx_username").val();
			var pass_word = $("#hx_password").val();
           
          //根据用户名密码登录系统
			conn.open({
				apiUrl : Easemob.im.config.apiURL,
				user : user_name,
				pwd : pass_word,
				//连接时提供appkey
				appKey : Easemob.im.config.appkey
			});  
          //初始化连接
        	conn.listen({
        		//当连接成功时的回调方法
        		onOpened : function(message) {
        			
        			unreadMsgCount =0;
//        			alert("登录成功:"+JSON.stringify(message));
        			
        			//查询未读消息数
        			var url = locat+'/head/getUnreadMsgCountTotal.do?USERNAME='+user_name+'&tm='+ new Date().getTime();
        			$.ajax({
        				type: "GET",
        				url: url,
        				dataType:'json',
        				cache: false,
        				success: function(data){
        					if(data!=null&&data.total>0){
        						//提示未读消息
        						unreadMsgCount = data.total;
        						unreadMsgContent = data.mdata;
        						setTimeout(function () {
        			                $.gritter.add({
        			                    title: '您有'+unreadMsgCount+'条未读信息,请打开聊天界面查看！',
//        			                    text: '请前往查看',
        			                    time: 3000
        			                });
        			            }, 1000);
//        						alert("您有"+unreadMsgCount+"条未读消息，请查看！");
        					}else{
        						//加载显示聊天主界面
        						unreadMsgCount = 0;
        					}	
        				}
        			});
        			token = message.accessToken;
        			conn.setPresence();
        			currentUserId = user_name;
        			//启动心跳
        			if (conn.isOpened()) {
        				conn.heartBeat(conn);
        			}
        			//获取当前登录人的联系人列表
        			conn.getRoster({
        				success : function(roster) {
        					var curroster;
        					console.log("roster->",JSON.stringify(roster));
        					for ( var i in roster) {
        						
        						var ros = roster[i];
        						//both为双方互为好友，要显示的联系人,from我是对方的单向好友
        						if (ros.subscription == 'both'
        								|| ros.subscription == 'from') {
        							bothRoster.push(ros);
        							console.log("bothRoster->",JSON.stringify(bothRoster));
        						} else if (ros.subscription == 'to') {
        							//to表明了联系人是我的单向好友
        							toRoster.push(ros);
        							console.log("toRoster->",JSON.stringify(toRoster));
        						}
        					}
        					if (bothRoster.length > 0) {
        						curroster = bothRoster[0];
        						if (curroster)
        						//为webim构造json数据
        						console.log("begin to build contact json->");


        						console.log("bothRoster->",JSON.stringify(bothRoster));
        						var item = [];
        						
        						for (i = 0; i < bothRoster.length; i++) {
        							if (!(bothRoster[i].subscription == 'both' || bothRoster[i].subscription == 'from')) {
        								continue;
        							}
        							var jid = bothRoster[i].jid;
        							var id = jid.substring(jid.indexOf("_") + 1).split("@")[0];
        							console.log("id->",JSON.stringify(id));
        							var name =bothRoster[i].name;
        							console.log("name->",JSON.stringify(name));
        							var face = "http://localhost:8080/DNCRM/static/img/profile_small.jpg";
        							console.log("face->",JSON.stringify(face));
        							
        							var user = new Object();
        							user.id = id;
        							user.name = name;
        							user.face = face;
        							item.push(user);
        						}

        						var udata = new Object();
        						udata.name = "在线好友";
        						udata.nums = item.length;
        						udata.id = 1;
        						udata.item = item;
        						
        						var data = [];
        						data.push(udata);
        						
        						var friends = new Object();
        						friends.status = 1;
        						friends.msg = "ok";
        						friends.data = data;
        						
        						console.log("this item-->"+JSON.stringify(item));
        						console.log("this udata-->"+JSON.stringify(udata));
        						console.log("this data-->"+JSON.stringify(data));
        						console.log("this friends-->"+JSON.stringify(friends));
        						
        						//开始渲染webim的layout 
//        	        			xxim start
        	        			var config = {
        	        				    msgurl: '私信地址',
        	        				    chatlogurl: '聊天记录url前缀',
        	        				    aniTime: 200,
        	        				    right: -232,
        	        				    white:'#ffff',
        	        				    api: {
        	        				        friend: 'static/layim/friend.json', //好友列表接口
        	        				        group: 'static/layim/group.json', //群组列表接口 
        	        				        chatlog: 'static/layim/chatlog.json', //聊天记录接口
        	        				        groups: 'static/layim/groups.json', //群组成员接口
        	        				        sendurl: '' //发送消息接口
        	        				    },
        	        				    user: { //当前用户信息
        	        				    	id:  currentUserId,
        	        				        name: currentUserId,
        	        				        face: 'http://localhost:8080/DNCRM/static/img/profile_small.jpg'
        	        				    },
        	        				    
        	        				    //自动回复内置文案，也可动态读取数据库配置
        	        				    autoReplay: [
        	        				        '您好，我现在有事不在，一会再和您联系。', 
        	        				        '你没发错吧？',
        	        				        '洗澡中，请勿打扰，偷窥请购票，个体四十，团体八折，订票电话：一般人我不告诉他！',
        	        				        '你好，我是主人的美女秘书，有什么事就跟我说吧，等他回来我会转告他的。',
        	        				        '我正在拉磨，没法招呼您，因为我们家毛驴去动物保护协会把我告了，说我剥夺它休产假的权利。',
        	        				        '<（@￣︶￣@）>',
        	        				        '你要和我说话？你真的要和我说话？你确定自己想说吗？你一定非说不可吗？那你说吧，这是自动回复。',
        	        				        '主人正在开机自检，键盘鼠标看好机会出去凉快去了，我是他的电冰箱，我打字比较慢，你慢慢说，别急……',
        	        				        '(*^__^*) 嘻嘻，是贤心吗？'
        	        				    ],
        	        				    
        	        				    
        	        				    chating: {},
        	        				    hosts: (function(){
        	        				        var dk = location.href.match(/\:\d+/);
        	        				        dk = dk ? dk[0] : '';
        	        				        return 'http://' + document.domain + dk + '/';
        	        				    })(),
        	        				    json: function(url, data, callback, error){
        	        				        return $.ajax({
        	        				            type: 'POST',
        	        				            url: url,
        	        				            data: data,
        	        				            dataType: 'json',
        	        				            success: callback,
        	        				            error: error
        	        				        });
        	        				    },
        	        				    stopMP: function(e){
        	        				        e ? e.stopPropagation() : e.cancelBubble = true;
        	        				    }
        	        				}, dom = [$(window), $(document), $('html'), $('body')], xxim = {};

        	        				//主界面tab
        	        				xxim.tabs = function(index){
        	        				    var node = xxim.node;
        	        				    node.tabs.eq(index).addClass('xxim_tabnow').siblings().removeClass('xxim_tabnow');
        	        				    node.list.eq(index).show().siblings('.xxim_list').hide();
        	        				    if(node.list.eq(index).find('li').length === 0){
        	        				      //获取当前登录人的群组列表
        	        						conn.listRooms({
        	        							success : function(rooms) {
        	        								if (rooms && rooms.length > 0) {
        	        									//为webim构造json数据
        	        									console.log("begin to build group json->");

        	        	        						//get chatRoom list
        	        	        						console.log("rooms->",JSON.stringify(rooms));
        	        	        						var rItem = [];
        	        	        						
        	        	        						for (i = 0; i < rooms.length; i++) {
        	        	        							var rName = rooms[i].name;
        	        	        							var rId = rooms[i].roomId || rooms[i].id;
        	        	        							var rFace = "http://localhost:8080/DNCRM/static/img/profile_small.jpg";
        	        	        							var room = new Object();
        	        	        							room.id = rId;
        	        	        							room.name = rName;
        	        	        							room.face = rFace;
        	        	        							rItem.push(room);
        	        	        							
        	        	        							var category = new Object();
             	        	        						category.name = "群组";
             	        	        						category.nums = rItem.length;
             	        	        						category.id = 1;
             	        	        						category.item = rItem;
             	        	        						
             	        	        						var group =[];
             	        	        						group.push(category);
             	        	        						var dgroup = new Object();
             	        	        						dgroup.status = 1;
             	        	        						dgroup.msg = "ok";
             	        	        						dgroup.data = group;
             	        	        						
             	        	        						console.log("this rItem-->"+JSON.stringify(rItem));
             	        	        						console.log("this category-->"+JSON.stringify(category));
             	        	        						console.log("this group-->"+JSON.stringify(group));
             	        	        						console.log("this dgroup-->"+JSON.stringify(dgroup));
             	        	        						xxim.getDates(index,dgroup);
        	        	        						}

            	        	        					}
        	        								console.log("rooms->",JSON.stringify(rooms));
        	        								conn.setPresence();//设置用户上线状态，必须调用
        	        							},
        	        							error : function(e) {
        	        								conn.setPresence();//设置用户上线状态，必须调用
        	        							}
        	        						});
        	        				    }
        	        				};

        	        				//节点
        	        				xxim.renode = function(){
        	        				    var node = xxim.node = {
        	        				        tabs: $('#xxim_tabs>span'),
        	        				        list: $('.xxim_list'),
        	        				        online: $('.xxim_online'),
        	        				        setonline: $('.xxim_setonline'),
        	        				        onlinetex: $('#xxim_onlinetex'),
        	        				        xximon: $('#xxim_on'),
        	        				        layimFooter: $('#xxim_bottom'),
        	        				        xximHide: $('#xxim_hide'),
        	        				        xximSearch: $('#xxim_searchkey'),
        	        				        searchMian: $('#xxim_searchmain'),
        	        				        closeSearch: $('#xxim_closesearch'),
        	        				        layimMin: $('#layim_min')
        	        				    }; 
        	        				};

        	        				//主界面缩放
        	        				xxim.expend = function(){
        	        				    var node = xxim.node;
        	        				    if(xxim.layimNode.attr('state') !== '1'){
        	        				        xxim.layimNode.stop().animate({right: config.right}, config.aniTime, function(){
        	        				            node.xximon.addClass('xxim_off');
        	        				            try{
        	        				                localStorage.layimState = 1;
        	        				            }catch(e){}
        	        				            xxim.layimNode.attr({state: 1});
        	        				            node.layimFooter.addClass('xxim_expend').stop().animate({marginLeft: config.right}, config.aniTime/2);
        	        				            node.xximHide.addClass('xxim_show');
        	        				        });
        	        				    } else {
        	        				        xxim.layimNode.stop().animate({right: 1}, config.aniTime, function(){
        	        				            node.xximon.removeClass('xxim_off');
        	        				            try{
        	        				                localStorage.layimState = 2;
        	        				            }catch(e){}
        	        				            xxim.layimNode.removeAttr('state');
        	        				            node.layimFooter.removeClass('xxim_expend');
        	        				            node.xximHide.removeClass('xxim_show');
        	        				        });
        	        				        node.layimFooter.stop().animate({marginLeft: 0}, config.aniTime);
        	        				    }
        	        				};

        	        				//初始化窗口格局
        	        				xxim.layinit = function(){
        	        				    var node = xxim.node;
        	        				    
        	        				    //主界面
        	        				    try{
        	        				        if(!localStorage.layimState){       
        	        				            config.aniTime = 0;
        	        				            localStorage.layimState = 1;
        	        				        }
        	        				        if(localStorage.layimState === '1'){
        	        				            xxim.layimNode.attr({state: 1}).css({right: config.right});
        	        				            node.xximon.addClass('xxim_off');
        	        				            node.layimFooter.addClass('xxim_expend').css({marginLeft: config.right});
        	        				            node.xximHide.addClass('xxim_show');
        	        				        }
        	        				    }catch(e){
        	        				        layer.msg(e.message, 5, -1);
        	        				    }
        	        				};

        	        				//聊天窗口
        	        				xxim.popchat = function(param){
        	        				    var node = xxim.node, log = {};
        	        				    
        	        				    log.success = function(layero){
        	        				        layer.setMove();
        	        				     
        	        				        xxim.chatbox = layero.find('#layim_chatbox');
        	        				        log.chatlist = xxim.chatbox.find('.layim_chatmore>ul');
        	        				        
        	        				        log.chatlist.html('<li data-id="'+ param.id +'" type="'+ param.type +'"  id="layim_user'+ param.type + param.id +'"><span>'+ param.name +'</span><em>×</em></li>')
        	        				        xxim.tabchat(param, xxim.chatbox);
        	        				        
        	        				        //最小化聊天窗
        	        				        xxim.chatbox.find('.layer_setmin').on('click', function(){
        	        				            var indexs = layero.attr('times');
        	        				            layero.hide();
        	        				            node.layimMin.text(xxim.nowchat.name).show();
        	        				        });
        	        				        
        	        				        //关闭窗口
        	        				        xxim.chatbox.find('.layim_close').on('click', function(){
        	        				            var indexs = layero.attr('times');
        	        				            layer.close(indexs);
        	        				            xxim.chatbox = null;
        	        				            config.chating = {};
        	        				            config.chatings = 0;
        	        				        });
        	        				        
        	        				        //关闭某个聊天
        	        				        log.chatlist.on('mouseenter', 'li', function(){
        	        				            $(this).find('em').show();
        	        				        }).on('mouseleave', 'li', function(){
        	        				            $(this).find('em').hide();
        	        				        });
        	        				        log.chatlist.on('click', 'li em', function(e){
        	        				            var parents = $(this).parent(), dataType = parents.attr('type');
        	        				            var dataId = parents.attr('data-id'), index = parents.index();
        	        				            var chatlist = log.chatlist.find('li'), indexs;
        	        				            
        	        				            config.stopMP(e);
        	        				            
        	        				            delete config.chating[dataType + dataId];
        	        				            config.chatings--;
        	        				            
        	        				            parents.remove();
        	        				            $('#layim_area'+ dataType + dataId).remove();
        	        				            if(dataType === 'group'){
        	        				                $('#layim_group'+ dataType + dataId).remove();
        	        				            }
        	        				            
        	        				            if(parents.hasClass('layim_chatnow')){
        	        				                if(index === config.chatings){
        	        				                    indexs = index - 1;
        	        				                } else {
        	        				                    indexs = index + 1;
        	        				                }
        	        				                xxim.tabchat(config.chating[chatlist.eq(indexs).attr('type') + chatlist.eq(indexs).attr('data-id')]);
        	        				            }
        	        				            
        	        				            if(log.chatlist.find('li').length === 1){
        	        				                log.chatlist.parent().hide();
        	        				            } 
        	        				        });
        	        				        
        	        				        //聊天选项卡
        	        				        log.chatlist.on('click', 'li', function(){
        	        				            var othis = $(this), dataType = othis.attr('type'), dataId = othis.attr('data-id');
        	        				            xxim.tabchat(config.chating[dataType + dataId]);
        	        				        });
        	        				        
        	        				        //发送热键切换
        	        				        log.sendType = $('#layim_sendtype'), log.sendTypes = log.sendType.find('span');
        	        				        $('#layim_enter').on('click', function(e){
        	        				            config.stopMP(e);
        	        				            log.sendType.show();
        	        				        });
        	        				        log.sendTypes.on('click', function(){
        	        				            log.sendTypes.find('i').text('')
        	        				            $(this).find('i').text('√');
        	        				        });
        	        				        
        	        				        xxim.transmit();
        	        				        
        	        				    };
        	        				    
        	        				    log.html = '<div class="layim_chatbox" id="layim_chatbox">'
        	        				            +'<h6>'
        	        				            +'<span class="layim_move"></span>'
        	        				            +'    <a href="'+ param.url +'" class="layim_face" target="_blank"><img src="'+ param.face +'" ></a>'
        	        				            +'    <a href="'+ param.url +'" class="layim_names" target="_blank">'+ param.name +'</a>'
        	        				            +'    <span class="layim_rightbtn">'
        	        				            +'        <i class="layer_setmin"></i>'
        	        				            +'        <i class="layim_close"></i>'
        	        				            +'    </span>'
        	        				            +'</h6>'
        	        				            +'<div class="layim_chatmore" id="layim_chatmore">'
        	        				            +'    <ul class="layim_chatlist"></ul>'
        	        				            +'</div>'
        	        				            +'<div class="layim_groups" id="layim_groups"></div>'
        	        				            +'<div class="layim_chat">'
        	        				            +'    <div class="layim_chatarea" id="layim_chatarea">'
        	        				            +'        <ul class="layim_chatview layim_chatthis"  id="layim_area'+ param.type + param.id +'"></ul>'
        	        				            +'    </div>'
        	        				            +'    <div class="layim_tool">'
        	        				            +'        <i class="layim_addface" title="发送表情"></i>'
        	        				            +'        <a href="javascript:;"><i class="layim_addimage" title="上传图片"></i></a>'
        	        				            +'        <a href="javascript:;"><i class="layim_addfile" title="上传附件"></i></a>'
        	        				            +'        <a href="" target="_blank" class="layim_seechatlog"><i></i>聊天记录</a>'
        	        				            +'    </div>'
        	        				            +'    <textarea class="layim_write" id="layim_write"></textarea>'
        	        				            +'    <div class="layim_send">'
        	        				            +'        <div class="layim_sendbtn" id="layim_sendbtn">发送<span class="layim_enter" id="layim_enter"><em class="layim_zero"></em></span></div>'
        	        				            +'        <div class="layim_sendtype" id="layim_sendtype">'
        	        				            +'            <span><i>√</i>按Enter键发送</span>'
        	        				            +'            <span><i></i>按Ctrl+Enter键发送</span>'
        	        				            +'        </div>'
        	        				            +'    </div>'
        	        				            +'</div>'
        	        				            +'</div>';

        	        				    if(config.chatings < 1){
        	        				        $.layer({
        	        				            type: 1,
        	        				            border: [0],
        	        				            title: false,
        	        				            shade: [0],
        	        				            area: ['620px', '493px'],
        	        				            move: ['.layim_chatbox .layim_move', true],
        	        				            moveType: 1,
        	        				            closeBtn: false,
        	        				            offset: [(($(window).height() - 493)/2)+'px', ''],
        	        				            page: {
        	        				                html: log.html
        	        				            }, success: function(layero){
        	        				                log.success(layero);
        	        				            }
        	        				        })
        	        				    } else {
        	        				        log.chatmore = xxim.chatbox.find('#layim_chatmore');
        	        				        log.chatarea = xxim.chatbox.find('#layim_chatarea');
        	        				        
        	        				        log.chatmore.show();
        	        				        
        	        				        log.chatmore.find('ul>li').removeClass('layim_chatnow');
        	        				        log.chatmore.find('ul').append('<li data-id="'+ param.id +'" type="'+ param.type +'" id="layim_user'+ param.type + param.id +'" class="layim_chatnow"><span>'+ param.name +'</span><em>×</em></li>');
        	        				        
        	        				        log.chatarea.find('.layim_chatview').removeClass('layim_chatthis');
        	        				        log.chatarea.append('<ul class="layim_chatview layim_chatthis" id="layim_area'+ param.type + param.id +'"></ul>');
        	        				        
        	        				        xxim.tabchat(param);
        	        				    }
        	        				    
        	        				    //群组
        	        				    log.chatgroup = xxim.chatbox.find('#layim_groups');
        	        				    if(param.type === 'group'){
        	        				        log.chatgroup.find('ul').removeClass('layim_groupthis');
        	        				        log.chatgroup.append('<ul class="layim_groupthis" id="layim_group'+ param.type + param.id +'"></ul>');
        	        				        xxim.getGroups(param);
        	        				    }
        	        				    //点击群员切换聊天窗
        	        				    log.chatgroup.on('click', 'ul>li', function(){
        	        				        xxim.popchatbox($(this));
        	        				    });
        	        				};

        	        				//定位到某个聊天队列
        	        				xxim.tabchat = function(param){
        	        				    var node = xxim.node, log = {}, keys = param.type + param.id;
        	        				    xxim.nowchat = param;
        	        				    
        	        				    xxim.chatbox.find('#layim_user'+ keys).addClass('layim_chatnow').siblings().removeClass('layim_chatnow');
        	        				    xxim.chatbox.find('#layim_area'+ keys).addClass('layim_chatthis').siblings().removeClass('layim_chatthis');
        	        				    xxim.chatbox.find('#layim_group'+ keys).addClass('layim_groupthis').siblings().removeClass('layim_groupthis');
        	        				    
        	        				    xxim.chatbox.find('.layim_face>img').attr('src', param.face);
        	        				    xxim.chatbox.find('.layim_face, .layim_names').attr('href', param.href);
        	        				    xxim.chatbox.find('.layim_names').text(param.name);
        	        				    
        	        				    xxim.chatbox.find('.layim_seechatlog').attr('href', config.chatlogurl + param.id);
        	        				   
        	        				    // 检查未读消息
        	        				   handleUnreadMsg(param.id,currentUserId,"hideU");
        	        				    log.groups = xxim.chatbox.find('.layim_groups');
        	        				    if(param.type === 'group'){
        	        				        log.groups.show();
        	        				    } else {
        	        				        log.groups.hide();
        	        				    }
        	        				    
        	        				    $('#layim_write').focus();
        	        				    
        	        				};
        	        				//弹出聊天窗
        	        				xxim.popchatbox = function(othis){
        	        				    var node = xxim.node, dataId = othis.attr('data-id'), param = {
        	        				        id: dataId, //用户ID
        	        				        type: othis.attr('type'),
        	        				        name: othis.find('.xxim_onename').text(),  //用户名
        	        				        face: othis.find('.xxim_oneface').attr('src'),  //用户头像
        	        				        href: config.hosts + 'user/' + dataId //用户主页
        	        				    }, key = param.type + dataId;
        	        				    if(!config.chating[key]){
        	        				        xxim.popchat(param);
        	        				        config.chatings++;
        	        				    } else {
        	        				        xxim.tabchat(param);
        	        				    }
        	        				    config.chating[key] = param;
        	        				    
        	        				    var chatbox = $('#layim_chatbox');
        	        				    if(chatbox[0]){
        	        				        node.layimMin.hide();
        	        				        chatbox.parents('.xubox_layer').show();
//        	        				        // 检查未读消息
//            	        				   handleUnreadMsg(dataId,currentUserId,"hideU");
        	        				    }
        	        				};

        	        				//请求群员
        	        				xxim.getGroups = function(param){
        	        					var keys = param.type + param.id, str = '',
        	        				    groupss = xxim.chatbox.find('#layim_group'+ keys);
        	        				    groupss.addClass('loading');
        	        				    var Joccupants = [];//存放成员容器
	        						    //查询获取room信息
	        						    conn.queryRoomInfo({
	        						        roomId : param.id,
	        						        success : function(occs) {
	        						            if (occs) {
	        						                for ( var i = 0; i < occs.length; i++) {
	        						                	Joccupants.push(occs[i]);
	        						                	 console.log("joccupants11-->",JSON.stringify(Joccupants));
	        						                }
	        						            }
	        						            //查询获取room成员信息
	        						            conn.queryRoomMember({
	        						                roomId : param.id,
	        						                success : function(members) {
	        						                    if (members) {
	        						                        for ( var i = 0; i < members.length; i++) {
	        						                        	Joccupants.push(members[i]);
	        						                        	console.log("joccupants22-->",JSON.stringify(Joccupants));
	             	        	        						var gitem = [];
	             	        	        						
	             	        	        						for (i = 0; i < Joccupants.length; i++) {
	             	        	        							if ((!(Joccupants[i].affiliation == 'owner' || Joccupants[i].affiliation == 'member'))||(Joccupants[i].jid.substring(Joccupants[i].jid.indexOf("_") + 1).split("@")[0]==currentUserId)) {
	             	        	        								continue;
	             	        	        							}
	             	        	        							var jid = Joccupants[i].jid;
	             	        	        							var id = jid.substring(jid.indexOf("_") + 1).split("@")[0];
	             	        	        							console.log("id->",JSON.stringify(id));
	             	        	        							var name =id;//Joccupants[i].name;
	             	        	        							console.log("name->",JSON.stringify(name));
	             	        	        							var face = "http://localhost:8080/DNCRM/static/img/profile_small.jpg";
	             	        	        							console.log("face->",JSON.stringify(face));
	             	        	        							
	             	        	        							var member = new Object();
	             	        	        							member.id = id;
	             	        	        							member.name = name;
	             	        	        							member.face = face;
	             	        	        							gitem.push(member);
	             	        	        						}
	             	        	        						
	             	        	        						var groups = new Object();
	             	        	        						groups.status = 1;
	             	        	        						groups.msg = "ok";
	             	        	        						groups.data = gitem;
	             	        	        						xxim.getDates(2,groups);
	             	        	        						
	             	        	        						console.log("this gitem-->"+JSON.stringify(gitem));
	             	        	        						console.log("sthis groups-->"+JSON.stringify(groups));
	             	        	        						if(groups.status === 1){
	             	        	        							console.log("groups.status-->"+JSON.stringify(groups.status));
	             	        	        							console.log("sthis groups-lens->"+JSON.stringify(groups.data.length));
	             	        	        							
	             	        	        				            var ii = 0, lens = groups.data.length;
	             	        	        				            if(lens > 0){
	             	        	        				                for(; ii < lens; ii++){
	             	        	        				                	console.log("sthis groups-groups.data[ii].id->"+JSON.stringify(groups.data[ii].id));
	    	             	        	        							console.log("sthis groups-groups.data[ii].face->"+JSON.stringify(groups.data[ii].face));
	    	             	        	        							console.log("sthis groups-groups.data[ii].name->"+JSON.stringify(groups.data[ii].name));
	             	        	        				                    str += '<li data-id="'+ groups.data[ii].id +'" type="one"><img src="'+ groups.data[ii].face +'"><span class="xxim_onename">'+ groups.data[ii].name +'</span></li>';
	             	        	        				                }
	             	        	        				            } else {
	             	        	        				                str = '<li class="layim_errors">没有群员</li>';
	             	        	        				            }
	             	        	        				            
	             	        	        				        } else {
	             	        	        				            str = '<li class="layim_errors">'+ groups.msg +'</li>';
	             	        	        				        }
	             	        	        						groupss.removeClass('loading');
	             	        	        				        groupss.html(str);
	        						                        }
	        						                    }else{
	        						                    	groupss.removeClass('loading');
	        						                        groupss.html('<li class="layim_errors">该群组没有成员</li>');
	        						                    }
	        						                    
	        						                }
	        						            });
	        						        }
	        						    });
	        						    console.log("joccupants33-->",JSON.stringify(Joccupants));
        	        				};

        	        				//消息传输
        	        				xxim.transmit = function(){
        	        				    var node = xxim.node, log = {};
        	        				    node.sendbtn = $('#layim_sendbtn');
        	        				    node.imwrite = $('#layim_write');
        	        				    
        	        				    //发送
        	        				    log.send = function(){
        	        				    	
        	        				        var data = {
        	        				            content: node.imwrite.val(),
        	        				            id: xxim.nowchat.id,
        	        				            sign_key: '', //密匙
        	        				            _: +new Date
        	        				        };

        	        				        if(data.content.replace(/\s/g, '') === ''){
        	        				            layer.tips('说点啥呗！', '#layim_write', 2);
        	        				            node.imwrite.focus();
        	        				            textSending = false;
        	        				        } else {
        	        				        	var to = xxim.nowchat.id;
            	        				    	if (to == null) {
            	        				    		textSending = false;
            	        				    		return;
            	        				    	}
            	        				    	
            	        				    	options = {
            	        				    		to : to,
            	        				    		msg : data.content,
            	        				    		type : "chat"
            	        				    	};
            	        				    	
            	        				    	console.log("send text conn is opened?-->"+conn.isOpened);
            	        				    	
        	        				        	conn.sendTextMessage(options);
        	        				            //此处皆为模拟
        	        				            var keys = xxim.nowchat.type + xxim.nowchat.id;
        	        				            
        	        				            //聊天模版
        	        				            log.html = function(param, type){
        	        				                return '<li class="'+ (type === 'me' ? 'layim_chateme' : '') +'">'
        	        				                    +'<div class="layim_chatuser">'
        	        				                        + function(){
        	        				                            if(type === 'me'){
        	        				                                return '<span class="layim_chattime">'+ param.time +'</span>'
        	        				                                       +'<span class="layim_chatname">'+ param.name +'</span>'
        	        				                                       +'<img src="'+ param.face +'" >';
        	        				                            } else {
        	        				                                return '<img src="'+ param.face +'" >'
        	        				                                       +'<span class="layim_chatname">'+ param.name +'</span>'
        	        				                                       +'<span class="layim_chattime">'+ param.time +'</span>';      
        	        				                            }
        	        				                        }()
        	        				                    +'</div>'
        	        				                    +'<div class="layim_chatsay">'+ param.content +'<em class="layim_zero"></em></div>'
        	        				                +'</li>';
        	        				            };
        	        				            
        	        				            log.imarea = xxim.chatbox.find('#layim_area'+ keys);
        	        				            
        	        				            log.imarea.append(log.html({
        	        				                time: getSysTime(),
        	        				                name: config.user.name,
        	        				                face: config.user.face,
        	        				                content: data.content
        	        				            }, 'me'));
        	        				            node.imwrite.val('').focus();
        	        				            log.imarea.scrollTop(log.imarea[0].scrollHeight);
        	        				            
        	        				            //自动回复
//        	        				            setTimeout(function(){
//        	        				                log.imarea.append(log.html({
//        	        				                    time: getSysTime(),
//        	        				                    name: xxim.nowchat.name,
//        	        				                    face: xxim.nowchat.face,
//        	        				                    content: config.autoReplay[(Math.random()*config.autoReplay.length) | 0]
//        	        				                }));
//        	        				                log.imarea.scrollTop(log.imarea[0].scrollHeight);
//        	        				            }, 500);
        	        				            
        	        				            /*
        	        				            that.json(config.api.sendurl, data, function(datas){
        	        				            
        	        				            });
        	        				            */
        	        				        }
        	        				       
        	        				    };
        	        				    node.sendbtn.on('click', log.send);
        	        				    node.imwrite.keyup(function(e){
        	        				        if(e.keyCode === 13){
        	        				            log.send();
        	        				        }
        	        				    });
        	        				    
        	        				};
        	        				//事件
        	        				xxim.event = function(){
        	        				    var node = xxim.node;
        	        				    
        	        				    //主界面tab
        	        				    node.tabs.eq(0).addClass('xxim_tabnow');
        	        				    node.tabs.on('click', function(){
        	        				        var othis = $(this), index = othis.index();
        	        				        xxim.tabs(index);
        	        				    });
        	        				    
        	        				    //列表展收
        	        				    node.list.on('click', 'h5', function(){
        	        				        var othis = $(this), chat = othis.siblings('.xxim_chatlist'), parentss = othis.parent();
        	        				        if(parentss.hasClass('xxim_liston')){
        	        				            chat.hide();
        	        				            parentss.removeClass('xxim_liston');
        	        				        } else {
        	        				            chat.show();
        	        				            parentss.addClass('xxim_liston');
        	        				        }
        	        				    });
        	        				    
        	        				    //设置在线隐身
        	        				    node.online.on('click', function(e){
        	        				        config.stopMP(e);
        	        				        node.setonline.show();
        	        				    });
        	        				    node.setonline.find('span').on('click', function(e){
        	        				        var index = $(this).index();
        	        				        config.stopMP(e);
        	        				        if(index === 0){
        	        				            node.onlinetex.html('提醒');
        	        				            node.online.removeClass('xxim_offline');
        	        				            $.session.set('isShowTips', '1')
        	        				        } else if(index === 1) {
        	        				            node.onlinetex.html('关闭');
        	        				            node.online.addClass('xxim_offline');
        	        				            $.session.set('isShowTips', '0')
        	        				        }
        	        				        node.setonline.hide();
        	        				    });
        	        				    
        	        				    node.xximon.on('click', xxim.expend);
        	        				    node.xximHide.on('click', xxim.expend);
        	        				    
        	        				    //搜索
        	        				    node.xximSearch.keyup(function(){
        	        				        var val = $(this).val().replace(/\s/g, '');
        	        				        if(val !== ''){
        	        				            node.searchMian.show();
        	        				            node.closeSearch.show();
        	        				            //此处的搜索ajax参考xxim.getDates
        	        				            node.list.eq(3).html('<li class="xxim_errormsg">没有符合条件的结果</li>');
        	        				        } else {
        	        				            node.searchMian.hide();
        	        				            node.closeSearch.hide();
        	        				        }
        	        				    });
        	        				    node.closeSearch.on('click', function(){
        	        				        $(this).hide();
        	        				        node.searchMian.hide();
        	        				        node.xximSearch.val('').focus();
        	        				    });
        	        				    
        	        				    //弹出聊天窗
        	        				    config.chatings = 0;
        	        				    node.list.on('click', '.xxim_childnode', function(){
        	        				        var othis = $(this);
        	        				        xxim.popchatbox(othis);
        	        				    });
        	        				    
        	        				    //点击最小化栏
        	        				    node.layimMin.on('click', function(){
        	        				        $(this).hide();
        	        				        $('#layim_chatbox').parents('.xubox_layer').show();
        	        				        var curChatUserId = $(".layim_chatnow").attr('data-id');
        	        				        // 检查未读消息
             	        				    handleUnreadMsg(curChatUserId,currentUserId,"hideU");
        	        				    });
        	        				    
        	        				    //document事件
        	        				    dom[1].on('click', function(){
        	        				        node.setonline.hide();
        	        				        $('#layim_sendtype').hide();
        	        				    });
        	        				};

        	        				//请求列表数据
        	        				xxim.getDates = function(index,datas){
        	        				    var api = [config.api.friend, config.api.group, config.api.chatlog],
        	        				        node = xxim.node, myf = node.list.eq(index);
        	        				    myf.addClass('loading');
        	        				    console.log("index is -->"+index);
        	        				    if(index==0){//好友列表
        	        				        console.log("datas is -->"+JSON.stringify(datas));
        	        				        if(datas.status === 1){
        	        				            var i = 0, myflen = datas.data.length, str = '', item;
        	        				            console.log("myflen is -->"+myflen);
        	        				            if(myflen > 0){
    	        				                    for(; i < myflen; i++){
    	        				                    	console.log("datas.data[i] is -->"+datas.data[i]);
    	        				                    	console.log("datas.data[i].id is -->"+datas.data[i].id);
    	        				                        str += '<li data-id="'+ datas.data[i].id +'" class="xxim_parentnode">'
    	        				                            +'<h5><i></i><span class="xxim_parentname">'+ datas.data[i].name +'</span><em class="xxim_nums">（'+ datas.data[i].nums +'）</em></h5>'
    	        				                            +'<ul class="xxim_chatlist">';
    	        				                        item = datas.data[i].item;
    	        				                        for(var j = 0; j < item.length; j++){
    	        				                        	
    	        				                        	//未读消息
    	        				                        	if(unreadMsgContent!=null&&unreadMsgContent.length>0){
    	        				                        		var unreadCount = 0;
        	        				                        	for(var k = 0;k<unreadMsgContent.length;k++){
        	        				                        		if(item[j].id==unreadMsgContent[k].from){
        	        				                        			unreadCount = unreadMsgContent[k].count;
        	        				                        		}
        	        				                        	}
        	        				                        	if(unreadCount>0){
        	        				                        		str += '<li data-id="'+ item[j].id +'" id="xxim_widget_user_list_'+item[j].id+'" style="background-color: #b6d7cc;" class="xxim_childnode" type="'+ (index === 0 ? 'one' : 'group') +'"><img src="'+ item[j].face +'" class="xxim_oneface"><span class="xxim_onename">'+ item[j].name +'</span>'+
        	        				                        		'<span id="xxim_right_unread_msg_count'+item[j].id+'" class="label label-warning" style="float:right;">'+unreadCount+'</span></li>';
        	        				                        	}else{
        	        				                        		str += '<li data-id="'+ item[j].id +'" id="xxim_widget_user_list_'+item[j].id+'" class="xxim_childnode" type="'+ (index === 0 ? 'one' : 'group') +'"><img src="'+ item[j].face +'" class="xxim_oneface"><span class="xxim_onename">'+ item[j].name +'</span></li>';
        	        				                        	}
    	        				                        	}else{
    	        				                        		str += '<li data-id="'+ item[j].id +'" id="xxim_widget_user_list_'+item[j].id+'" class="xxim_childnode" type="'+ (index === 0 ? 'one' : 'group') +'"><img src="'+ item[j].face +'" class="xxim_oneface"><span class="xxim_onename">'+ item[j].name +'</span></li>';
    	        				                        	}
    	        				                        }
    	        				                        str += '</ul></li>';
    	        				                    }
    	        				                
        	        				                myf.html(str);
        	        				            } else {
        	        				                myf.html('<li class="xxim_errormsg">没有任何数据</li>');
        	        				            }
        	        				            myf.removeClass('loading');
        	        				        } else {
        	        				            myf.html('<li class="xxim_errormsg">'+ datas.msg +'</li>');
        	        				        }
        	        				    }else if (index ==1){//群组列表
        	        				            console.log("datas is -->"+JSON.stringify(datas));
        	        				            if(datas.status === 1){
        	        				                var i = 0, myflen = datas.data.length, str = '', item;
        	        				                console.log("myflen is -->"+myflen);
        	        				                if(myflen > 0){
        	        				                    if(index !== 2){
        	        				                        for(; i < myflen; i++){
        	        				                        	console.log("datas.data[i] is -->"+datas.data[i]);
        	        				                        	console.log("datas.data[i].id is -->"+datas.data[i].id);
        	        				                            str += '<li data-id="'+ datas.data[i].id +'" class="xxim_parentnode">'
        	        				                                +'<h5><i></i><span class="xxim_parentname">'+ datas.data[i].name +'</span><em class="xxim_nums">（'+ datas.data[i].nums +'）</em></h5>'
        	        				                                +'<ul class="xxim_chatlist">';
        	        				                            item = datas.data[i].item;
        	        				                            for(var j = 0; j < item.length; j++){
//        	        				                                str += '<li data-id="'+ item[j].id +'" class="xxim_childnode" type="'+ (index === 0 ? 'one' : 'group') +'"><img src="'+ item[j].face +'" class="xxim_oneface"><span class="xxim_onename">'+ item[j].name +'</span></li>';
        	        				                                str += '<li data-id="'+ item[j].id +'" id="xxim_widget_group_list_'+item[j].id+'" class="xxim_childnode" type="'+ (index === 0 ? 'one' : 'group') +'"><span class="xxim_onename">'+ item[j].name +'</span></li>';
        	        				                            }
        	        				                            str += '</ul></li>';
        	        				                        }
        	        				                    } else {
        	        				                        str += '<li class="xxim_liston">'
        	        				                            +'<ul class="xxim_chatlist">';
        	        				                        for(; i < myflen; i++){
        	        				                            str += '<li data-id="'+ datas.data[i].id +'" class="xxim_childnode" type="one"><img src="'+ datas.data[i].face +'"  class="xxim_oneface"><span  class="xxim_onename">'+ datas.data[i].name +'</span><em class="xxim_time">'+ datas.data[i].time +'</em></li>'; 
        	        				                        }
        	        				                        str += '</ul></li>';
        	        				                    }
        	        				                    myf.html(str);
        	        				                } else {
        	        				                    myf.html('<li class="xxim_errormsg">没有任何数据</li>');
        	        				                }
        	        				                myf.removeClass('loading');
        	        				            } else {
        	        				                myf.html('<li class="xxim_errormsg">'+ datas.msg +'</li>');
        	        				            }
        	        				    	}else if (index ==2){//群组成员
        	        				            console.log("datas is -->"+JSON.stringify(datas));
        	        				            if(datas.status === 1){
        	        				                var i = 0, myflen = datas.data.length, str = '', item;
        	        				                console.log("myflen is -->"+myflen);
        	        				                if(myflen > 0){
    	        				                        str += '<li class="xxim_liston">'
    	        				                            +'<ul class="xxim_chatlist">';
    	        				                        for(; i < myflen; i++){
    	        				                            str += '<li data-id="'+ datas.data[i].id +'" class="xxim_childnode" type="one"><img src="'+ datas.data[i].face +'"  class="xxim_oneface"><span  class="xxim_onename">'+ datas.data[i].name +'</span><em class="xxim_time">'+ datas.data[i].time +'</em></li>'; 
    	        				                        }
    	        				                        str += '</ul></li>';
    	        				                    
        	        				                    myf.html(str);
        	        				                } else {
        	        				                    myf.html('<li class="xxim_errormsg">没有任何数据</li>');
        	        				                }
        	        				                myf.removeClass('loading');
        	        				            } else {
        	        				                myf.html('<li class="xxim_errormsg">'+ datas.msg +'</li>');
        	        				            }
        	        				    	}
        	        				};

        	        				//渲染骨架
        	        				xxim.view = (function(){
		        						 var xximNode = xxim.layimNode = $('<div id="xximmm" class="xxim_main">'
	     	        				            +'<div class="xxim_top" id="xxim_top">'
	     	        				            +'  <div class="xxim_search"><i></i><input id="xxim_searchkey" /><span id="xxim_closesearch">×</span></div>'
	     	        				            +'  <div class="xxim_tabs" id="xxim_tabs"><span class="xxim_tabfriend" title="好友"><i></i></span><span class="xxim_tabgroup" title="群组"><i></i></span><span class="xxim_latechat"  title="最近聊天"><i></i></span></div>'
	     	        				            +'  <ul class="xxim_list" style="display:block"></ul>'
	     	        				            +'  <ul class="xxim_list"></ul>'
	     	        				            +'  <ul class="xxim_list"></ul>'
	     	        				            +'  <ul class="xxim_list xxim_searchmain" id="xxim_searchmain"></ul>'
	     	        				            +'</div>'
	     	        				            +'<ul class="xxim_bottom" id="xxim_bottom">'
	     	        				            +'	<li class="xxim_online xxim_offline" id="xxim_online">'
 	        				                	+'		<i class="xxim_nowstate"></i><span id="xxim_onlinetex">'+'关闭'+'</span>'
 	        				                	+'		<div class="xxim_setonline">'
 	        				                	+'			<span><i></i>提醒</span>'
 	        				                	+'			<span class="xxim_setoffline"><i></i>关闭</span>'
 	        				                    +'		</div>'
 	        				                    +'	</li>'
	     	        				            +'	<li class="xxim_mymsg" id="xxim_mymsg" title="设置消息提醒">'
	         	        				           +function(){
	             	        	                            if(unreadMsgCount==null||(parseInt(unreadMsgCount)==0)){
	             	        	                                return '';
	             	        	                            } else {
	             	        	                                return '<span id="xxim_bottom_unread_msg_count" class="label label-warning" style="float:left;width:20px;padding: 2px;">'+unreadMsgCount+'</span>';      
	             	        	                            }
	         	        	                        	}()
	     	        				            +'	<i></i>'
	     	        				            +'<li class="xxim_seter" id="xxim_seter" title="设置">'
	     	        				                +'<i></i>'
	     	        				                +'<div class="">'
	     	        				                
	     	        				                +'</div>'
	     	        				            +'</li>'
	     	        				            +'<li class="xxim_hide" id="xxim_hide"><i></i></li>'
	     	        				            +'<li id="xxim_on" class="xxim_icon xxim_on"></li>'
	     	        				            +'<div class="layim_min" id="layim_min"></div>'
	     	        				        +'</ul>'
	     	        				    +'</div>');
        	        				    dom[3].append(xximNode);
        	        				    
        	        				    xxim.renode();
        	        				    xxim.getDates(0,friends);
        	        				    xxim.event();
        	        				    xxim.layinit();
        	        				    if($.session.get("isShowTips") != null&&($.session.get("isShowTips")==1)){
        	        				    	$("#xxim_online").removeClass("xxim_offline");
        	        				    	$("#xxim_onlinetex").text("提醒");
        	        				    }
        	        				}());
//        	        			xxim end
        						
        					}
        				}
        			});

        			//login is done ,and then do this 
        			
        		},
        		//当连接关闭时的回调方法
        		onClosed : function() {
        			console.log("conn.closed");
        		},
        		//收到文本消息时的回调方法
        		onTextMessage : function(message) {
        			console.log("got text message -->"+JSON.stringify(message));
        			//判断当前用户窗口是否已经被打开
        			 
        			var isShowTips= $.session.get('isShowTips');
        			var chatbox = $('#layim_chatbox');
        			if(chatbox!=null&&chatbox[0]){
        				var xubox_layer = $(".xubox_layer");
        				if(xubox_layer!=null){//聊天界面被打开或者最小化了
        					var isDisplay = xubox_layer.css("display");
        					var curChatUserId = $(".layim_chatthis").attr('id');
        					if(curChatUserId==('layim_areaone'+message.from)){//当前聊天窗口正是发送消息的用户
        						if(isDisplay=="none"){//聊天界面被最小化了
        							//提示收到用户消息
            						//更新最小化界面
        							showMiniMsgCount(message.from,1);
        							//更新左边角标
        							showLeftMsgCount(message.from,1);
        							//更新右边widget
        							showRightMsgCount(message.from,1);
        							//更新底部角标
        							showBottomMsgCount(1);
        							//更新后台数据库
        							var ms_data={
        								HX_FROM:message.from,
        								HX_TO:message.to,
        								HX_CONTENT:message.data,
        								HX_TYPE:message.type,
        								HX_MSG_ID:message.id
	        						}
        							updateUnreadMsg(ms_data);
            					}else if(isDisplay=="block"){//聊天界面在当前页面
            						//把消息更新到聊天界面
            						var hxmsg= Object();
            						hxmsg.from = message.from;
            						hxmsg.to = message.to;
            						hxmsg.content = message.data;
            						hxmsg.type = message.type;
            						loadMsgToChatWin(hxmsg,"one");
            						isShowTips=0;
            					}
        					}else{//当前聊天窗口非发送消息的用户
        						if(isDisplay=="none"){//聊天界面被最小化了
        							//提示收到用户消息
            						//更新最小化界面
        							//更新左边角标
        							showLeftMsgCount(message.from,1);
        							//更新右边widget
        							showRightMsgCount(message.from,1);
        							//更新底部角标
        							showBottomMsgCount(1);
        							
            					}else if(isDisplay=="block"){//聊天界面在当前页面
            						//提示收到用户消息
            						//更新聊天窗口左边list界面
            						showLeftMsgCount(message.from,1);
            						//更新底部角标
            						showBottomMsgCount(1);
            						//更新右边角标
            						showRightMsgCount(message.from,1);
            					}
        						//更新后台数据库
    							var ms_data={
        								HX_FROM:message.from,
        								HX_TO:message.to,
        								HX_CONTENT:message.data,
        								HX_TYPE:message.type,
        								HX_MSG_ID:message.id
	        						}
        							updateUnreadMsg(ms_data);
        					}
        					
        					
        				}
        			}else{//聊天界面没有被打开
    					//提示收到用户消息
						//更新右边widget
    					console.log(message.from);
    					showRightMsgCount(message.from,1);
						//更新底部角标
    					showBottomMsgCount(1);
						//更新后台数据库
    					var ms_data={
								HX_FROM:message.from,
								HX_TO:message.to,
								HX_CONTENT:message.data,
								HX_TYPE:message.type,
								HX_MSG_ID:message.id
    						}
    					updateUnreadMsg(ms_data);
        			}
        			if(isShowTips==1){
        			setTimeout(function () {
		                $.gritter.add({
//		                    title: '新的消息',
		                    text: '<img src="http://localhost:8080/DNCRM/static/img/profile_small.jpg" style="width:30px;height:30px"> '+message.from+' 说："'+message.data+'"',
		                    time: 4000
		                });
		                });
        			}
        		},
        		//收到表情消息时的回调方法
        		onEmotionMessage : function(message) {
        			var data = {
    			            content: message.data,
    			            id: message.from,
    			            sign_key: '', //密匙
    			            _: +new Date
    			        };
    			        var from = message.from;
    			        console.log("from-->"+from);
    			        var content = message.data;
    			        console.log("content1-->"+JSON.stringify(content));
    			        var time = getSysTime();
    			        console.log("time-->"+time);
    			        if(content!=null&&from!=null&&time!=null){
    			        	var html = '<li class="">'
                        +'<div class="layim_chatuser">'
                            + '<img src="http://localhost:8080/DNCRM/static/img/profile_small.jpg" >'
                            +'<span class="layim_chatname">'+ from +'</span>'
                            +'<span class="layim_chattime">'+ time +'</span>'
                        +'</div>'
                        +'<div class="layim_chatsay">'+ message.data +'<em class="layim_zero"></em></div>'
                    +'</li>';
    			        	$("#layim_areaone"+from).append(html);
    			        	$("#layim_areaone"+from).scrollTop($("#layim_areaone"+from)[0].scrollHeight);
    			        }
        		},
        		//收到图片消息时的回调方法
        		onPictureMessage : function(message) {
//        			alert("收到图片："+message);
        		},
        		//收到音频消息的回调方法
        		onAudioMessage : function(message) {
//        			alert("收到音频："+message);
        		},
        		//收到位置消息的回调方法
        		onLocationMessage : function(message) {
//        			alert("收到位置："+message);
        		},
        		//收到文件消息的回调方法
        		onFileMessage : function(message) {
//        			alert("收到文件："+message);
        		},
        		//收到视频消息的回调方法
        		onVideoMessage: function(message) {
//        			alert("收到视频："+message);
        		},
        		//收到联系人订阅请求的回调方法
        		onPresence: function(message) {
//        			alert("收到订阅："+message);
        		},
        		//收到联系人信息的回调方法
        		onRoster: function(message) {
//        			alert("收到联系人："+message);
        		},
        		//收到群组邀请时的回调方法
        		onInviteMessage: function(message) {
//        			alert("收到群组邀请："+message);
        		},
        		//异常时的回调方法
        		onError: function(message) {
        			alert("收到异常："+JSON.stringify(message));
        		}
        	});
        	
        	//处理未读消息
			handleUnreadMsg = function(from,to,act){
    			//去后台获取未读消息
    			var url = locat+'/head/getUnreadMsgContent.do?HX_FROM='+from+'&HX_TO='+to+'&tm='+ new Date().getTime();
    			$.ajax({
    				type: "GET",
    				url: url,
    				dataType:'json',
    				cache: false,
    				success: function(data){
    					if(data.status==1)
    						if(act=="hideU"){//点击左右列表
    							//load msg
    							var msg_ids ='';
    							for(var i=0;i<data.mdata.length;i++){
    								loadMsgToChatWin(data.mdata[i],"one");
    								if(msg_ids=='') msg_ids += data.mdata[i].id;
        						  	else msg_ids += ',' + data.mdata[i].id;
    							}
    							//去除左边和右边角标，更新底部角标
    							hideLeftMsgCount(from,data.mdata.length);
    							hideRightMsgCount(from,data.mdata.length);
    							hideBottomMsgCount(data.mdata.length);
    							hideMiniMsgCount(data.mdata.length);
    							//删除后台未读消息
    							delUnreadMsg(msg_ids);
    							
    						}
    					}	
    			});
			}
			//删除后台未读消息
			delUnreadMsg = function(msg_ids){//删除未读消息
				var del_url = locat+'/head/deleteAllUnreadMsg.do?&tm='+ new Date().getTime();
				if(msg_ids!=''){
					$.ajax({
						type: "POST",
						url: del_url,
						data: {MSG_IDS:msg_ids},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data.msg=='ok'){
							}
						}
					});
				}
			}
			//更新后台台未读消息
			updateUnreadMsg = function(msg){
				//更新后台数据库
				var update_url = locat+'/head/updateUnreadMsg.do?&tm='+ new Date().getTime();
					$.ajax({
						type: "POST",
						url: update_url,
				    	data: msg,
						dataType:'json',
						cache: false,
						success: function(data){
							if(data.msg=='ok'){
							}
						}
					});
			}
			//隐藏底部角标
			hideBottomMsgCount = function(count){
				var mcount = $("#xxim_bottom_unread_msg_count").text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)-count;
					if(parseInt(ncount)>0){
						$("#xxim_bottom_unread_msg_count").text(ncount);
					}else{
						$("#xxim_bottom_unread_msg_count").remove();
					}
				}else{
					$("#xxim_bottom_unread_msg_count").remove();
				}
			}
			//显示底部角标
			showBottomMsgCount = function(count){
				var mcount = $("#xxim_bottom_unread_msg_count").text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)+count;
						$("#xxim_bottom_unread_msg_count").text(ncount);
				}else{
					var mhtml = '<span id="xxim_bottom_unread_msg_count" class="label label-warning" style="float:left;width:20px;padding: 2px;">1</span>'
						$("#xxim_mymsg").append(mhtml);
				}
			}
			//显示右边角标
			showRightMsgCount = function(uid,count){
				var mcount = $("#xxim_right_unread_msg_count"+uid).text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)+count;
						$("#xxim_right_unread_msg_count"+uid).text(ncount);
				}else{
					var mhtml = '<span id="xxim_right_unread_msg_count'+uid+'" class="label label-warning" style="float:right;width:20px;padding: 2px;">1</span>'
						$("#xxim_widget_user_list_"+uid).append(mhtml);
						//更新右边widget颜色
						$("#xxim_widget_user_list_"+uid).css({"background-color": "#b6d7cc"});
				}
			}
			//隐藏右边角标
			hideRightMsgCount = function(uid,count){
				var mcount = $("#xxim_right_unread_msg_count"+uid).text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)-count;
					if(parseInt(ncount)>0){
						$("#xxim_right_unread_msg_count"+uid).text(ncount);
					}else{
						$("#xxim_right_unread_msg_count"+uid).remove();
						$("#xxim_widget_user_list_"+uid).css({"background-color": "white"});
					}
				}else{
					$("#xxim_right_unread_msg_count"+uid).remove();
					$("#xxim_widget_user_list_"+uid).css({"background-color": "white"});
				}
			}
			//显示左边角标
			showLeftMsgCount = function(uid,count){
				var mcount = $("#xxim_left_unread_msg_count_"+uid).text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)+count;
						$("#xxim_left_unread_msg_count_"+uid).text(ncount);
				}else{
					var mhtml = '<span id="xxim_left_unread_msg_count_'+uid+'" class="label label-warning" style="float:left;width:20px;padding: 2px;">1</span>'
						$("#layim_userone"+uid).append(mhtml);
				}
			}
			//隐藏左边角标
			hideLeftMsgCount = function(uid,count){
				
				var mcount = $("#xxim_left_unread_msg_count_"+uid).text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)-count;
					if(parseInt(ncount)>0){
						$("#xxim_left_unread_msg_count_"+uid).text(ncount);
					}else{
						$("#xxim_left_unread_msg_count_"+uid).remove();
					}
				}else{
					$("#xxim_left_unread_msg_count_"+uid).remove();
				}
			}
			//显示mini窗口角标
			showMiniMsgCount = function(uid,count){
				var mcount = $("#xxim_mini_unread_msg_count_"+uid).text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)+count;
						$("#xxim_mini_unread_msg_count_"+uid).text(ncount);
				}else{
					var mhtml = '<span id="xxim_mini_unread_msg_count_'+uid+'" class="label label-warning" style="float:right">1</span>'
						$("#layim_min").append(mhtml);
				}
			}
			//隐藏mini窗口角标
			hideMiniMsgCount = function(uid,count){
				var mcount = $("#xxim_mini_unread_msg_count_"+uid).text();
				if(mcount!=null&&parseInt(mcount)>0){
					var ncount = parseInt(mcount)-count;
					if(parseInt(ncount)>0){
						$("#xxim_mini_unread_msg_count_"+uid).text(ncount);
					}else{
						$("#xxim_mini_unread_msg_count_"+uid).remove();
					}
				}else{
					$("#xxim_mini_unread_msg_count_"+uid).remove();
				}
			}
			
			//加载消息到聊天窗口
		    loadMsgToChatWin = function(msg,type){
		    	var param ={
		    			name:msg.from,
		    			face:"http://localhost:8080/DNCRM/static/img/profile_small.jpg",
		    			time:getSysTime(),
		    			content:msg.content
		    	}
		    	var keys = type + msg.from;
		        if(msg.content!=null){
			    	if (msg.to == null) {
			    		return;
			    	}
		            var html = makeHtml(param,type);
		            $("#layim_area"+keys).append(html);
		            $("#layim_area"+keys).scrollTop($("#layim_area"+keys)[0].scrollHeight);
		        }
		    };
		    
		    //聊天模版
		    makeHtml = function(param, type){
                return '<li class="'+ (type === 'me' ? 'layim_chateme' : '') +'">'
                    +'<div class="layim_chatuser">'
                        + function(){
                            if(type === 'me'){
                                return '<span class="layim_chattime">'+ param.time +'</span>'
                                       +'<span class="layim_chatname">'+ param.name +'</span>'
                                       +'<img src="'+ param.face +'" >';
                            } else {
                                return '<img src="'+ param.face +'" >'
                                       +'<span class="layim_chatname">'+ param.name +'</span>'
                                       +'<span class="layim_chattime">'+ param.time +'</span>';      
                            }
                        }()
                    +'</div>'
                    +'<div class="layim_chatsay">'+ param.content +'<em class="layim_zero"></em></div>'
                +'</li>';
            };
//	web-im init and login end


}(window);

