var app = angular.module('User', []);

app.controller('UserCtrl', function ($scope, $http) {

    $scope.setEventID = function(idSuKien) {
        localStorage.setItem('selectedEventID', idSuKien);    
    };

    
    // Lấy dữ liệu sự kiện đặc biệt
    $http.get('http://localhost:5156/api/SuKienControllers/HienThi_SuKien_DacBiet')
        .then(function (response) {
            $scope.specialEvents = response.data;  // Lưu dữ liệu vào scope
        })
        .catch(function (error) {
            console.log("Error fetching special events: ", error);
        });

    // Lấy dữ liệu sự kiện xu hướng
    $http.get('http://localhost:5156/api/SuKienControllers/HienThi_SuKien_XuHuong')
        .then(function (response) {
            $scope.trendingEvents = response.data;  // Lưu dữ liệu vào scope
        })
        .catch(function (error) {
            console.log("Error fetching trending events: ", error);
        });

    // Lấy dữ liệu sự kiện đặc sắc
    $http.get('http://localhost:5156/api/SuKienControllers/HienThi_SuKien_DacSac')
        .then(function (response) {
            $scope.featuredEvents = response.data;  // Lưu dữ liệu vào scope
        })
        .catch(function (error) {
            console.log("Error fetching featured events: ", error);
        });

});
