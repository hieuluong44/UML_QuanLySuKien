var modal = document.getElementById("ticketModal");
    var btn = document.getElementById("buynow-btn");
    var closeBtn = document.getElementById("closeModalBtn");

    // Mở modal khi nhấn vào nút Mua vé ngay
    btn.onclick = function() {
        modal.style.display = "block";
    }

    // Đóng modal khi nhấn vào nút đóng
    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    // Đóng modal nếu người dùng nhấn ra ngoài modal
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }