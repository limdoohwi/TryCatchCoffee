package com.trycatch.coffee.cart.persitance;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.trycatch.coffee.cart.domain.CartDTO;

public interface CartDAO {
	public List<CartDTO> getCartList(CartDTO cartdto);
	public boolean checkCart(CartDTO cartdto);
	public boolean insertCart(CartDTO cartdto);
	public boolean updateCart(CartDTO cartdto);
	public boolean deleteCart(CartDTO cartdto);
}
