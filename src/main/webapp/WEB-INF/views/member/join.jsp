<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
 .row{
  margin: 0px auto;
  width: 900px;
} 
</style>
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(/img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>회원가입</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="breadcumb-nav">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <%-- 검색기 --%>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ****** Breadcumb Area End ****** -->

    <!-- ****** Archive Area Start ****** -->
    <section class="archive-area section_padding_80" id="join_section">
        <div class="container" style="max-width: 800px; margin-top: 40px;">
            
             <div class="panel panel-pastel">
			    <div class="panel-heading text-center">
			      <span class="glyphicon glyphicon-leaf"></span>
			    </div>
			    <div class="panel-body">
			     <form id="frm" name="frm" method="post" action="/member/join_ok">
			      <table class="table table-bordered table-hover">
			        <tr>
			          <th class="text-center" width="20%">ID</th>
			          <td>
			            <div class="form-inline">
			              <input type="text" name="userid" ref="id" class="form-control input-sm" placeholder="아이디"
			                v-model="id"
			              >
			              <button type="button" class="btn btn-mint btn-sm">중복체크</button>
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">Password</th>
			          <td>
			            <div class="form-inline">
			              <input type="password" v-model="pwd" name="userpwd" ref="pwd1" class="form-control input-sm" placeholder="비밀번호">
			              <input type="password" v-model="pwd1" name="pwd1" ref="pwd2" class="form-control input-sm" placeholder="비밀번호 재입력">
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">이름</th>
			          <td><input type="text" name="username" ref="name" v-model="name" class="form-control input-sm" placeholder="이름 입력"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">성별</th>
			          <td>
			            <label class="radio-inline"><input type="radio" name="sex" value="남자" checked> 남자</label>
			            <label class="radio-inline"><input type="radio" name="sex" value="여자"> 여자</label>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">생년월일</th>
			          <td><input type="date" name="birthday"  ref="birthday" class="form-control input-sm"
			          v-model="birthday"
			          ></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">이메일</th>
			          <td><input type="text" name="email" class="form-control input-sm" placeholder="example@email.com"
						  v-model="email"			          
			          ></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">우편번호</th>
			          <td>
			            <div class="form-inline">
			              <input type="text" ref="post" name="post" class="form-control input-sm" readonly
			                v-model="post"
			              >
			              <button type="button" @click="postFind()" class="btn btn-pink btn-sm">우편번호검색</button>
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">주소</th>
			          <td><input type="text" ref="addr1" name="addr1" class="form-control input-sm" readonly
			           v-model="addr1"
			          ></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">상세주소</th>
			          <td><input type="text" name="addr2" class="form-control input-sm"
			           v-model="addr2"
			          ></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">전화번호</th>
			          <td>
			            <div class="form-inline">
			              <select name="phone1" class="form-control input-sm" v-model="phone1">
			                <option>010</option>
			                <option>011</option>
			                <option>016</option>
			              </select>
			              <input type="text" name="phone2" v-model="phone2" class="form-control input-sm" placeholder="####-####">
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">소개</th>
			          <td><textarea rows="5" name="content" class="form-control input-sm" placeholder="자기소개를 입력하세요"
			            v-model="content"
			          ></textarea></td>
			        </tr>
			
			        <tr>
			          <td colspan="2" class="text-center">
			            <button type="button" class="btn btn-mint btn-sm" id="joinBtn">회원가입</button>
			            <button type="button" class="btn btn-pink btn-sm" onclick="history.back()">취소</button>
			          </td>
			        </tr>
			      </table>
			      </form>
			    </div>
			  </div>
            </div>
        
    </section>
	<script>
	 let joinApp=Vue.createApp({
		 data(){
			 return {
				 post:'',
				 addr1:''
			 }
		 },
		 methods:{
			 // idcheck
			 
			 postFind(){
				 let _this=this
				 new daum.Postcode({
					 oncomplete:function(data)
					 {
						 _this.post=data.zonecode
						 _this.addr1=data.address
					 }
				 }).open()
			 }
			 // join 
		 }
	 })
	 joinApp.mount("#join_section")
	</script>
</body>
</html>