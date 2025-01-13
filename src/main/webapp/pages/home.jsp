<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EventSphere</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="row">
        <nav class="navbar">
            <h1> Eventsphere</h1>
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="#events">Events</a></li>
                <li><a href="#teacher">Teacher</a></li>
                <li><a href="#student">Student</a></li>
                <li><a href="#about">About Us</a></li>
                <li><a href="#contact">Contact Us</a></li>
                <li class="login-button"><a href="${pageContext.request.contextPath}/pages/login" class="logIn-button">LogIn</a></li>
            </ul>
        </nav>
        <div class="content">
            <h1>Welcome to EVENTSPHERE</h1>
            <p>Connect, Learn, and Share Together!</p>
        </div>
    </div>
</div>

<div id="events" class="features section">
    <div class="feature-card">
        <h3>Workshops</h3>
        <p>
            Participate in hands-on workshops to boost your skills and knowledge.
            Key highlights include:
        </p>
        <ul>
            <li>Interactive sessions with industry experts</li>
            <li>Opportunities to practice real-world scenarios</li>
            <li>Certificates for participation</li>
        </ul>
    </div>


    <div class="feature-card">
        <h3>Announcements</h3>
        <p>
            Stay updated with the latest news, upcoming events, and important updates.
            Key details include:
        </p>
        <ul>
            <li>Latest university news and achievements</li>
            <li>Upcoming events and deadlines</li>
            <li>Important notices for students and staff</li>
        </ul>
    </div>


    <div class="feature-card">
        <h3>Interviews</h3>
        <p>
            Prepare for success with interview tips, mock sessions, and expert advice.
            Key features include:
        </p>
        <ul>
            <li>Mock interview sessions with professionals</li>
            <li>Resume-building and personal branding guidance</li>
            <li>Insights on frequently asked interview questions</li>
        </ul>
    </div>
</div>

<!--teacher section-->
<section id="teacher" class="teacher-section">
    <div class="teacher">
        <div class="teacher-image">
            <img src="images/teacher.jpg" alt="Teacher Image">
        </div>
        <div class="teacher-description">
            <h2>Teacher</h2>
            <p>Teachers can share their expertise by conducting workshops, mentoring students, and fostering a love for learning.</p>
            <h3>Roles and Responsibilities:</h3><br>
            <ul>
                <li>Conduct workshops and classes</li>
                <li>Mentor students and provide guidance</li>
                <li>Collaborate with other educators</li>
                <li>Evaluate and provide feedback on student progress</li>
            </ul>
            <h3>Benefits:</h3><br>
            <ul>
                <li>Make a difference in students' lives</li>
                <li>Enhance your teaching skills</li>
                <li>Get recognition for your contributions</li><br>
                <li class="login-button" style="list-style: none;"><a href="${pageContext.request.contextPath}/pages/login" class="logIn-button">LogIn</a></li>
            </ul>
        </div>
    </div>
</section>

<!--student section-->
<section id="student" class="student-section">
    <div class="student">
        <div class="student-description">
            <h2>Student</h2>
            <p>Students can LogIn to join educational workshops, enhance their skills, and prepare for their future careers.</p>
            <h3>Roles and Responsibilities:</h3><br>
            <ul>
                <li>Participate in workshops and events</li>
                <li>Engage in networking opportunities</li>
                <li>Take part in skill-building sessions</li>
                <li>Provide feedback on workshops</li>
            </ul>
            <h3>Benefits:</h3><br>
            <ul>
                <li>Gain new skills and knowledge</li>
                <li>Access to expert advice and mentorship</li>
                <li>Build a strong professional network</li><br>
                <li class="login-button" style="list-style: none;"><a href="${pageContext.request.contextPath}/pages/login" class="logIn-button">LogIn</a></li>
            </ul>
        </div>
        <div class="student-image">
            <img src="${pageContext.request.contextPath}/images/student.jpg" alt="Student Image">
        </div>
    </div>
</section>

<!-- About Us Section -->
<section id="about" class="about-section">
    <div class="about">
        <div class="about-content">
            <div class="about-image">
                <img src="${pageContext.request.contextPath}/images/aboutus.jpg" alt="About Us Image">
            </div>
            <div class="about-description">
                <h2>About Us</h2>
                <p class="about-border">
                    Welcome to EVENTSHPERE, your ultimate destination for educational events and activities.
                    Our mission is to provide students and professionals with opportunities to excel by
                    participating in workshops, interviews, and hands-on learning sessions.
                </p>
                <p class="about-border">
                    Join us and take your education and career to the next level!
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Contact Us Section -->
<section id="contact" class="contact-section">
    <div class="contact">
        <h2>Contact Us</h2>
        <p>Have questions or need more information? Reach out to us:</p>
        <ul>
            <li style="list-style: none;"><i class="fas fa-envelope"></i> <strong>Email:</strong> eventsphere@gmail.com</li><br>
            <li style="list-style: none;"><i class="fas fa-phone-alt"></i> <strong>Phone:</strong> +123 456 7890</li><br>
            <li style="list-style: none;"><i class="fas fa-map-marker-alt"></i> <strong>Address:</strong> 123 Education Lane, Knowledge City</li>
        </ul>
    </div>
</section>

<script src="${pageContext.request.contextPath}/js/home.js"></script>
</body>
</html>