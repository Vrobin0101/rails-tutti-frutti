import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper/bundle';

// import styles bundle

export default class extends Controller {
  connect() {
    const swiper = new Swiper('.swiper', {
      spaceBetween: 30,
      slidesPerView: "auto",
      autoplay: {
        delay: 6000,
      },
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
    });

  }
}
