// ignore_for_file: constant_identifier_names

class ApiConstants {
  // static const String baseUrls =
  //     "http://192.168.1.20:3000"; // Replace with your base URL
  static const String baseUrls =
      "http://72.60.103.154:5000/api"; // Replace with your base URL


  // Login end-point
  static const String login = "$baseUrls/auth/login";

  // Register end-point
  static const String register = "$baseUrls/auth/register";


  ////////////////////////////////////////// Preferred Languages ////////////////////////////////////////////////////


  static const String preferredLanguageList = "$baseUrls/language";

  // Save user preferred language
  static const String savePreferredLanguage = "$baseUrls/userlanguage/save";

  // Get user preferred language
  static const String getSavedPreferredLanguage = "$baseUrls/userlanguage";


  ////////////////////////////////////////// Preferred Genres ////////////////////////////////////////////////////

  // Preferred Genres List end-point
  static const String preferredGenresList = "$baseUrls/categories";

  // Save Preferred Genres end-point
  static const String savePreferredGenres = "$baseUrls/usergenres/save";


  // Save Preferred Genres end-point
  static const String getAllSavedGenres = "$baseUrls/usergenres";



  ////////////////////////////////////////// Preferred Platforms ////////////////////////////////////////////////////

  // All Preferred Genres List end-point
  static const String preferredPlatforms = "$baseUrls/platforms";

  // Save Preferred Genres List end-point
  static const String savePreferredPlatforms = "$baseUrls/userplatforms/save";


  // Get Preferred Genres List end-point
  static const String getSavedPreferredPlatforms = "$baseUrls/userplatforms";
  ////////////////////////////////////////// Preferred Platforms ////////////////////////////////////////////////////

  static const String getQuestions = "$baseUrls/adminquestion/questions";


  ////////////////////////////////////////// Preferred Platforms ////////////////////////////////////////////////////

  static const String saveSurveyQuestions = "$baseUrls/userserver/survey/answers";
  

  ////////////////////////////////////////// Home Page ////////////////////////////////////////////////////
  static const String homepage = "$baseUrls/homepage";




  // Get Popular Celebrities
  static const String popularCelebrities = "$baseUrls/celebrities";


  // Today Born
  static const String todayBorn = "$baseUrls/celebrities/birthdays/today";


  // Get Celebrity Details
  static const String celebrityDetails = "$baseUrls/celebrities";

  // Get all news and details api end point is same
  static const String getAllNews = "$baseUrls/latestnews";

  // Add TO Favourite
  static const String addToFavourite = "$baseUrls/favorites";


  // Add TO watch list
  static const String addtowatchlist = "$baseUrls/favorites";

  ////////////////////////////////////////// Popular Indian Movies ////////////////////////////////////////////////////
  // Polular indian movies lits
  static const String popularIndianMovies = "$baseUrls/movies";
  
  // Polular indian movie details
  static const String popularIndianMovieDetails = "$baseUrls/movies";
}
