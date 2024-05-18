import React from 'react';
import { Link } from 'react-router-dom';
import { GoArrowUpRight } from "react-icons/go";

const NewsItem = ({ item }) => {
  return (
    <div className="card mb-4">
      <img src={`http://localhost:8080/images/news/${item.image}`} className="card-img-top" alt={item.title} />
      <div className="card-body">
        <h5 className="card-title">{item.title}</h5>
        {/* <div className="card-text" dangerouslySetInnerHTML={{ __html: item.content }}></div> */}
        <p className="card-text"><small className="text-muted">By: {item.creator_email}</small></p>
        {/* <Link to={`/blogdetail/${item.id}`} className="btn btn-primary">Read More</Link> */}
        <Link to={`/blogdetail/${item.id}`}>
                    <GoArrowUpRight className='list__icon-rowup' />
        </Link>
      </div>
    </div>
  );
};

export default NewsItem;
