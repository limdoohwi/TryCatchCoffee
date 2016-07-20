package com.trycatch.coffee.cart.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.trycatch.coffee.cart.domain.CartDTO;
import com.trycatch.coffee.cart.persitance.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	@Inject
	private CartDAO cartdao;
	@Override
	public List<CartDTO> getCartList(CartDTO cartdto) {
		return cartdao.getCartList(cartdto);
	}

	@Override
	public boolean insertCart(CartDTO cartdto) {
		return cartdao.insertCart(cartdto);
	}

	@Override
	public boolean checkCart(CartDTO cartdto) {
		return cartdao.checkCart(cartdto);
	}

	@Override
	public boolean updateCart(CartDTO cartdto) {
		return cartdao.updateCart(cartdto);
	}

	@Override
	public boolean deleteCart(CartDTO cartdto) {
		return cartdao.deleteCart(cartdto);
	}

}
