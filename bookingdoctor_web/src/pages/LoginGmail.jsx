import React, { useState, useEffect } from 'react';
import bg_login from '../../public/images/image-login.png';
import { motion } from 'framer-motion';
import { Link } from 'react-router-dom';

const LoginGmail = () => {

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
                                {/* <h5 className='mb-3 text-black-50'>Step 1: Nhập gmail để nhận mã xác thực</h5> */}
                                    <form>
                                        <input type="hidden" name="provider" value="gmail" />
                                        <div className="mb-3">
                                            <input type="gmail" className="input__username" id="input__phone" placeholder="Enter your gmail" />
                                        </div>
                                        <div className="mb-4">
                                            <motion.div whileTap={{ scale: 0.8 }}>
                                                <button type='submit' className='btn__submit'>Login</button>
                                            </motion.div>
                                        </div>
                                    </form>
                                </div>

                                <div className='mt-xl-5'>
                                    <p>Quay về trang login. <Link to="/login" className='text-decoration-none ms-2'>Back to login</Link></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           
        </>
    )
}

export default LoginGmail