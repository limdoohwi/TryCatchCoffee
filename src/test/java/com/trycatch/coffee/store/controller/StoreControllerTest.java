package com.trycatch.coffee.store.controller;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trycatch.coffee.store.domain.StoreDTO;
import com.trycatch.coffee.store.persitance.StoreDAO;
import com.trycatch.coffee.store.persitance.StoreDAOImpl;
import com.trycatch.coffee.store.service.StoreService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class StoreControllerTest {
	
	@Autowired
	private StoreDAOImpl dao;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.storeMapper";
	
	@ResponseBody
	public StoreDTO testGetStore(){
		StoreDTO dto = dao.getStore_store_no(3);
		return dto;
	}
	
	@Test
	public void testResponseBody(){
		System.out.println(testGetStore().getMember_no());
	}
	
	@Ignore @Test
	public void testInsertStorePOST() {
		StoreDTO dto = new StoreDTO();
		dto.setStore_name("인천점");
		dto.setStore_addr("인천광역시 계양구 효성2동 현대4차");
		dto.setMember_no(32);
		dto.setMeeting_room(3);
		dto.setStore_ip("192.168.20.46");

		dao.insertStore(dto);
	}

}
