import React, { useState, useEffect } from 'react';

import {useNavigate} from 'react-router-dom'; 
import bg_login from '../../public/images/image-login.png';
import { motion } from 'framer-motion';
import axios from 'axios';

//import * as authService from '../../src/services/API/authService';

const LoginPhone = () => {

    const [username, setUsername] = useState('');
    const provider ='phone';
    
    const navigateTo  = useNavigate();

    const handleSendOtp = async (event) => {
        event.preventDefault()
        const data = {
            username: username,
            provider: provider
        }     
        try {

            const result =  await axios.post('http://localhost:8080/api/auth/send-otp', data);              
            if(result && result.data){
                navigateTo(`/login-by-phone-submit?username=${username}`);
            }

        } catch (error) {

        }
    };

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

                                    <form onClick={handleSendOtp}>
                                        <input type="hidden" name="provider" value="phone" />
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

export default LoginPhone