import React from 'react';
import { Link } from 'react-router-dom';
import { GoArrowUpRight } from "react-icons/go";
import { LineStrokeColorVar } from 'antd/es/progress/style';

const NewsItem = ({ item }) => {
  const cardStyle = {
    width: '300px',  // Cố định chiều rộng là 300px
    height: '350px', // Cố định chiều cao là 150px
    // overflow: 'hidden', // Đảm bảo nội dung vượt quá kích thước sẽ bị ẩn
    objectFit: 'cover', // Đảm bảo hình ảnh lấp đầy toàn bộ không gian mà không bị biến dạng
  };

  const imageStyle = {
    width: '100%',    // Đặt rộng của hình ảnh chiếm 100% chiều rộng của thẻ cha
    height: '100%',   // Đặt cao của hình ảnh chiếm 100% chiều cao của thẻ cha
    objectFit: 'cover', // Đảm bảo hình ảnh lấp đầy toàn bộ không gian mà không bị biến dạng
    overflow: 'hidden', // Đảm bảo nội dung vượt quá kích thước sẽ bị ẩn
  };

  const arrowStyle = {
    position: 'absolute',
    bottom: '10px',
    right: '10px',
    width: '40px',
    height: '40px',
    backgroundColor: '#007bff',
    borderRadius: '50%',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    color: '#fff',
    textDecoration: 'none',
  };

  return (
    <div className="card mb-4" style={cardStyle}>
      <img src={`http://localhost:8080/images/news/${item.image}`} className="card-img-top" alt={item.title} style={imageStyle} />
      <div className="card-body">
        <h5 className="card-title">{item.title}</h5>
        <p className="card-text"><small className="text-muted">By: {item.creator_email}</small></p>
        <Link to={`/blog/${item.id}`} style={arrowStyle}>
          <GoArrowUpRight className='list__icon-rowup' />
        </Link>
      </div>
    </div>
  );
};

export default NewsItem;
