package logic;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component
@RequiredArgsConstructor
@Getter
@Setter
@ToString
public class Payment {
	private String orderno;
	private String userid;
	private String amount;
	private String type;
	private Date regdate;
	private String status;
}
