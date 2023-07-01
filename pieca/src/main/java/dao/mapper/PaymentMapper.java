package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Payment;

public interface PaymentMapper {
	@Insert("insert into payment (orderno,userid,amount,"
			+ " type,regdate,status) values " 
			+ " (#{orderno},#{userid},#{amount},"
			+ " #{type},now(),#{status})")
	void insert(Payment payment);
	
	@Select("select sum(amount) from payment where userid =#{userid}")
	String selectBalance(String userid);

}
