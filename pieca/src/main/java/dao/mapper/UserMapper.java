package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {
   @Insert("insert into usersecurity (userid,username,password,"
         + " birthday,phoneno,email,channel,card) values " 
         + " (#{userid},#{username},#{password},"
         + " #{birthday},#{phoneno},#{email},#{channel},#{card})")
   void insert(User user);

   @Select({"<script>",
        "select * from usersecurity ",
        "<if test='userid != null'> where userid=#{userid}</if>",
        "<if test='userids != null'> where userid in "
        + "<foreach collection='userids' item='id' separator=',' open='(' close=')'>#{id}"
        + "</foreach></if>",
        "</script>"})
   List<User> select(Map<String,Object> param);
   
   @Select({"<script>",
      "select * from usersecurity ",
      "</script>"})
   List<User> select_all();

   @Update("update usersecurity set username=#{username},"
         + "birthday=#{birthday},phoneno=#{phoneno},"
         + "email=#{email} where userid=#{userid}")
   void update(User user);

   @Delete("delete from usersecurity where userid=#{userid}")
   void delete(Map<String, Object> param);

   @Update("update usersecurity set password=#{password} where userid=#{userid}")
   void chgpass(Map<String, Object> param);

   @Select({"<script>",
      "select ${col} from usersecurity where email=#{email} and phoneno=#{phoneno}"
      + "<if test='userid != null'> and userid=#{userid}</if>",
      "</script>"})
   String search(Map<String, Object> param);

   @Select("select * from usersecurity where phoneno = #{phoneno} and channel=#{channel}")
   List<User> phoneList(Map<String, Object> param);
   
   @Select("select * from usersecurity where userid = #{userid}")
   User selectId(String userid);
   
   @Update("update usersecurity set card='y' where userid=#{userid}")
   void setcard(User user);
}