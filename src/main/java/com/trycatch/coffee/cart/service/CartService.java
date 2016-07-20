package com.trycatch.coffee.cart.service;

import java.util.List;

import com.trycatch.coffee.cart.domain.CartDTO;

public interface CartService {
	public List<CartDTO> getCartList(CartDTO cartdto);
	public boolean checkCart(CartDTO cartdto);
	public boolean insertCart(CartDTO cartdto);
	public boolean updateCart(CartDTO cartdto);
	public boolean deleteCart(CartDTO cartdto);
}
