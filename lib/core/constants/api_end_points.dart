class ApiEndPoints {
  ///development Url
  // static const String baseUrl = "http://54.206.67.107:8080";
  // live url
  // static const String baseUrl = "http://52.62.236.98:8081"; //oldurl
  static const String baseUrl = "https://admin.divinesoftwares.com.au";
  // static const String baseUrl = "https://app.spidertechnology.com.au/api/v1";

  static const String logInEndPoint = "$baseUrl/employee/login";

  static const String forgotEndPoint = "$baseUrl/employee/forgot-password";

  static String resetEndPoint(String token) =>
      "$baseUrl/employee/reset-password/$token";

  static const String employeeProfileEndPoints = "$baseUrl/employee/profile";

  static const String employeeCurrentJobsEndPoints =
      "$baseUrl/jobs/current-job";

  static const String allAvialbleJobsEndPoints = "$baseUrl/jobs/available-job";

  static const String getPaidLeaveHoursEndPoints = "$baseUrl/employee/leave-available-hours";

  static const String leaveRequestEndPoints = "$baseUrl/employee/leave-request";

  static String jobCancelationRequestEndPoints(String jobId) =>
      "$baseUrl/jobs/job-cancel/$jobId";

  static String generateIncidentReportEndPoints(String jobId) =>
      "$baseUrl/jobs/incident-report/$jobId";

  static String clockInEndPoints(String jobId) =>
      "$baseUrl/employee/clock-in/$jobId";

  static String clockOutEndPoints(String jobId) =>
      "$baseUrl/employee/clock-out/$jobId";

  static String claimExtraEndPoints(String jobId) =>
      "$baseUrl/jobs/update-claim/$jobId";

  static String taskUpdateEndPoints(String currentJobEndPoints) =>
      "$baseUrl/jobs/$currentJobEndPoints/update-tasks";

  static const String feedbackEndpoint = "$baseUrl/employee/feed-Back";

  static String getAvailabilityEndpoint(String employeeId) =>
      "$baseUrl/employee/employee-availability/$employeeId";

  // static const String setAvailability = "$baseUrl/employee/set-availability";
  static const String updateAvailability =
      "$baseUrl/employee/update-availability";

  static const String getIncidentReportEndPoints =
      "$baseUrl/employee/incidents";
  static const String uploadDocEndPoints = "$baseUrl/employee/upload-doc";

  static const String employeeProfileEndPoint = "$baseUrl/employee/profile";
  static const String updateProfileEndPoint =
      "$baseUrl/employee/update-profile";

  static String jobApplicationEndpoint(String jobId) =>
      "$baseUrl/jobs/$jobId/apply";
  static const String allNotifications = "$baseUrl/notification-list";
  static String updateNotificationStatus(String NotificationId) =>
      "$baseUrl/udpate-notification/$NotificationId";

  static String allChats(userID) => '$baseUrl/chat/$userID';
  static String chatRoom(chatId) => '$baseUrl/message/$chatId';
  static String findAndCreateChat = '$baseUrl/chat/findAndCreateChat';
  static String getInvoice = '$baseUrl/employee/invoice';

  static String updateJob(jobId) => '$baseUrl/jobs/update-job/$jobId';
  static String getRoster = '$baseUrl/employee/get-roaster-employee';
  static String registration= '$baseUrl/employee/signup';
  //////delete
  ///
   static String delete= '$baseUrl/employee/delete';
  
}



