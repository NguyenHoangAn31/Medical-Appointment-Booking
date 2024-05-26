import React from 'react'
import Footer from './Footer'
import Header from './Header'
import { Link} from "react-router-dom";
import { BiBell, BiHeart, BiLogIn, BiCalendarCheck, BiSolidUserRectangle    } from "react-icons/bi";

const accountLayout = (children) => {
    return (
        <div>
            <Header />
            <div className='container mt-3'>
                <div className="row">
                    <div className="col-md-4">
                        <div className='sidebar__account'>
                            <ul>
                                <li><Link to="" className='user__link'><BiBell /> Notication</Link></li>
                                <li><Link to="/account" className='user__link'><BiSolidUserRectangle /> Profile</Link></li>
                                <li><Link to="" className='user__link'><BiCalendarCheck /> Booking</Link></li>
                                <li><Link to="" className='user__link'><BiHeart /> Fauvorite</Link></li>
                                <li><a className='user__link'><BiLogIn /> Sign out</a></li>
                            </ul>
                        </div>
                    </div>
                    <div className="col-md-8">{children}</div>
                </div>
            </div>
            <Footer />
        </div>

    )
}

export default accountLayout