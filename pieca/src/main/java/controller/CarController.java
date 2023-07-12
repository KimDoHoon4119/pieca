package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Car;
import logic.Carlike;
import logic.Mycar;
import logic.ShopService;
import logic.User;

@Controller // @Component + Controller 기능
@RequestMapping("car") // http://localhost:8080/shop1/item/*
public class CarController {
   @Autowired // ShopService 객체 주입.
   private ShopService service;
   @Autowired
   private Carlike carlike;
   @Autowired
   private Mycar mycar;
   
   @GetMapping("updateForm") // get,post 방식에 상관없이 호출
   public ModelAndView updateForm(int carno,HttpSession session) {
      ModelAndView mav = new ModelAndView();
      Car car = new Car();
      List<Car> carList = service.carList(car);
      for(int i=0; i<carList.size(); i++) {
         if(carList.get(i).getNo()==carno) {
            car = carList.get(i);
         }
      }
      System.out.println(car);
      mav.addObject("car",car);
      return mav;
   }
   
   @GetMapping("pictureForm")
   public ModelAndView pictureForm() {
      ModelAndView mav = new ModelAndView();
      return mav;
   }
   
   @GetMapping("insert") // get,post 방식에 상관없이 호출
   public ModelAndView getinsert(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      Car car = new Car();
      mav.addObject("car",car);
      return mav;
   }
   @PostMapping("insert") // get,post 방식에 상관없이 호출
   public ModelAndView postinsert(@Valid Car car,BindingResult bresult, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
            mav.getModel().putAll(bresult.getModel());
            return mav;
      }
      Car carlist = new Car();
      List<Car> cars = service.carList(carlist);
      int max_no = cars.get(cars.size()-1).getNo()+1;
      car.setNo(max_no);
      service.carInsert(car);
      mav.setViewName("redirect:list");
      return mav;
   }
   
   @PostMapping("updateForm") // get,post 방식에 상관없이 호출
   public ModelAndView update(@Valid Car car, BindingResult bresult, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         mav.addObject("carno",car.getNo());
         return mav;
      }
      service.carUpdate(car);
      mav.setViewName("redirect:list");
      return mav;
   }
   
   @PostMapping("delete") // get,post 방식에 상관없이 호출
   public ModelAndView delete(@Valid Car car, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      service.carDelete(car);
      mav.setViewName("redirect:list");
      return mav;
   }
   
   @RequestMapping("list") // get,post 방식에 상관없이 호출
   public ModelAndView list(String maker,String car_size,String car_type, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      if(maker==null || maker.equals("")) {
         maker = null;
      }
      if(car_size==null || car_size.equals("")) {
         car_size = null;
      }
      if(car_type==null || car_type.equals("")) {
         car_type = null;
      }
      
      Car car = new Car();
      car.setMaker(maker);
      car.setCar_size(car_size);
      car.setCar_type(car_type);
      List<Car> carList = service.carList(car);
      Car car_all = new Car(); 
      List<Car> carList_all = service.carList(car_all);
      mav.addObject("carList_all",carList_all);
      List<Car> carList1 = new ArrayList<>();
      List<Car> carList2 = new ArrayList<>();
      for(int i=0; i<carList.size(); i++) {
         if(i%2 ==0) {
            carList1.add(carList.get(i));
         }else if(i%2 == 1) {
            carList2.add(carList.get(i));
         }
      }
      mav.addObject("carList1",carList1);
      mav.addObject("carList2",carList2);
      
      mav.addObject("maker_selected",maker);
      mav.addObject("car_size_selected",car_size);
      mav.addObject("car_type_selected",car_type);
      if(carList.size()==0) { // carList를 가져오지 못했을때,
      }else{
         //mav.addObject("maker_selected",maker.substring(1));
         //mav.addObject("car_size_selected",car_size.substring(1));
         //mav.addObject("car_type_selected",car_type.substring(1));
      }
      
      
      List<Car> makers = service.getMakers();
      List<Car> car_sizes = service.getSizes();
      List<Car> car_types = service.getTypes();
      
      mav.addObject("makers",makers);
      mav.addObject("car_sizes",car_sizes);
      mav.addObject("car_types",car_types);
      
      User loginUser = (User)session.getAttribute("loginUser");
      
      //ㅎㅇ
      List<Carlike> liked_Total = service.carliketotal();
      mav.addObject("liked_Total", liked_Total);
      
      List<Carlike> rank5_Car = service.select_rank5();
      mav.addObject("rank5_Car", rank5_Car);
      
      
      //ㅎㅇ
      if (session.getAttribute("loginUser") != null) {
         Mycar dbUser = service.selectMycar(loginUser.getUserid());
         List<Carlike> liked_Car = service.selectUserlike(loginUser.getUserid());
            mav.addObject("liked_Car", liked_Car);
            System.out.println("liked_Car : "+liked_Car);
         List<Carlike> carLikeData = service.selectLike(loginUser.getUserid());
          //System.out.println("333 :: "+carLikeData);
         //System.out.println(dbUser);
         int maxnum = carList.size();
         mav.addObject("carList", carList); // 데이터 저장
         mav.addObject("dbUser", dbUser); // 데이터 저장
         mav.addObject("carLikeData", carLikeData); // 데이터 저장
         mav.addObject("maxnum", maxnum); // 데이터 저장
         Mycar mycar = service.selectMycar(loginUser.getUserid());
         mav.addObject("mycar",mycar);
         System.out.println(mycar+"이게 아이디값으로 검색한 mycar");
         return mav;
      } else {
         int maxnum = carList.size();
         mav.addObject("carList", carList); // 데이터 저장
         mav.addObject("maxnum", maxnum); // 데이터 저장
         return mav;
      }
   }
   
   
   
   @RequestMapping("carlike") //좋아요 추가/삭제
   @ResponseBody
   public Boolean carlike(int carno, String userid) {
      carlike.setCarno(carno);
      carlike.setUserid(userid);
      Boolean check = true;

      Carlike dbUser = service.selectUserlike(carlike);
      if (dbUser == null) {
         service.likeInsert(carlike);
         check = false;
         return check;
      }

      if ((dbUser.getUserid().equals(userid)) && (dbUser.getCarno() == carno)) {
         service.likeDelete(carlike);
         check = true;
         return check;
      }

      return check;
   }
   
   @RequestMapping("carlikedec") // 좋아요 판단
   @ResponseBody
   public Boolean carlikedec(int carno, String userid) {
      carlike.setCarno(carno);
      carlike.setUserid(userid);
      Boolean check = null;

      Carlike dbUser = service.selectUserlike(carlike);
      if (dbUser == null) {
         check = false;
         return check;
      } else {
         check = true;
         return check;
      }
   }
   
   @RequestMapping("carliketotal")
   @ResponseBody
   public int carliketotal(int carno) {
      carlike.setCarno(carno);
      
      int total = service.selectliketotal(carlike);
      return total;
   }
   
   @RequestMapping("mycar")
   @ResponseBody
   public int mycar(int carno, String userid) {
      mycar.setUserid(userid);
      mycar.setCarno(carno);
      Mycar dbUser = service.selectMycar(userid);
      
      if (dbUser.getUserid().equals(userid)) {
         service.mycarUpdate(mycar);
         return carno;
      }
      
      return 0;
   }
   
   @RequestMapping("mycardec")
   @ResponseBody
   public int mycardec(int carno, String userid) {
      mycar.setUserid(userid);
      mycar.setCarno(carno);
      Mycar dbUser = service.selectMycar(userid);
      
      if (dbUser.getUserid().equals(userid)) {
         return dbUser.getCarno();
      }
      
      return 0;
   }
}