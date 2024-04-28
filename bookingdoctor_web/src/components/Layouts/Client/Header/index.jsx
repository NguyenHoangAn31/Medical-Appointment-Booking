import React from 'react'
import { Link } from "react-router-dom";
import { motion } from 'framer-motion';

const Header = () => {
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
                <Link to="/" className="nav-link active" aria-current="page">Home</Link>
              </li>
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
              <Link to="/login" className='login'>Login</Link>
            </motion.div>

          </div>
        </div>
      </nav>

    </>
  )
}

export default Header