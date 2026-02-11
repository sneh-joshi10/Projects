import React, { useState } from 'react';
import './Login.css'; // Import your CSS file for styling
import logo from './logo.png'; // Import your image

const AncientGreekLogin = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault(); // Prevent form submission

    try {
      const response = await fetch('/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ 'e':email,'p': password }) // Simplified object shorthand
      });
  
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
  
      const data = await response.json();
      alert(data.response); // Assuming the response contains a field named 'response'
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
    <div className="box-form">
      <div className="left">
        <div className="overlay">
          <h1>Welcome</h1>
          <p>"In Delphi, ancient wisdom whispers through the ages, guiding us on a timeless journey of enlightenment."</p>
          <span>
            <p>Login with social media</p>
            <a href="#"><i className="fa fa-twitter" aria-hidden="true"></i> Login with Google</a>
          </span>
        </div>
      </div>

      <div className="right">
        <h5>Login</h5>
        <p>Don't have an account? <a href="#">Create One</a>, it takes less than a minute!</p>
        <form onSubmit={handleSubmit}>
          <div className="inputs">
            <input type="text" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} />
            <br />
            <input type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} />
          </div>

          <br />

          <div className="remember-me--forget-password">
          <span>
          <a href="#"><i className="fa fa-twitter" aria-hidden="true"></i>Forgot Password?</a>
          </span>
          </div>
          <br />
          <button type="submit">Login</button>
        </form>
      </div>
    </div>
  );
};

export default AncientGreekLogin;
