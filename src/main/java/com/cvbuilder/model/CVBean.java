package com.cvbuilder.model;

import java.util.ArrayList;
import java.util.List;

public class CVBean {

    // Personal Info
    private String fullName;
    private String title;
    private String email;
    private String phone;
    private String linkedin;
    private String summary;
    private String photoUrl;

    // Education
    private String degree;
    private String institution;
    private String gradYear;
    private String major;

    // Experience
    private String jobTitle;
    private String company;
    private String duration;
    private String responsibilities;

    // Skills
    private String technicalSkills;
    private String softSkills;

    // Validation errors
    private List<String> errors = new ArrayList<>();

    // Zero-argument constructor
    public CVBean() {
    }

    // Validation
    public boolean validate() {
        errors.clear();

        if (isEmpty(fullName)) {
            errors.add("Full Name is required.");
        }

        if (isEmpty(email)) {
            errors.add("Email is required.");
        } else if (!email.trim().matches("^[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+$")) {
            errors.add("Email format is not valid.");
        }

        if (isEmpty(degree)) {
            errors.add("Highest Degree is required.");
        }

        if (isEmpty(technicalSkills)) {
            errors.add("At least one Technical Skill is required.");
        }

        return errors.isEmpty();
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

        // Helper methods: split text into lists for the view
    public List<String> getTechnicalSkillList() {
        return splitToList(technicalSkills, ",");
    }

    public List<String> getSoftSkillList() {
        return splitToList(softSkills, ",");
    }

    public List<String> getResponsibilityList() {
        return splitToList(responsibilities, "\\r?\\n");
    }

    private List<String> splitToList(String text, String regex) {
        List<String> list = new ArrayList<>();
        if (text == null) {
            return list;
        }
        for (String item : text.split(regex)) {
            if (!item.trim().isEmpty()) {
                list.add(item.trim());
            }
        }
        return list;
    }
    
    // Getters and setters
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getLinkedin() { return linkedin; }
    public void setLinkedin(String linkedin) { this.linkedin = linkedin; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    
    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }

    public String getDegree() { return degree; }
    public void setDegree(String degree) { this.degree = degree; }

    public String getInstitution() { return institution; }
    public void setInstitution(String institution) { this.institution = institution; }

    public String getGradYear() { return gradYear; }
    public void setGradYear(String gradYear) { this.gradYear = gradYear; }

    public String getMajor() { return major; }
    public void setMajor(String major) { this.major = major; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public String getResponsibilities() { return responsibilities; }
    public void setResponsibilities(String responsibilities) { this.responsibilities = responsibilities; }

    public String getTechnicalSkills() { return technicalSkills; }
    public void setTechnicalSkills(String technicalSkills) { this.technicalSkills = technicalSkills; }

    public String getSoftSkills() { return softSkills; }
    public void setSoftSkills(String softSkills) { this.softSkills = softSkills; }

    public List<String> getErrors() { return errors; }
}