import React, { useState, useEffect, useRef  } from 'react'
import { Link, useNavigate, useLocation } from "react-router-dom";
import { motion } from 'framer-motion';
import getUserData from '../../../../route/CheckRouters/token/Token';
import { BiBell, BiHeart, BiLogIn, BiCalendarCheck, BiSolidUserRectangle    } from "react-icons/bi";
//import * as patientService from '../../../../services/API/patientService';
import axios from 'axios';
import { getAuth, signOut } from "firebase/auth";


const Header = () => {
  const location = useLocation();
  const currentPath = location.pathname;
  const history = useNavigate();
  const [user, setUser] = useState([]);
  const [isMenuVisible, setIsMenuVisible] = useState(false);



  
  useEffect(() => {
    const fecthApi = async () => {
      try {
        const userId = getUserData.user.id;
       const result =  await axios.get(`http://localhost:8080/api/patient/${userId}`);
          console.log(result.data);
          setUser(result.data);
;;
      } catch (error) {
        
      }
      
  }
  
  fecthApi();

  }, []);

  

  const menuRef = useRef(null);

  const handleMenuToggle = () => {
    setIsMenuVisible(!isMenuVisible);
  };

  const handleMouseLeave = () => {
    setIsMenuVisible(false);
  };

  const handleLogin = () => {
    localStorage.setItem('currentPath', currentPath);
    history('/login');
  }

  const handleSignOut = () => {
    sessionStorage.removeItem('Token');
    const auth = getAuth();
    signOut(auth).then(() => {
      // Sign-out successful.
    }).catch((error) => {
      // An error happened.
    });
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
              <li className="nav-item">
                <Link to="/blog" className="nav-link">Blog</Link>
              </li>
              <li className="nav-item">
                <Link to="/contact" className="nav-link">Contact us</Link>
              </li>
            </ul>
            <motion.div whileTap={{ scale: 0.8 }}>
              {getUserData != null ? (
                <div className='icon_login'>
                    <div>
                      {user && user.image != null ? (
                        <img src={"http://localhost:8080/images/patients/" + user.image} alt="" id='user-login' onClick={handleMenuToggle} className='img__icon_login img-fluid' />
                      ) : (
                        <img src="/images/login_default.jpg" alt="asds" id='user-login' onClick={handleMenuToggle} className='img__icon_login img-fluid' />
                      )                                   
                      }  
                    </div>
                    {isMenuVisible && (
                    <ul className='list-unstyled dropdown__user' ref={menuRef} onMouseLeave={handleMouseLeave}>
                      <li><a href=""></a>Hello! {user.fullName}</li>
                      <li><a href=""></a><BiBell /> Notication</li>
                      <li><a href=""></a><BiSolidUserRectangle/> Profile</li>
                      <li><a href=""></a><BiCalendarCheck /> Booking</li>
                      <li><a href=""></a><BiHeart /> Fauvorite</li>
                      <li onClick={handleSignOut}><a ><BiLogIn /> Sign out</a></li>
                    </ul>
                    )}
                  {/* <div  className="login">Sign out</div> */}
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