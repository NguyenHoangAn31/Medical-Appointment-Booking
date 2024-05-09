import React from 'react'
import { MdArrowOutward } from "react-icons/md"

const HomeAbout = () => {
  return (
    <section className='container'>
      <div className="row">
        <div className="col-md-3"><div className='main__title'>About us</div></div>
        <div className="col-md-6">Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo modi eum tenetur minima asperiores in,
          nisi molestias, perspiciatis ad quam maiores dicta, porro sed accusantium hic fugit consequuntur non ab?</div>
        <div className="col-md-3">
          <a className='btn__readmore'>Read more <MdArrowOutward /></a>
        </div>
      </div>
    </section>
  )
}

export default HomeAbout