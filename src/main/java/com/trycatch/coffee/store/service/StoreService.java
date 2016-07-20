package com.trycatch.coffee.store.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.trycatch.coffee.store.domain.StoreDTO;

public interface StoreService {
	public StoreDTO getStore_store_no(int store_no) throws Exception;
	public List<StoreDTO> getStoreList() throws Exception;
	public List<StoreDTO> getStoreList(StoreDTO dto) throws Exception;
	public JSONObject getStoreList(boolean isGPSgetStoreList) throws Exception;
	public boolean insertStore(StoreDTO dto) throws Exception;
	public boolean updateStore(StoreDTO dto) throws Exception;
	public boolean deleteStore(int store_no) throws Exception;
	public boolean insertMeetingRoomStore() throws Exception;	
	public boolean GPSsetStore(int store_no, HttpServletRequest req) throws Exception;
}
