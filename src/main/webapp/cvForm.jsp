<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CV Builder - Input Form</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="form-page">
    
<!-- Loading screen -->
<div id="loader" class="loader">
    <video autoplay muted loop playsinline>
        <source src="${pageContext.request.contextPath}/media/intro.mp4" type="video/mp4">
    </video>
    <h2>We will help you build the best CV for you</h2>
    <p>Getting your CV builder ready...</p>
    <div class="loader-bar"><span></span></div>
</div>

<!-- Hero -->
<header class="hero">
    <h1>Build Your Professional CV</h1>
    <p>Fill in your details, and get a clean, print-ready CV in seconds.</p>
    <a class="btn btn-light" href="CVServlet?action=sample">Preview Sample CV</a>
</header>

<div class="layout">

<aside class="side-nav" aria-label="Sections">
    <p class="side-title">Sections</p>
    <a href="#sec-personal" data-sec="sec-personal" class="active">Personal</a>
    <a href="#sec-education" data-sec="sec-education">Education</a>
    <a href="#sec-experience" data-sec="sec-experience">Experience</a>
    <a href="#sec-skills" data-sec="sec-skills">Skills</a>
</aside>

<div class="form-container">

    <div class="progress-wrap">
        <div class="progress-label">
            <span>Required fields</span>
            <span id="progressText">0 / 4</span>
        </div>
        <div class="progress-track"><div id="progressFill"></div></div>
    </div>

    <form action="CVServlet" method="post" novalidate>

        <fieldset class="card" id="sec-personal" style="--d:0.1s">
            <legend>Personal Information</legend>

            <label for="fullName">Full Name *</label>
            <input type="text" id="fullName" name="fullName" class="req">

            <label for="title">Professional Title</label>
            <input type="text" id="title" name="title">

            <label for="email">Email *</label>
            <input type="email" id="email" name="email" class="req">

            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone">

            <label for="linkedin">LinkedIn / GitHub URL</label>
            <input type="url" id="linkedin" name="linkedin">

            <label for="summary">Profile Summary</label>
            <textarea id="summary" name="summary" rows="4"></textarea>
            
            <label for="photoUrl">Photo URL (optional)</label>
            <input type="url" id="photoUrl" name="photoUrl" placeholder="https://example.com/my-photo.jpg">
            <img id="photoPreview" class="photo-preview" alt="Photo preview">
        </fieldset>

        <fieldset class="card" id="sec-education" style="--d:0.25s">
            <legend>Education</legend>

            <label for="degree">Highest Degree *</label>
            <input type="text" id="degree" name="degree" class="req">

            <label for="institution">Institution Name</label>
            <input type="text" id="institution" name="institution">

            <label for="gradYear">Year of Graduation</label>
            <input type="number" id="gradYear" name="gradYear" min="1950" max="2100">

            <label for="major">Major / Field</label>
            <input type="text" id="major" name="major">
        </fieldset>

        <fieldset class="card" id="sec-experience" style="--d:0.4s">
            <legend>Experience</legend>

            <label for="jobTitle">Most Recent Job Title</label>
            <input type="text" id="jobTitle" name="jobTitle">

            <label for="company">Company Name</label>
            <input type="text" id="company" name="company">

            <label for="duration">Duration</label>
            <input type="text" id="duration" name="duration" placeholder="e.g. Jan 2024 - Jun 2024">

            <label for="responsibilities">Key Responsibilities / Achievements</label>
            <textarea id="responsibilities" name="responsibilities" rows="4"
                      placeholder="One item per line"></textarea>
        </fieldset>

        <fieldset class="card" id="sec-skills" style="--d:0.55s">       
            <legend>Skills</legend>

            <label for="technicalSkills">Technical Skills * (comma-separated)</label>
            <input type="text" id="technicalSkills" name="technicalSkills" class="req"
                   placeholder="e.g. Java, SQL, HTML">

            <label for="softSkills">Soft Skills (comma-separated)</label>
            <input type="text" id="softSkills" name="softSkills"
                   placeholder="e.g. Teamwork, Communication">
        </fieldset>

        <div class="actions">
            <button type="submit" class="btn btn-primary">Generate My CV</button>
            <button type="reset" class="btn btn-secondary" id="resetBtn">Clear</button>
        </div>
    </form>
</div>

<aside class="preview" aria-label="Live preview">
    <p class="side-title">Live preview</p>
    <div class="pv-card">
        <div id="pvPhotoPh" class="pv-photo pv-ph">Photo</div>
        <img id="pvPhoto" class="pv-photo" alt="Preview photo" style="display:none">
        <h3 id="pvName" class="pv-name"></h3>
        <p id="pvTitle" class="pv-title"></p>
        <p id="pvContact" class="pv-contact"></p>

        <h4>Summary</h4>
        <p id="pvSummary"></p>

        <h4>Education</h4>
        <p id="pvEdu"></p>

        <h4>Experience</h4>
        <p id="pvExp"></p>

        <h4>Skills</h4>
        <ul id="pvSkills" class="pv-tags"></ul>
    </div>
    <p class="pv-note">Preview only. Your CV is generated when you submit.</p>
</aside>

</div>

<script>
(function () {
    // ----- Loader: shows once per browser session -----
    var loader = document.getElementById("loader");
    var seen = false;
    try { seen = sessionStorage.getItem("cvLoaderSeen") === "1"; } catch (e) {}

    if (seen) {
        loader.style.display = "none";
    } else {
        setTimeout(function () {
            loader.classList.add("hide");
            try { sessionStorage.setItem("cvLoaderSeen", "1"); } catch (e) {}
            setTimeout(function () { loader.style.display = "none"; }, 700);
        }, 3500);
    }

    // ----- Live progress of required fields -----
    var fields = document.querySelectorAll(".req");
    var fill = document.getElementById("progressFill");
    var text = document.getElementById("progressText");

    function updateProgress() {
        var done = 0;
        fields.forEach(function (f) {
            if (f.value.trim() !== "") { done++; }
        });
        text.textContent = done + " / " + fields.length;
        fill.style.width = (done / fields.length * 100) + "%";
    }

    fields.forEach(function (f) { f.addEventListener("input", updateProgress); });
    document.getElementById("resetBtn").addEventListener("click", function () {
        setTimeout(updateProgress, 0);
    });
    updateProgress();
})();
</script>

<script>
(function () {
    var input = document.getElementById("photoUrl");
    var preview = document.getElementById("photoPreview");

    input.addEventListener("input", function () {
        var url = input.value.trim();
        if (url === "") {
            preview.style.display = "none";
            return;
        }
        preview.src = url;
    });
    preview.addEventListener("load", function () { preview.style.display = "block"; });
    preview.addEventListener("error", function () { preview.style.display = "none"; });
})();
</script>

<script>
(function () {
    var cards = document.querySelectorAll("fieldset.card");
    var links = document.querySelectorAll(".side-nav a");

    function setActive(id) {
        links.forEach(function (a) {
            a.classList.toggle("active", a.getAttribute("data-sec") === id);
        });
    }

    cards.forEach(function (c) {
        c.addEventListener("focusin", function () { setActive(c.id); });
    });
    links.forEach(function (a) {
        a.addEventListener("click", function () { setActive(a.getAttribute("data-sec")); });
    });

    if ("IntersectionObserver" in window) {
        var obs = new IntersectionObserver(function (entries) {
            entries.forEach(function (en) {
                if (en.isIntersecting) { setActive(en.target.id); }
            });
        }, { rootMargin: "-35% 0px -55% 0px" });
        cards.forEach(function (c) { obs.observe(c); });
    }
})();
</script>

<script>
(function () {
    function v(id) { return document.getElementById(id).value.trim(); }

    function setText(id, text, placeholder) {
        var el = document.getElementById(id);
        if (text) {
            el.textContent = text;
            el.classList.remove("empty");
        } else {
            el.textContent = placeholder;
            el.classList.add("empty");
        }
    }

    function addTags(ul, value) {
        value.split(",").forEach(function (s) {
            s = s.trim();
            if (s) {
                var li = document.createElement("li");
                li.textContent = s;
                ul.appendChild(li);
            }
        });
    }

    function updatePreview() {
        setText("pvName", v("fullName"), "Your name");
        setText("pvTitle", v("title"), "Professional title");
        setText("pvContact", [v("email"), v("phone"), v("linkedin")].filter(Boolean).join(" | "), "email | phone | link");
        setText("pvSummary", v("summary"), "Your profile summary appears here.");
        setText("pvEdu", [v("degree"), v("institution"), v("gradYear")].filter(Boolean).join(", "), "Degree, institution, year");
        setText("pvExp", [v("jobTitle"), v("company"), v("duration")].filter(Boolean).join(", "), "Job title, company, duration");

        var ul = document.getElementById("pvSkills");
        ul.innerHTML = "";
        addTags(ul, v("technicalSkills"));
        addTags(ul, v("softSkills"));
        if (!ul.children.length) {
            var ph = document.createElement("li");
            ph.textContent = "Your skills";
            ph.className = "empty";
            ul.appendChild(ph);
        }
    }

    var photoIn = document.getElementById("photoUrl");
    var pvImg = document.getElementById("pvPhoto");
    var pvPh = document.getElementById("pvPhotoPh");

    function updatePhoto() {
        var url = photoIn.value.trim();
        if (url === "") {
            pvImg.style.display = "none";
            pvPh.style.display = "flex";
            return;
        }
        pvImg.src = url;
    }
    pvImg.addEventListener("load", function () { pvImg.style.display = "block"; pvPh.style.display = "none"; });
    pvImg.addEventListener("error", function () { pvImg.style.display = "none"; pvPh.style.display = "flex"; });

    document.querySelectorAll("input, textarea").forEach(function (el) {
        el.addEventListener("input", updatePreview);
    });
    photoIn.addEventListener("input", updatePhoto);

    document.getElementById("resetBtn").addEventListener("click", function () {
        setTimeout(function () { updatePreview(); updatePhoto(); }, 0);
    });

    updatePreview();
})();
</script>

</body>
</html>