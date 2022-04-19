// Base url
const String baseUrl = 'societyacts.abdulsitech.com';
const String hostBaseUrl = 'https://societyacts.abdulsitech.com';

// Routes
const String loginRoute = '/api/v1/auth/login';
const String logoutRoute = '/api/v1/auth/logout';
const String signupRoute = '/api/v1/auth/register';
const String setupRoute = '/api/v1/user/profile/update';
const String searchRoute = '/api/v1/cases/search';
const String postsRoute = '/api/v1/cases';
const String createCommentRoute = '/api/v1/cases/comments';
const String cases = '/api/v1/cases'; // ------------adopt/follow/resolve
const String users = '/api/v1/users';
const String likeRoute = '/api/v1/cases/like';
const String networkRoute = '/api/v1/network';
const String ffRoute = '/api/v1/user';
const String notificationRoute = '/api/v1/user/notifications/all';

// Routes with Dio() doesn't accept concatination, hence [baseUrl] with [route]
const String categoryRoute =
    'https://societyacts.abdulsitech.com/api/v1/cases/categories/fetch';
const String locationRoute =
    'https://societyacts.abdulsitech.com/api/v1/cases/locations/fetch';
