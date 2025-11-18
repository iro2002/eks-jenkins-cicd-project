<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            margin: 0;
            padding: 0;
        }
        .home-container {
            width: 50%;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 18px;
        }
        a:hover {
            background: #45a049;
        }
    </style>
</head>
<body>

    <div class="home-container">
        <h1>Welcome to My Maven Web App.</h1>

        <a href="profile.jsp">Go to My Profile</a>
    </div>

</body>
</html>
