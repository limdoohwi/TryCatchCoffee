package com.trycatch.coffee.board.recipe.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.trycatch.coffee.board.recipe.domain.BoardRecipeDTO;

import com.trycatch.coffee.board.recipe.service.BoardRecipeService;
import com.trycatch.coffee.member.domain.MemberDTO;

@Controller
public class BoardRecipeController {

	@Inject
	private BoardRecipeService service;

	
	//listAll (GET) 게시글 전체 보기
	@RequestMapping(value="/community.Recipe_List",method=RequestMethod.GET)
	public String ListAllBoardRecipeGET(HttpServletRequest req, Model model, int limit) throws Exception{
		model.addAttribute("recipelistall", service.listAllBoardRecipe());
		if(req.getParameter("limit") != null){
		model.addAttribute("recipelist",service.listAllBoardRecipe(limit));
		}
		else{
		model.addAttribute("recipelist",service.listAllBoardRecipe(0));
		}
		System.out.println(limit);
		return "/community/Recipe_List";
	} 
		
	//insert (GET) 게시글 쓰기 페이지로 이동
	@RequestMapping(value="/community.recipe_insert",method=RequestMethod.GET)
	public String InsertBoardRecipeGET() throws IOException{
		return "/community/Recipe_Insert";
	}
		
	
	//insert (POST) 게시글 올리기
	@RequestMapping(value="/community.recipe_insert",method=RequestMethod.POST)
	public String InsertBoardRecipe_POST(MultipartHttpServletRequest req) throws Exception{
		
		BoardRecipeDTO dto = new BoardRecipeDTO();
		
		dto.setBoard_recipe_content(req.getParameter("board_recipe_content"));
		dto.setBoard_recipe_title(req.getParameter("board_recipe_title"));		 
		MemberDTO mdto = (MemberDTO) (req.getSession().getAttribute("member_dto"));
		String writer = mdto.getMember_name();
		dto.setBoard_recipe_writer(writer);
		 	ServletContext ctx;
			ctx = req.getServletContext();
			Map<String, MultipartFile> files = ((MultipartRequest) req).getFileMap();
			CommonsMultipartFile cmf = (CommonsMultipartFile)files.get("board_recipe_file");
			//경로 
			String path = ctx.getRealPath("resources/video_Upload")+ '/' + cmf.getOriginalFilename();
			File file = new File(path);
			cmf.transferTo(file);

			dto.setBoard_recipe_file(cmf.getOriginalFilename());


		service.insertBoardRecipe(dto);
		
		return "redirect:/community.Recipe_List?limit=0";
		
	}
	
	//search 게시물 검색
	@RequestMapping(value="/community.recipe_search",method=RequestMethod.POST)
	public String SearchBoardRecipe(Model model, String board_recipe_search, int limit) throws Exception{
		System.out.println(board_recipe_search);
		System.out.println(limit);
		model.addAttribute("recipelist", service.searchBoardRecipe(board_recipe_search,limit));
		return "/community/Recipe_List";
	}
	
	
	//read (GET) 게시글 읽기
	@RequestMapping("/community.recipe_read")
	public String ReadBoardRecipe(int board_recipe_no , Model model,HttpServletRequest req) throws Exception{
		
		MemberDTO mdto = (MemberDTO) (req.getSession().getAttribute("member_dto"));
		service.updateBoardRecipeCount(board_recipe_no);
		model.addAttribute(service.readBoardRecipe(board_recipe_no));
		return "/community/Recipe_Read";
	}
	
	//modify (GET) 게시글 수정 페이지로 이동
	@RequestMapping(value="/community.recipe_modify",method=RequestMethod.GET)
	public String ModifyBoardRecipeGET(int board_recipe_no ,Model model) throws Exception{
		model.addAttribute(service.readBoardRecipe(board_recipe_no));
		return "/community/Recipe_Modify";
	}
	
	//modify (POST) 게시글 수정 후 해당하는 게시글 보기
	@RequestMapping(value="/community.recipe_modify",method=RequestMethod.POST)
	public String ModifyBoardRecipePOST(int board_recipe_no,BoardRecipeDTO dto) throws Exception{
		service.updateBoardRecipe(dto);
		return "redirect:/community.recipe_read?board_recipe_no="+board_recipe_no;
	}
	
	//delete  게시글 삭제
	@RequestMapping("/communty.recipe_delete")
	public String ModifyBoardDelete(int board_recipe_no) throws Exception{
		service.deleteBoardRecipe(board_recipe_no);
		return "redirect:/community.Recipe_List?limit=0";
	}
	
	//조회수 update
	public String UpdateBoardLikes(int board_recipe_no) throws Exception{
		service.updateBoardRecipeLikes(board_recipe_no);
		return "redirect:/community.recipe_read?board_recipe_no="+board_recipe_no;
	}
	
	
	
	
	//다중사진업로드
	@RequestMapping("/multiplePhotoUpload")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response){
	    try {
	         String sFileInfo = "";
	         String filename = request.getHeader("file-name");
	         String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
	         filename_ext = filename_ext.toLowerCase();
	         String dftFilePath = request.getSession().getServletContext().getRealPath("/");
	         String filePath = dftFilePath +"resources" + File.separator + "photo_upload" + File.separator;
	         File file = new File(filePath);
	         if(!file.exists()) {
	            file.mkdirs();
	         }
	         String realFileNm = "";
	         SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	         String today= formatter.format(new java.util.Date());
	         realFileNm = today+UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
	         String rlFileNm = filePath + realFileNm;

	         InputStream is = request.getInputStream();
	         OutputStream os=new FileOutputStream(rlFileNm);
	         int numRead;
	         byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
	         while((numRead = is.read(b,0,b.length)) != -1){
	            os.write(b,0,numRead);
	         }
	         if(is != null) {
	            is.close();
	         }
	         os.flush();
	         os.close();

	         sFileInfo += "&bNewLine=true";
	         sFileInfo += "&sFileName="+ filename;;
	         sFileInfo += "&sFileURL="+"/resources/photo_upload/"+realFileNm;
	         PrintWriter print = response.getWriter();
	         print.print(sFileInfo);
	         print.flush();
	         print.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	   
	}
		
}
