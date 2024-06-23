import React, { useState, useEffect, useContext } from 'react';

import { useNavigate } from 'react-router-dom';
import bg_login from '../../public/images/image-login.png';
import { motion } from 'framer-motion';
import { auth } from "../services/auth/firebase.config";
import { RecaptchaVerifier, signInWithPhoneNumber, signOut } from "firebase/auth";
import { toast } from "react-hot-toast";
import axios from 'axios';
import ecryptToken from '../ultils/encrypt';
import getUserData from '../route/CheckRouters/token/Token';

import PhoneInput from "react-phone-input-2";
import "react-phone-input-2/lib/style.css";
import { UserContext } from '../components/Layouts/Client';

//import { toast, Toaster } from "react-hot-toast";

const LoginPhone = () => {
    const {currentUser,setCurrentUser } = useContext(UserContext);
    const [username, setUsername] = useState('');
    const [loading, setLoading] = useState(false);
    const provider = 'phone';
    const currentPath = localStorage.getItem('currentPath');
    const navigateTo = useNavigate();



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


    const handleSendOtp = async (event) => {
        event.preventDefault()
        const data = {
            username: username,
            provider: provider
        }
        
        try {
            const result = await axios.post('http://localhost:8080/api/auth/check-account', data);
            if(result.data){
               console.log('Xử lý send-otp');
                try {
                        const result = await axios.post('http://localhost:8080/api/auth/send-otp', data);
                        
                        if (result.data) {
                            console.log('Bắt đầu gửi mã OTP');
                            onCaptchVerify();
                            const appVerifier = window.recaptchaVerifier;
                            const formatPh = "+84" + username.slice(1);
                            console.log(formatPh);
                            signInWithPhoneNumber(auth, formatPh, appVerifier)
                                .then((confirmationResult) => {
                                    window.confirmationResult = confirmationResult;
                                    setLoading(false);
                                    toast.success("OTP sended successfully!", {
                                        position: "top-right"
                                    });
                                    navigateTo(`/login-by-phone-submit?username=${data.username}`);
                                })
                                .catch((error) => {
                                    setLoading(false);
                                });
                        } else {
                            console.log('Check Refresh token');
                            const checkToken = await axios.post('http://localhost:8080/api/auth/check-refresh-token', data);
                            console.log("token : ", checkToken.data.accessToken);
                            if (checkToken.data.accessToken != null) {
                                localStorage.setItem('Token', ecryptToken.encryptToken(JSON.stringify(checkToken.data)));
                                if(checkToken.data.user.roles[0]=='USER'){
                                    setCurrentUser(checkToken.data)
                                }
                                if (getUserData().user.roles[0] == 'USER') {
                                    navigateTo(`/`);
                                }
                                else if (getUserData().user.roles[0] == 'DOCTOR') {
                                    navigateTo(`/dashboard/doctor`);
                                }
                                else if (getUserData().user.roles[0] == 'ADMIN') {
                                    navigateTo(`/dashboard/admin`);
                                }
            
                            } 
                        }
            
                    } catch (error) {
                        console.log(error)
                    }
            }else{
                toast.error("User not found or please try again with gmail!", {
                    position: "bottom-right"
                });
            }
        } catch (error) {
            
        }
        
    };

    return (
        <>
            {/* <div className='float-end'><Toaster toastOptions={{ duration: 4000 }} /></div> */}
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
                                    <form onSubmit={handleSendOtp}>
                                        <div className="mb-3">
                                            <input
                                                className="input__username"
                                                id="input__phone"
                                                placeholder="Enter your phone: +84123456789"
                                                value={username}
                                                onChange={(e) => setUsername(e.target.value)}
                                            />
                                            {/* <PhoneInput country={"vn"} value={username} onChange={(e) => setUsername(e.target.value)} /> */}
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

export default LoginPhone