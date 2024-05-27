import React from 'react'
import Footer from './Footer'
import Header from './Header'
import { Link } from "react-router-dom";
import { BiBell, BiHeart, BiLogIn, BiCalendarCheck, BiSolidUserRectangle } from "react-icons/bi";
import { Toaster } from 'react-hot-toast';

function AccountLayout({ children }) {
    return (
        <div>
            <div className='float-end'><Toaster toastOptions={{ duration: 4000 }} /></div>
            <Header />
            <div className='main-app d-flex gap-5'>
                <div>
                    <ul>

                        <li><Link to="/account" className='user__link'><BiSolidUserRectangle /> Profile</Link></li>
                        <li><Link to="/checkout" className='user__link'><BiHeart /> Checkout</Link></li>
                    </ul>
                </div>
                <div className='content'>{children}</div>
            </div>
            <Footer />
        </div>
    );
}

export default AccountLayout;