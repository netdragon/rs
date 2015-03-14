
	function isNumber(str1){ 

	for(var i=0;i<str1.length;i++)
	{
		var isnum=str1.substring(i,i+1);
		if(isnum<"0"||isnum>"9")
		{	
		return false;
		}
	}
	return true;
	}

	function subchk() {
		//check user name length
		var fm = document.forms[0];
		var user_nameobj=document.getElementById("pname");
		var user_idcardobj=document.getElementById("pidcardnum");		

		var user_byxx=document.getElementById("pzxmc");
		
		//var fqxm_obj=document.getElementById("pfmxm");	
		//var mqxm_obj=document.getElementById("pmmxm");
		//var fqdw_obj=document.getElementById("fmgzdw");	
		//var mqdw_obj=document.getElementById("mmgzdw");
		//var fqydh_obj=document.getElementById("fmyddh");	
		//var mqydh_obj=document.getElementById("mmyddh");

		
		var username = (null == user_nameobj) ? "": user_nameobj.value;
		var useridcard = (null == user_idcardobj) ? "": user_idcardobj.value;		
		//var user_hk = (null == user_hkszd) ? "": user_hkszd.value;
		var user_xx = (null == user_byxx) ? "": user_byxx.value;
		//var fqxm = (null == fqxm_obj) ? "": fqxm_obj.value;
		//var mqxm = (null == mqxm_obj) ? "": mqxm_obj.value;	
		//var fqdw = (null == fqdw_obj) ? "": fqdw_obj.value;
		//var mqdw = (null == mqdw_obj) ? "": mqdw_obj.value;	
		//var fqydh = (null == fqydh_obj) ? "": fqydh_obj.value;
		//var mqydh = (null == mqydh_obj) ? "": mqydh_obj.value;

		var bk_obj1=document.getElementById("pzhiyuan1");	
		var bk_obj2=document.getElementById("pzhiyuan2");
		var bk_obj3=document.getElementById("pzhiyuan3");	
	

		
		var bk1 = (null == bk_obj1) ? "" : bk_obj1.value;
		var bk2 = (null == bk_obj2) ? "" : bk_obj2.value;
		var bk3 = (null == bk_obj3) ? "" : bk_obj3.value;

		if(fm.pname.value =="") {
			alert("姓名不能为空！");
			fm.pname.focus();
			return false;
		}	
					
		if(fm.pzxmc.value =="") {
			alert("中学名称不能为空！");
			fm.pzxmc.focus();
			return false;
		}

		if(useridcard.length == 0) {
			alert("身份证号不能为空！");
			fm.pidcardnum.focus();
			return false;
	    }	
	  if(useridcard.length!=15&&useridcard.length!=18){//身份证长度不正确
		alert("身份证长度不正确！"); 
		fm.pidcardnum.focus();
		return false; 
		} 
		if(useridcard.length==15){ 
		if(!isNumber(useridcard)){ 
		alert("15位身份证号只能输入数字！");
		fm.pidcardnum.focus();
		return false; 
		} 
		}else{ 
		str1 = useridcard.substring(0,17); 
		str2 = useridcard.substring(17,18); 
		alpha = "X0123456789"; 
		if(!isNumber(str1)||alpha.indexOf(str2)==-1){
		alert("18位身份证号末位只能为X且大写！"); 
		fm.pidcardnum.focus();
		return false; 
		} 
		}			

		if(fm.ptxdzh.value =="") {
			alert("通知书邮寄地址不能为空！");
			fm.ptxdzh.focus();
			return false;
		}
		if(fm.pyzbm.value =="") {
			alert("邮政编码不能为空！");
			fm.pyzbm.focus();
			return false;
		}
		if(fm.pshxr.value =="") {
			alert("收信人不能为空！");
			fm.pshxr.focus();
			return false;
		}
		if(fm.pyddh.value =="") {
			alert("收信人联系电话不能为空！");
			fm.pyddh.focus();
			return false;
		}



		if(fm.pzhiyuan1.value =="0") {
			alert("第一志愿不能为空！");
			fm.pzhiyuan1.focus();
			return false;
		}	
	
 



		if(bk1 == bk2 || bk1==bk3 ) {
			if(bk1!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}
		if(bk2==bk3 ) {
			if(bk2!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}

		
		
		document.forms[0].submit();
		return true;
	}
	function check_jg(selObj) {

		if(!(selObj.value == "北京" || selObj.value == "天津" || 
			selObj.value == "河北" || selObj.value == "辽宁" || 
			selObj.value == "江苏" || selObj.value == "山东" || 
			selObj.value == "安徽" || selObj.value == "河南" ||
			selObj.value == "湖南" || selObj.value == "陕西" || 
			selObj.value == "新疆" )){
			
			if((selObj = document.getElementsByName("pkskl")) != null){
				selObj[0].checked=true;
				selObj[1].disabled=true;
				kskl_change(selObj);
			}
			return false;
		} else {
			if((selObj = document.getElementsByName("pkskl")) != null){
				selObj[1].disabled=false;
				kskl_change(selObj);
			}
			return false;
		}
	}

	function kskl_change(obj) {
        var len = 1;
        var opt;
		var saved_sqly;
		var saved_sqly_value = "";
        if((saved_sqly = document.getElementById("saved_sqly")) != null){
			saved_sqly_value=saved_sqly.value;
		}
		
		var selObj=document.getElementById("psqly");
		if(selObj != null) {
			if(obj.value=="文史") {
				len = selObj.options.length;
				for(var j=1; j<len; j++){
					selObj.remove(1);
				}
				for(var j=0; j<lyList_0.length; j++){
					opt = new Option();
					opt.text = lyList_0[j].mc;
					opt.value = lyList_0[j].id;
					//alert(saved_sqly_value + ":" + opt.value);
					if(saved_sqly_value==opt.value)
							opt.selected=true;
					selObj.options.add(opt);
				}
			} else {
				len = selObj.options.length;
				for(var j=1; j<len; j++){
					selObj.remove(1);
				}
				for(var j=0; j<lyList_1.length; j++){
					opt = new Option();
					opt.text = lyList_1[j].mc;
					opt.value = lyList_1[j].id;
					//alert(saved_sqly_value + ":" + opt.value);
					if(saved_sqly_value==opt.value)
							opt.selected=true;
					selObj.options.add(opt);
				}
			}
			leiBie_change(selObj);
		} else {
		    alert("页面错误！请与系统管理员联系，谢谢！");
		}
	}
	function leiBie_change(obj) {
		var selObj = null;
		var len = 1;
		var opt;
		var saved_zy;
		var saved_zy_value = "";


		for(var i=1; i<=3; i++) {
			if((selObj=document.getElementById("pzhiyuan"+i)) != null) {
				len = selObj.options.length;
				for(var j=1; j<len; j++){
					selObj.remove(1);
				}
				if((saved_zy = document.getElementById("saved_zyid" + i)) != null){
					saved_zy_value=saved_zy.value;
				}
				
				try {
					for(var j=0; j<eval("zyList_"+ obj.value + ".length"); j++){
						opt = new Option();
						opt.text = eval("zyList_"+ obj.value + "[" + j +"].mc");
						opt.value = eval("zyList_"+ obj.value + "[" + j +"].id");
						//alert(saved_zy_value + ":" + opt.value);
						if(saved_zy_value==opt.value)
     						opt.selected=true;
						selObj.options.add(opt);
					}
				} catch(e) {
				}
			}
		}
	}