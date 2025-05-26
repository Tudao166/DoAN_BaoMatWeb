package com.webshoes.helper;

public class MailMessenger {

	public static void successfullyRegister(String userName, String userEmail) {

		String subject = "Chào mừng bạn đến với Web Shoes - Đăng ký thành công!";
		String body = "Xin chào " + userName
				+ ",<p>Xin chúc mừng và chào mừng nồng nhiệt đến với Web Shoes! Chúng tôi rất vui mừng khi có bạn là một phần của cộng đồng đang phát triển của chúng tôi. Cảm ơn bạn đã chọn chúng tôi cho nhu cầu mua sắm trực tuyến của bạn.</p>"
				+ "<p>Đăng ký của bạn đã thành công và chúng tôi vui mừng thông báo với bạn rằng bạn hiện là thành viên quan trọng trên nền tảng của chúng tôi. Với Web Shoes, bạn sẽ khám phá nhiều lựa chọn sản phẩm và ưu đãi thú vị phù hợp với sở thích và sở thích của bạn."
				+ "<p>Một lần nữa, chào mừng bạn lên tàu! Chúng tôi mong muốn được phục vụ bạn và làm cho trải nghiệm mua sắm của bạn trở nên thú vị và bổ ích.</p>"
				+ "<p>Chúc bạn mua sắm vui vẻ!</p>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void successfullyOrderPlaced(String userName, String userEmail, String orderId, String OrderDate) {
		String subject = "Xác nhận đơn hàng - Sản phẩm của bạn đã được xác nhận!";
		String body = "Xin chào " + userName
				+ ",<p>Chúng tôi vui mừng thông báo với bạn rằng đơn hàng của bạn đã được đặt thành công và hiện đang được xử lý. Cảm ơn bạn đã lựa chọn Web Shoes cho nhu cầu mua sắm của mình!</p>"
				+ "<p>Chi tiết đơn hàng: <br>" + "Mã số đơn hàng: " + orderId + "<br>Ngày đặt hàng: " + OrderDate + "</p>"
				+ "<p>Xin lưu ý rằng đơn đặt hàng của bạn hiện đang được chuẩn bị để vận chuyển. Đội ngũ tận tâm của chúng tôi đang làm việc chăm chỉ để đảm bảo rằng sản phẩm của bạn được đóng gói an toàn và gửi đi sớm nhất.</p>"
				+ "<p>Sau khi đơn đặt hàng của bạn được chuyển đi, chúng tôi sẽ gửi cho bạn một email khác chứa thông tin theo dõi chi tiết, cho phép bạn theo dõi hành trình của đơn hàng cho đến khi hàng đến tận nhà bạn. Chúng tôi hiểu cảm giác thú vị như thế nào khi nhận được một gói hàng và chúng tôi sẽ cố gắng hết sức để giao nó cho bạn sớm nhất có thể.</p>"
				+ "<p>Cảm ơn bạn đã mua sắm với chúng tôi! Sự tin tưởng của bạn vào <b>Web Shoes</b> có ý nghĩa rất lớn đối với chúng tôi và chúng tôi hứa sẽ mang đến cho bạn trải nghiệm mua sắm đặc biệt.</p>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void orderShipped(String userName, String userEmail, String orderId, String OrderDate) {
		String subject = "Đơn hàng của bạn đã sẵn sàng để giao hàng!";
		String body = "Xin chào " + userName
				+ "<p>Lời chào từ <b>Web Shoes</b>! Chúng tôi vui mừng thông báo với bạn rằng đơn hàng của bạn đang trên đường đến tay bạn. Gói hàng của bạn đã được vận chuyển thành công và sẽ sớm đến trước cửa nhà bạn!</p>"
				+ "<p>Chi tiết đặt hàng: <br>" + "Mã số đơn hàng: " + orderId + "<br>Ngày đặt hàng: " + OrderDate + "</p>"
				+ "<p>Đội ngũ tận tâm của chúng tôi đã xử lý và đóng gói cẩn thận đơn đặt hàng của bạn để đảm bảo rằng nó đến tay bạn trong tình trạng hoàn hảo. Vì sắp giao hàng, đối tác giao hàng đáng tin cậy của chúng tôi cam kết mang gói hàng đến cho bạn nhanh nhất có thể.</p>"
				+ "<p>Một lần nữa chúng tôi đánh giá cao sự tin tưởng của bạn đối với <b>Web Shoes</b> cho nhu cầu mua sắm của bạn. Chúng tôi mong muốn mang đến cho bạn trải nghiệm mua sắm vượt trội và sự hài lòng của bạn là ưu tiên hàng đầu của chúng tôi.</p>"
				+ "<p>Cảm ơn bạn đã lựa chọn chúng tôi!</p>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void sendOtp(String userEmail, int code) {
		String subject = "Mã xác nhận thay đổi mật khẩu";
		String body = "Xin chào, " + "<p>Vui lòng sử dụng mã xác minh bên dưới để đặt lại mật khẩu của bạn!</p>" + "<h3>" + code
				+ "</h3>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
