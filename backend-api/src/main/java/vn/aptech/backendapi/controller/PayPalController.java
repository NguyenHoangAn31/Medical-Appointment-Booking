// package vn.aptech.backendapi.controller;


// import com.paypal.api.payments.Links;
// import com.paypal.api.payments.Payment;
// import com.paypal.base.rest.PayPalRESTException;
// import jakarta.servlet.http.HttpServletRequest;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.web.bind.annotation.*;
// import vn.aptech.backendapi.service.Auth.PaypalService;

// @RestController
// @RequestMapping("/paypal")
// public class PayPalController {

//     @Autowired
//     private PaypalService paypalService;

//     @PostMapping("/pay")
//     public String pay(@RequestParam("sum") double sum, HttpServletRequest request) {
//         String cancelUrl = "http://localhost:8080/paypal/cancel";
//         String successUrl = "http://localhost:8080/paypal/success";
//         try {
//             Payment payment = paypalService.createPayment(
//                     sum,
//                     "USD",  
//                     "paypal",
//                     "sale",
//                     "Payment description",
//                     cancelUrl,
//                     successUrl);
//             for (Links link : payment.getLinks()) {
//                 if (link.getRel().equals("approval_url")) {
//                     return link.getHref();
//                 }
//             }
//         } catch (PayPalRESTException e) {
//             e.printStackTrace();
//         }
//         return "redirect:/";
//     }

//     @GetMapping("/success")
//     public String successPay(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId) {
//         try {
//             Payment payment = paypalService.executePayment(paymentId, payerId);
//             if (payment.getState().equals("approved")) {
//                 return "Payment success";
//             }
//         } catch (PayPalRESTException e) {
//             e.printStackTrace();
//         }
//         return "redirect:/";
//     }

//     @GetMapping("/cancel")
//     public String cancelPay() {
//         return "Payment canceled";
//     }
// }
