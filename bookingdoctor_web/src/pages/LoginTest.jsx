import React, { useState, useEffect } from 'react';
// import { auth } from "../services/auth/firebase.config";
import { RecaptchaVerifier, signInWithPhoneNumber } from "firebase/auth";

import { useNavigate } from 'react-router-dom';
import bg_login from '../../public/images/image-login.png';
import { motion } from 'framer-motion';
import axios from 'axios';


const LoginTest = () => {

  const [otp, setOtp] = useState("");
  const [username, setUsername] = useState("");
  const [loading, setLoading] = useState(false);
  const [showOTP, setShowOTP] = useState(false);
  const [user, setUser] = useState(null);

  //console.log(username.slice(1));
  function onCaptchVerify() {
    if (!window.recaptchaVerifier) {
      window.recaptchaVerifier = new RecaptchaVerifier(auth,
        "recaptcha-container",
        {
          size: "invisible",
          callback: () => {
            console.log('recaptcha resolved..')
          }
        }
      );
    }
  }

  function onSignup(e) {
    e.preventDefault();

    setLoading(true);
    onCaptchVerify();

    const appVerifier = window.recaptchaVerifier;
    const formatPh = "+84" + username.slice(1);
    console.log(formatPh);
    signInWithPhoneNumber(auth, formatPh, appVerifier)
      .then((confirmationResult) => {
        window.confirmationResult = confirmationResult;
        setLoading(false);
        setShowOTP(true);
        //toast.success("OTP sended successfully!");
      })
      .catch((error) => {
        console.log(error);
        setLoading(false);
      });
  }

  return (
    <>
      <div className='container mt-5'>
        <div className="row">
          <div className="col-md-6">
            <div className="col-12">
              <img src={bg_login} alt="" className='img-fluid' />
            </div>
          </div>
          <div className="col-md-1"></div>
          <div className='col-md-5'>
            <div className="col-12">
              <div className="text-center justify-content-center px-5 mt-xxl-5">
                <h3 className='login__title'>Login</h3>
                <h5 className='login__title_sup'>Booking appointment</h5>
                <div className='py-5 border-top border-dark border-2 mt-3'>
                  {/* <h5 className='mb-3 text-black-50'>Step 1: Nhập số điện thoại</h5> */}
                  <div id="recaptcha-container"></div>
                  <form onClick={onSignup}>
                    {/* <input type="hidden" name="provider" value="phone" /> */}
                    <div className="mb-3">
                      <input
                        className="input__username"
                        id="input__phone"
                        placeholder="Enter your phone: +84123456789"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                      />
                    </div>
                    <div className="mb-4">
                      <motion.div whileTap={{ scale: 0.8 }}>
                        <button type='submit' className='btn__submit'>Login</button>
                      </motion.div>
                    </div>
                  </form>

                </div>

                <div className='mt-xl-5'>

                  <p>Quay về trang login. <a hrefh="/login" className='text-decoration-none ms-2'>Back to login</a></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </>
  )
}

export default LoginTest