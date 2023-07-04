package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Carlike;
import logic.User;

public interface CarlikeMapper {

	@Select("select * from carlike where userid=#{userid} and carno=#{carno}")
	Carlike select(Carlike carlike);

	@Insert("insert into carlike (userid, carno) values (#{userid}, #{carno})")
	void insert(Carlike carlike);
	
	@Delete("delete from carlike where userid=#{userid} and carno=#{carno}")
	void delete(Carlike carlike);
}
