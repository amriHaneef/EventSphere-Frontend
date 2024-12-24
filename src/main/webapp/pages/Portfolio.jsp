
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EventSphere</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio.css">
    <link href="https://cdn.jsdelivr.net/npm/material-icons@1.13.12/iconfont/material-icons.min.css" rel="stylesheet">
</head>
<body>
<div class="main">
    <div class="left">
        <br>
        <div class="profile-img"><img src="${pageContext.request.contextPath}/images/noprofil.jpg" alt=""></div>

        <div class="box-1">
            <div class="heading">
                <p>CONTACT</p>
            </div>
            <p class="p1">
                <i class="material-icons icons1">call</i>+949183721
            </p>
            <p class="p1">
                <i class="material-icons icons1">email</i>info@gmail.com
            </p>
        </div>
        <div class="box-1">
            <div class="heading">
                <p>LANGUAGES</p>
            </div>
            <p class="p1">HTML
                <div class="skill-container">
                    <div class="skill html"></div>
                </div>
            </p>
            <p class="p1">CSS
                <div class="skill-container">
                    <div class="skill css"></div>
                </div>
            </p>
            <p class="p1">JAVASCRIPT
                <div class="skill-container">
                    <div class="skill js"></div>
                </div>
            </p>
            <p class="p1">JQUERY
                <div class="skill-container">
                    <div class="skill jquery"></div>
                </div>
            </p>
        </div>

        <br>
        <div class="box-1">
            <div class="heading">
                <p>SKILLS</p>
            </div>
            <p class="p1">WEBSITE DESIGN
            <div class="skill-container">
                <div class="skill web"></div>
            </div>
            </p>
            <p class="p1">GRAPHIC DESIGN
            <div class="skill-container">
                <div class="skill gra"></div>
            </div>
            </p>
        </div>
        <br>
        <div class="box-1">
            <div class="heading">
                <p>HOBBIES</p>
            </div>

            <div class="h-div">
                <i class="material-icons icons2" title="Photography">camera_roll</i>
                <i class="material-icons icons2" title="Listening to Music">music_note</i>
                <i class="material-icons icons2" title="Riding">motorcycle</i>
                <i class="material-icons icons2" title="Working">border_color</i>
            </div>
        </div>
    </div>

    <div class="right">
        <div class="name-div">
            <h1>Harindu De Silva</h1>
            <p>WebSite Designer</p>
        </div>

        <div class="box-2">
            <h2>ABOUT ME
                <i class="material-icons icons3 edit" style="font-size: 28px !important;">perm_identity
                    <i class="material-icons  hidden" title="Edit" onclick="aboutEditing()">border_color</i>
                </i>
            </h2>
            <p class="p2 about">
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. <br>Asperiores placeat ratione fugiat id ut laudantium sunt et possimus quibusdam explicabo, in aspernatur nesciunt perferendis tenetur magnam aut distinctio? Eligendi, unde.
            </p>
        </div>

        <div class="box-2">
            <h2>EDUCATION <i class="material-icons icons3 edit" style="font-size: 28px !important;">border_color
                <i class="material-icons  hidden" title="Edit" onclick="educationEditing()">border_color</i>
                </i>
            </h2>
            <div class="education-section">
                <p class="p3">2016-2019 <span>Lorem ipsum dolor sit ame..</span></p>
                <p class="p2">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                </p>

                <p class="p3">2019-2022 <span>Lorem  consectetur adipisicing elit.</span></p>
                <p class="p2">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                </p>

                <p class="p3">2022-2024 <span>Lorem ipsum dolor sit  elit.</span></p>
                <p class="p2">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                </p>
            </div>
        </div>


        <div class="box-2">
            <h2>WORK EXPERIENCE <i class="material-icons icons3 edit" >folder
                <i class="material-icons  hidden" title="Edit" onclick="experienceEditing()">border_color</i></i>
            </h2>
            <div class="experience-section">
                <p class="p3">2016-2019 <span>Lorem ipsum dolor sit .</span></p>
                <p class="p2">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                </p>

                <p class="p3">2019-2022 <span>Lorem ipsum dolor sit amet</span></p>
                <p class="p2">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                </p>
            </div>
        </div>
    </div>

</div>
<script src="${pageContext.request.contextPath}/js/Portfolio.js"></script>
</body>
</html>
