package com.trycatch.coffee.store.persitance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.xml.stream.events.Namespace;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.core.sym.Name;
import com.trycatch.coffee.member.domain.MemberDTO;
import com.trycatch.coffee.store.domain.StoreDTO;

@Repository
public class StoreDAOImpl implements StoreDAO {
	private static final Logger logger = LoggerFactory.getLogger(StoreDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.storeMapper";
	
	@Override
	public StoreDTO getStore_store_no(int store_no) {
		try {
			return sqlSession.selectOne("getStore_store_no", store_no);
		} catch (Exception err) {
			return null;
		}
	}
	
	@Override
	public List<StoreDTO> getStoreList() {
		try {
			return sqlSession.selectList(NAMESPACE + ".getStoreList");
		} 
		catch (Exception e) {
			return null;
		}
	}
	
	@Override
	public boolean insertStore(StoreDTO dto) {
		try {
			sqlSession.insert(NAMESPACE + ".insertStore", dto);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
	
	@Override
	public boolean updateStore(StoreDTO dto) {
		try {
			sqlSession.update(NAMESPACE + ".updateStore", dto);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
	
	 @Override
	public boolean deleteStore(int store_no) {
		try {
			sqlSession.delete(NAMESPACE + ".deleteStore", store_no);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
	 
	 @Override
	public boolean insertMeetingRoomStore(StoreDTO dto) {
		try {
			sqlSession.insert(NAMESPACE + ".insertMeetingRoomStore", dto);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
	 
	 @Override
	public int getStore_meeting_room(int store_no) {
		try {
			return sqlSession.selectOne(NAMESPACE + ".getStore_meeting_room", store_no);
		} catch (Exception err) {
			return 1;
		}
	}
	 
	 @Override
	public boolean deleteMeetingRoomStore(int store_no) {
		try {
			sqlSession.delete(NAMESPACE + ".deleteMeetingRoomStore", store_no);
			return true;
		} catch (Exception err) {
			return false;
		}
	}
	 
@Override
	public List<StoreDTO> getStoreList_every_column(String search_store_value) {
		try {
			return sqlSession.selectList(NAMESPACE + ".getStoreList_every_column", search_store_value);
		} catch (Exception err) {
			return null;
		}
	}
}
