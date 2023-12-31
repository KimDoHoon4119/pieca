package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import exception.BoardException;
import exception.LoginException;
import logic.User;

public class BoardInterceptor extends HandlerInterceptorAdapter {

   @Override
   public boolean preHandle // /board/write 요청시 => controller.BoardController.write() 호출 전 실행
   (HttpServletRequest request, HttpServletResponse response, Object handler)
         throws Exception {
      HttpSession session = request.getSession();
      String boardid = (String)session.getAttribute("boardid");
      User login = (User)session.getAttribute("loginUser");
      System.out.println("boardid = "+boardid);
      System.out.println("login  = "+login);
      System.out.println(boardid==null);
      if(login==null) {
         String msg = "로그인 유저만 가능합니다.";
         String url = request.getContextPath()+ "/user/login";
         throw new BoardException(msg,url);
      }
      //System.out.println(boardid.equals("1")+"    =    boardid.equals(\"1\")");
      if(boardid == null || boardid.equals("1")) {  //공지사항 글작성
         if(login == null || !login.getUserid().equals("admin")) {  //로그인 정보 확인
            String msg = "관리자만 등록 가능합니다.";
            String url = request.getContextPath()+ "/board/list?boardid=" + boardid;
            throw new BoardException(msg,url);
         }
      }
      /*
      if(boardid.equals("2")) {  //recog / refuse
         if(login == null || !login.getUserid().equals("admin")) {  //로그인 정보 확인
            System.out.println("recog / refuse");
            String msg = "관리자만 승인/거절 가능합니다.";
            String url = request.getContextPath()+ "/board/list?boardid=" + boardid;
            throw new BoardException(msg,url);
         }
      }*/
      return true; //다음 메서드 호출 가능. controller.BoardController.write() 호출
   }
}