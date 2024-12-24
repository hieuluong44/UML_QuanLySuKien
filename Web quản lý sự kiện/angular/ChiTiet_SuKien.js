app.controller('ChiTietSuKienCtrl', function ($scope, $http) {


    $scope.ListVe = [];
    const selectedEventID = localStorage.getItem("selectedEventID");

    if (selectedEventID) {
        $http.get(`http://localhost:5156/api/ChiTietSuKienControllers/GetChiTiet_SuKien/${selectedEventID}`)
            .then(function (response) {
                $scope.Event = response.data;
            }, console.error);
    } else {
        console.error("Không tìm thấy sản phẩm");
    }

    $scope.loadthongso = function () {
        $http.get(`http://localhost:5156/api/ChiTietSuKienControllers/Get_Ve/${selectedEventID}`)
        .then(function (response) {
            $scope.ListVe = response.data;
        }, console.error);
    };
    $scope.loadthongso();
});
