import React, { useState, useEffect } from 'react'
import { Link, useNavigate, useLocation } from "react-router-dom";
import { motion } from 'framer-motion';
import getUserData from '../../../../route/CheckRouters/token/Token';
import axios from 'axios';

const Header = () => {
  const location = useLocation();
  const currentPath = location.pathname;
  const history = useNavigate();

  useEffect(() => {
    // var user
    // if(getUserData != null) {
    //     const UserResult = axios.get('http://localhost:8080/api/doctor/', params{

    //     })
    // }

  }, []);
  const handleLogin = () => {
    localStorage.setItem('currentPath', currentPath);
    history('/login');
  }

  const handleSignOut = () => {
    sessionStorage.removeItem('Token');
    history('/');
    window.location.reload();
  }
 
  return (
    <>
      <nav className="navbar navbar-expand-lg bg-light sticky-top">
        <div className="container">
          <Link to="/" className="navbar-brand logo">Medi<span className='logo-span'>care</span></Link>
          <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="navbarSupportedContent">
            <ul className="navbar-nav ms-auto me-5">
              <li className="nav-item">
                <Link to="/about" className="nav-link">About Us</Link>
              </li>
              <li className="nav-item">
                <Link to="/booking" className="nav-link">Booking an appointment</Link>
              </li>
              <li className="nav-item">
                <Link to="/service" className="nav-link">Service</Link>
              </li>
              <li className="nav-item">
                <Link to="/doctor" className="nav-link">For Doctor</Link>
              </li>
            </ul>
            <motion.div whileTap={{ scale: 0.8 }}>
              {getUserData != null ? (
                <div>
                  {/* <div  className="login">{getUserData.user.fullName}</div> */}
                  <div onClick={handleSignOut} className="login">Sign out</div>
                </div>
                  
              ) : (
                <div onClick={handleLogin}  className="login">Login</div>
              )}
                {/* <div onClick={handleLogin}  className="login">Login</div> */}
            </motion.div>
          </div>
        </div>
      </nav>

    </>
  )
}

export default Header