package com.trycatch.coffee.main.controller;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.trycatch.coffee.meeting_room.persitance.MeetingRoomDAOImpl;
import com.trycatch.coffee.store.service.StoreService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Inject
	private StoreService storeService;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "Main";
	}
	
	/**
	 * @author 김준혁
	 * GPS 지오코딩을 통해 최단 거리의 매장을 구한 후 해당 매장을 세션에 저장
	 */
	@RequestMapping(value="/gps.set_store.main", method=RequestMethod.POST)
	public void GPSsetStorePOST(int store_no, HttpServletRequest req, HttpServletResponse resp) throws Exception{
		PrintWriter out = resp.getWriter();
		out.println(storeService.GPSsetStore(store_no, req));
	}
}
