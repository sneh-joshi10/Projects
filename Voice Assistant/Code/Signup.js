import React, { useState } from 'react';
import './Login.css'; // Import your CSS file for styling
import logo from './logo.png'; // Import your image

const AncientGreekLogin = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const [message, setMessage] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault(); // Prevent form submission

    try {
      const response = await fetch('/signup', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ 'n': name,'e':email,'p': password }) // Simplified object shorthand
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
      <div className="right">
        <h5>Register</h5>
        <h3 style={{ color:'royalblue', fontSize:'2vmax'}}> Join the echelons of wisdom today!</h3>
        <form onSubmit={handleSubmit}>
          <div className="inputs">
            <input type="text" placeholder="Name" value={name} onChange={(e) => setName(e.target.value)} />
            <input type="text" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} />
            <br />
            <input type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} />
          </div>

          <br />
          <br />
          <button type="submit">Sign Up</button>
        </form>
        
      </div>

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
    </div>
  );
};

export default AncientGreekLogin;
