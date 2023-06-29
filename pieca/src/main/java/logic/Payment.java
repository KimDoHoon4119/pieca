package logic;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Payment {
	private String orderNo;
	private String userid;
	private String amount;
	private String type;
	private Date regdate;
	private String status;
}
