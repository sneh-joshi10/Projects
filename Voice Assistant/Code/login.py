from flask import Flask, request, jsonify
import mysql.connector
app = Flask(__name__)

@app.route('/login', methods=['GET','POST'])
def login():
    data = request.get_json()  # Get data from the request body
    email = data['e']
    password = data['p']
    connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Athreya2608#",
    database="fswd_project"
)
    cursor = connection.cursor()
    sql_query = "SELECT email, password FROM users WHERE email = %s AND password = %s"

        # Execute the query with values
    cursor.execute(sql_query, (email, password))

        # Fetch one row (if exists)
    row = cursor.fetchone()

    if row:
           return jsonify({'response': 'Login successful', 'email': email})
    else:
            return jsonify({'response': 'Login failed. Please provide correct email and password.'})
if __name__ == '__main__':
    app.run(debug=True)
