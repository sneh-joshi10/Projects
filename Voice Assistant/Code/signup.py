from flask import Flask, request, jsonify
import mysql.connector
app = Flask(__name__)

@app.route('/signup', methods=['GET','POST'])
def signup():
    data = request.get_json()  # Get data from the request body
    name= data['n']
    email = data['e']
    password = data['p']
    connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Athreya2608#",
    database="fswd_project"
)
    cursor = connection.cursor()
    sql_query = "insert into users values(%s,%s,%s)"
    try:
        cursor.execute(sql_query, (name,email, password))
        connection.commit()
        return jsonify({'response': 'Registered', 'email': email})
    except:
        return jsonify({'response': 'Not Registered', 'email': email})


if __name__ == '__main__':
    app.run(debug=True)
