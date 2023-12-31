package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CarlikeMapper;
import logic.Car;
import logic.Carlike;
@Repository // @Component + dao 기능(데이터베이스연결)
public class CarlikeDao {
   
   @Autowired
   private SqlSessionTemplate template; //org.mybatis.spring.SqlSessionTemplate 객체 주입
   private Map<String, Object> param = new HashMap<>();
   private final Class<CarlikeMapper> cls = CarlikeMapper.class;
   
   public Carlike select(Carlike carlike) {
      return template.getMapper(cls).select(carlike);
   }

   public void insert(Carlike carlike) {
      template.getMapper(cls).insert(carlike);
   }

   public void delete(Carlike carlike) {
      template.getMapper(cls).delete(carlike);
   }

   public int selectliketotal(Carlike carlike) {
      return template.getMapper(cls).selectliketotal(carlike);
   }

   public List<Carlike> selectliketotal() {
         return template.getMapper(cls).selectliketotal2();
      }
   
   public List<Carlike> selectLike(String userid) {
      return template.getMapper(cls).selectLike(userid);
   }

   public List<Carlike> select_rank5() {
      return template.getMapper(cls).select_rank5();
   }

public List<Car> getMakers() {
   return template.getMapper(cls).getMakers();
}
public List<Car> getSizes() {
   return template.getMapper(cls).getSizes();
}
public List<Car> getTypes() {
   return template.getMapper(cls).getTypes();
}
   






}