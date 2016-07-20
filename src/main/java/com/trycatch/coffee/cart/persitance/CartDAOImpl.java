package com.trycatch.coffee.cart.persitance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.trycatch.coffee.cart.domain.CartDTO;

@Repository
public class CartDAOImpl implements CartDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.trycatch.coffee.mappers.cartMapper";
	@Override
	public List<CartDTO> getCartList(CartDTO cartdto) {
		try{
			return sqlSession.selectList(NAMESPACE+".getCartList", cartdto);
		}
		catch(Exception err){
			err.printStackTrace();
			return null;
		}
	}

	@Override
	public boolean insertCart(CartDTO cartdto) {
		try{
			sqlSession.insert(NAMESPACE+".insertCart", cartdto);
			return true;
		}catch(Exception err){
			return false;			
		}
	}

	@Override
	public boolean checkCart(CartDTO cartdto) {
		try{
			sqlSession.selectOne(NAMESPACE+".getCartList", cartdto);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean updateCart(CartDTO cartdto) {
		try{
			sqlSession.update(NAMESPACE+".updateCart", cartdto);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean deleteCart(CartDTO cartdto) {
		try{ 
			sqlSession.delete(NAMESPACE+".deleteCart", cartdto);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

}
