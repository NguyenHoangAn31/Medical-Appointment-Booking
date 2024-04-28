import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Link } from 'react-router-dom';

const Signup = () => {
  return (
    <div className='container mt-5'>
    <div className="row">
      <div className="col-md-5">
          <div className="col-12">
            <div className="text-center justify-content-center px-5 mt-xxl-5">
                <h3 className='login__title'>Sign up</h3>
                <h5 className='login__title_sup'>Booking appointment</h5>
                
                <div className='d-flex flex-column py-5 border-top border-dark border-2 mt-3'>
                  <motion.div whileTap={{scale: 0.8}}>
                    <Link to="/login-by-phone" className='btn__login'>Đăng ký bằng phone</Link>
                  </motion.div>
                  <p className='text-center my-3'>Or</p>
                  <motion.div whileTap={{scale: 0.8}}>
                    <Link to="/login-by-gmail" className='btn__login'>Đăng ký bằng gmail</Link>
                  </motion.div>                  
                </div>
                <div className='mt-xl-5'>
                    <p>Bạn đã có tài khoản? <Link to="/login" className='text-decoration-none ms-2'>Đăng nhập</Link></p>
                </div>

            </div>
          </div>
      </div>
      <div className="col-md-1"></div>
      <div className="col-md-6">
          <div className="col-12">
              <img src="/images/bg_signup.png" alt="" className='img-fluid' />
          </div>
      </div>
    </div>
    
  </div>
  )
}

export default Signup