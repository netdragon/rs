﻿
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
	
 
		var bk_obj1=document.getElementById("pzhiyuan1");	
		var bk_obj2=document.getElementById("pzhiyuan2");
		var bk_obj3=document.getElementById("pzhiyuan3");	
		var bk_obj4=document.getElementById("pzhiyuan4");
		var bk_obj5=document.getElementById("pzhiyuan5");	
		var bk_obj6=document.getElementById("pzhiyuan6");
		var bk_obj7=document.getElementById("pzhiyuan7");	
		var bk_obj8=document.getElementById("pzhiyuan8");
		
		var bk1 = (null == bk_obj1) ? "" : bk_obj1.value;
		var bk2 = (null == bk_obj2) ? "" : bk_obj2.value;
		var bk3 = (null == bk_obj3) ? "" : bk_obj3.value;
		var bk4 = (null == bk_obj4) ? "" : bk_obj4.value;
		var bk5 = (null == bk_obj5) ? "" : bk_obj5.value;
		var bk6 = (null == bk_obj6) ? "" : bk_obj6.value;
		var bk7 = (null == bk_obj7) ? "" : bk_obj7.value;
		var bk8 = (null == bk_obj8) ? "" : bk_obj8.value;
		
		if(bk1 == bk2 || bk1==bk3 || bk1==bk4 || bk1==bk5 || bk1==bk6 
			|| bk1==bk7 || bk1==bk8) {
			if(bk1!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}
		if(bk2==bk3 || bk2==bk4 || bk2==bk5 ||
			bk2==bk6 || bk2==bk7 || bk2==bk8 ) {
			if(bk2!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}
		if(bk3==bk4 || bk3==bk5 || bk3==bk6 || bk3==bk7 || bk3==bk8) {
			if(bk3!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}
		if(bk4==bk5 || bk4==bk6 || bk4==bk7 || bk4==bk8) {
			if(bk4!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}
		if(bk5==bk6 || bk5==bk7 || bk5==bk8) {
			if(bk5!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}
		if(bk6==bk7 || bk6==bk8) {
			if(bk6!="0") {
				alert("报考志愿中不能选择相同专业。请确认！");
				return false;
			}
		}
		if( bk7!="0" && bk7==bk8) {
			alert("报考志愿中不能选择相同专业。请确认！");
			return false;
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
		var selObj = null;
		var len = 1;
		var opt;
		var saved_zyid_value="0";
		var saved_zy;

		for(var i=1; i<=8; i++) {
			if(obj.value=="文史") {
				if((selObj=document.getElementById("pzhiyuan"+i)) != null) {
					len = selObj.options.length;
					for(var j=1; j<len; j++){
						selObj.remove(1);
					}
					if((saved_zy = document.getElementById("saved_zyid"+i)) != null){
						saved_zyid_value=saved_zy.value;
					}
					for(var j=0; j<zyList_wk.length; j++){
						opt = new Option();
						opt.text = zyList_wk[j];
						opt.value = zyList_wk_id[j];
						if(saved_zyid_value==zyList_wk_id[j])
							opt.selected=true;
						selObj.options.add(opt);
					}
				}
			} else {
				if((selObj=document.getElementById("pzhiyuan"+i)) != null) {
					len = selObj.options.length;
					for(var j=1; j<len; j++){
						selObj.remove(1);
					}
					if((saved_zy = document.getElementById("saved_zyid"+i)) != null){
						saved_zyid_value=saved_zy.value;
					}
					for(var j=0; j<zyList_lk.length; j++){
						opt = new Option();
						opt.text = zyList_lk[j];
						opt.value = zyList_lk_id[j];
						if(saved_zyid_value==zyList_lk_id[j]) {
							opt.selected=true;
						}
						selObj.options.add(opt);
					}
				}
			}
		}
	}