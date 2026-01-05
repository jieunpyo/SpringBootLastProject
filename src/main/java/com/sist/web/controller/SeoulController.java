package com.sist.web.controller;
import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.web.service.*;
import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;
/*
 * 	 MVC : 오라클 / 컨트롤러 / JSP 
 * 		   --------------- Vue / React 
 * 
 * 		   => SQL / 사용자가 어떤 데이터를 보낼지
 * 
 */
@Controller
@RequiredArgsConstructor
public class SeoulController {
  private final SeoulService sService;
  
  @GetMapping("/seoul/list")
  public String seoul_location(
	@RequestParam(name="page",required = false) String page,
	@RequestParam("cno") int cno,
	Model model
  )
  {
	  // include가 되는 파일을 올린다 => request를 공유할 수 있다 
	  if(page==null)
		  page="1";
	  int curpage=Integer.parseInt(page);
	  Map map=new HashMap();
	  map.put("start", (curpage-1)*12);
	  map.put("contenttype", cno);
	  List<SeoulVO> list=sService.seoulListData(map);
	  int totalpage=sService.seoulTotalPage(cno);
	  final int BLOCK=10;
	  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
	  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
	  
	  if(endPage>totalpage)
		  endPage=totalpage;
	  
	  String name="";
	  if(cno==12) name="서울 관광지";
	  else if(cno==14) name="서울 문화시설";
	  else if(cno==15) name="서울 축제 & 공연";
	  else if(cno==32) name="서울 숙박";
	  else if(cno==38) name="서울 쇼핑";
	  else if(cno==39) name="서울 음식";
	  
	  model.addAttribute("name", name);
	  model.addAttribute("list", list);
	  model.addAttribute("curpage", curpage);
	  model.addAttribute("totalpage", totalpage);
	  model.addAttribute("startPage", startPage);
	  model.addAttribute("endPage", endPage);
	  model.addAttribute("cno", cno);
	  
	  model.addAttribute("main_jsp", "../seoul/list.jsp");
	  return "main/main";
  }
  
}
