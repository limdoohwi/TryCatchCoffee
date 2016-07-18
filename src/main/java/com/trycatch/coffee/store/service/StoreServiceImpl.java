package com.trycatch.coffee.store.service;

import java.util.List;

import javax.inject.Inject;

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
	public List<StoreDTO> getStoreList() throws Exception {
		return dao.getStoreList();
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
	public List<StoreDTO> getStoreList_every_column(String search_store_value) throws Exception {
		return dao.getStoreList_every_column(search_store_value);
	}
}
