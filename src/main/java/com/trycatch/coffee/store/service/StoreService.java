package com.trycatch.coffee.store.service;

import java.util.List;
import com.trycatch.coffee.store.domain.StoreDTO;

public interface StoreService {
	public StoreDTO getStore_store_no(int store_no) throws Exception;
	public List<StoreDTO> getStoreList() throws Exception;
	public List<StoreDTO> getStoreList_every_column(String search_store_value) throws Exception;
	public boolean insertStore(StoreDTO dto) throws Exception;
	public boolean updateStore(StoreDTO dto) throws Exception;
	public boolean deleteStore(int store_no) throws Exception;
	public boolean insertMeetingRoomStore() throws Exception;	
}
