package com.trycatch.coffee.store.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.member.service.MemberService;
import com.trycatch.coffee.store.service.StoreService;

@Controller
public class DeleteStoreController {
	@Inject
	private StoreService service;
	
	private static final Logger logger = LoggerFactory.getLogger(DeleteStoreController.class);
	
	@RequestMapping(value="/delete.store.manager", method=RequestMethod.POST)
	@ResponseBody
	public boolean deleteStorePOST(int store_no) throws Exception{
		boolean isSuccessDeleteStore = service.deleteStore(store_no);
		return isSuccessDeleteStore;
	}
}
