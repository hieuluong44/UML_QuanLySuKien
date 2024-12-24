document.addEventListener('DOMContentLoaded', function () {
    var eventSlider = document.querySelector('#eventSlider');
    if (eventSlider) {
        var carousel = new bootstrap.Carousel(eventSlider, {
            interval: 2000,
            ride: 'carousel' 
        });
    }
});


(function () {
    const carousels = document.querySelectorAll('.product-slide');
    const buttons = document.querySelectorAll('.btn-control');

    // State to keep track of the current slide for each carousel
    const carouselStates = {};

    carousels.forEach(carousel => {
        const id = carousel.id; // Get carousel ID (e.g., "special-events")
        carouselStates[id] = 0; // Initialize the slide state to 0
    });

    buttons.forEach(button => {
        button.addEventListener('click', () => {
            const carouselId = button.getAttribute('data-carousel') + '-events';
            const carousel = document.getElementById(carouselId);
            const items = carousel.children;
            const itemsPerPage = 4; // Items per page
            const totalItems = items.length;
            const itemWidth = items[0].offsetWidth; // Get width of an individual item

            // Handle Next button click
            if (button.classList.contains('next-btn')) {
                carouselStates[carouselId]++;
                if (carouselStates[carouselId] > totalItems - itemsPerPage) {
                    carouselStates[carouselId] = 0; // Loop back to the start
                }
            } 
            // Handle Back button click
            else if (button.classList.contains('back-btn')) {
                carouselStates[carouselId]--;
                if (carouselStates[carouselId] < 0) {
                    carouselStates[carouselId] = totalItems - itemsPerPage; // Loop to the end
                }
            }

            // Update the carousel position
            carousel.style.transform = `translateX(-${carouselStates[carouselId] * (itemWidth + 10)}px)`;
        });
    });

    // Auto-slide every 5 seconds
    setInterval(() => {
        Object.keys(carouselStates).forEach(carouselId => {
            const carousel = document.getElementById(carouselId);
            const items = carousel.children;
            const itemsPerPage = 4; // Items per page
            const totalItems = items.length;
            const itemWidth = items[0].offsetWidth;

            // Move to the next slide
            carouselStates[carouselId]++;
            if (carouselStates[carouselId] > totalItems - itemsPerPage) {
                carouselStates[carouselId] = 0; // Loop back to start
            }

            // Update carousel position
            carousel.style.transform = `translateX(-${carouselStates[carouselId] * (itemWidth + 10)}px)`;
        });
    }, 5000); // Auto-slide every 5 seconds
})();
