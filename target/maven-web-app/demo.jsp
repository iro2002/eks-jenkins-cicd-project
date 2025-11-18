<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .profile-container {
            width: 50%;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .profile-info {
            margin-top: 20px;
            line-height: 1.8;
            font-size: 18px;
        }
        .back-link {
            margin-top: 20px;
            display: block;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="profile-container">
        <h1>My Profile</h1>

        <div class="profile-info">
            <strong>Name:</strong> Chamindu Irosh. <br>
            <strong>Role:</strong> UOC Undergraduate / DevOps Enthusiast <br>
            <strong>Location:</strong> Galle, Sri Lanka <br>
            <strong>Interests:</strong> Cloud, DevOps, System Administration <br>
        </div>

        <a class="back-link" href="index.jsp">⬅ Back to Home</a>
    </div>

</body>
</html>
