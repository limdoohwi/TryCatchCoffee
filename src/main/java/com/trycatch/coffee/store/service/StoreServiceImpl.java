package com.trycatch.coffee.store.service;

import java.beans.Encoder;
import java.net.URLEncoder;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import com.trycatch.coffee.store.domain.StoreDTO;
import com.trycatch.coffee.store.persitance.StoreDAO;

@Service
public class StoreServiceImpl implements StoreService {
	@Inject
	private StoreDAO dao;
	
	@Override
	public StoreDTO getStore_store_no(int store_no) throws Exception {
		return dao.getStore_store_no(store_no);
	}
	
	@Override
	public List<StoreDTO> getStoreList(StoreDTO dto) throws Exception {
		return dao.getStoreList(dto);
	}
	
	@Override
	public List<StoreDTO> getStoreList() throws Exception {
		return dao.getStoreList();
	}
	
	@Override
	public JSONObject getStoreList(boolean isGPSgetStoreList) throws Exception {
		JSONObject jsonRoot = new JSONObject();
		JSONArray jsonArry = new JSONArray();
		List<StoreDTO> list = dao.getStoreList();
		
		for(int i=0; i<list.size(); i++){
			StoreDTO dto = list.get(i);
			JSONObject jsonTemp = new JSONObject();
			jsonTemp.put("store_no", dto.getStore_no());
			jsonTemp.put("store_name", URLEncoder.encode(dto.getStore_name(), "utf-8"));
			jsonTemp.put("store_addr", URLEncoder.encode(dto.getStore_addr(), "utf-8"));
			jsonArry.add(jsonTemp);
		}
		
		jsonRoot.put("StoreAddrList", jsonArry);
		return jsonRoot;
	}
	
	@Override
	public boolean insertStore(StoreDTO dto) throws Exception {
		return dao.insertStore(dto);
	}
	
	
	@Override
	public boolean updateStore(StoreDTO dto) throws Exception {
		int store_no = dto.getStore_no();
		dao.deleteMeetingRoomStore(store_no);
		for(int i=0; i<dto.getMeeting_room(); i++){
			dao.insertMeetingRoomStore(dto);
		}
		return dao.updateStore(dto);
	}
	
	@Override
	public boolean deleteStore(int store_no) throws Exception {
		dao.deleteMeetingRoomStore(store_no);
		return dao.deleteStore(store_no);
	}
	
	@Override
	public boolean insertMeetingRoomStore() throws Exception {
		List<StoreDTO> list = dao.getStoreList();
		StoreDTO dto = list.get(0);
		boolean isSuccessMeetingRoomStore = true;
		int count = dto.getMeeting_room();
		for(int i=0; i<count; i++){
			isSuccessMeetingRoomStore = dao.insertMeetingRoomStore(dto);
			if(isSuccessMeetingRoomStore == false){
				return isSuccessMeetingRoomStore;
			}
		}
		return isSuccessMeetingRoomStore;
	}

	@Override
	public boolean GPSsetStore(int store_no, HttpServletRequest req) throws Exception {
		StoreDTO dto = dao.getStore_store_no(store_no);
		if(dto != null){
			HttpSession session = req.getSession();
			session.setAttribute("store_dto", dto);
			return true;
		}
		return false;
	}
}
