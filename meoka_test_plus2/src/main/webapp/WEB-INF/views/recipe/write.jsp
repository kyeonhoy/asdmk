<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"">
<title>Insert title here</title>
</head>
<!-- jQuery 2.1.4 -->
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<body>
 <style>
.fileDrop {
  width: 80%;
  height: 100px;
  border: 1px dotted gray;
  background-color: lightslategrey;
  margin: auto;
  
}
</style>

	<div id="nav">
		<%@ include file="../include/RecipeNav.jsp"%>
	</div>

	<form method="post">
		<label>작성자</label> <input type="text" name="MEMBERID" /><br /> <label>제목</label>
		<input type="text" name="RECIPENAME" /><br /> <label>조리시간</label> <input
			type="text" name="COOKINGTIME" /><br /> <label>양</label> <input
			type="text" name="PORTION" /><br /> <label>수준</label> <input
			type="text" name="RANKNO" /><br />
			 
			<input type='text' name='recipeDetail[0].RECIPEDETAIL'>
		<div class="form-group">
			<input type="hidden" name='recipeDetail[0].PHOTO'>
			<label for="exampleInputEmail1">File DROP Here</label>
			<div class="fileDrop">
			</div>
			
		</div>
		<div class="mailbox-attachments clearfix uploadedList"></div>
		
<script type="text/javascript" src="/resources/js/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>


<script id="template" type="text/x-handlebars-template">
 <li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</span>
  </div>
   </li>                
</script>    


<script>
	 
	 
var template = Handlebars.compile($("#template").html());

$(".fileDrop").on("dragenter dragover", function(event){
	
	event.preventDefault();
});


$(".fileDrop").on("drop", function(event){
	event.preventDefault();
	
	var files = event.originalEvent.dataTransfer.files;
	
	var file = files[0];

	var formData = new FormData();
	
	formData.append("file", file);	
	
	var $this = $(this);
	$.ajax({
		  url: '/uploadAjax',
		  data: formData,
		  dataType:'text',
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  success: function(data){
			
			  var fileInfo = getFileInfo(data);
			  console.log(fileInfo);
			  
			  var html = template(fileInfo);
			  
			  //console.log(fileInfo.imgsrc);
			  $($this).parent().children(":first").attr("value", fileInfo.imgsrc);
			  $(".uploadedList").append(html);
		  }
		});	 
});



$(".uploadedList").on("click", "small", function(event){
	
		 var that = $(this);
	
	   $.ajax({
		   url:"deleteFile",
		   type:"post",
		   data: {fileName:$(this).attr("data-src")},
		   dataType:"text",
		   success:function(result){
			   if(result == 'deleted'){
				   that.parent("div").remove();
			   }
		   }
	   });
});



</script>		
            

		<script>
			/*
			const add_textbox = () => {
			    const box = document.getElementById("box");
			    const newP = document.createElement('p');
			    newP.innerHTML = "<input type='text'name='recipeDetailNO' placeholder='레시피순서'><input type='text'name='recipeDetail[0]'> <input type='button' value='삭제' onclick='remove(this)'>";
			    box.appendChild(newP);
			}
			const remove = (obj) => {
			    document.getElementById('box').removeChild(obj.parentNode);
			}*/
		</script>

		<div id="box">
			<input type="button" value="추가" onclick="add_textbox()">
		</div>


		<button type="submit">작성</button>
	</form>

</body>
</html>