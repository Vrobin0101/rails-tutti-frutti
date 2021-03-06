import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper/bundle';

export default class extends Controller {
  connect() {
    const swiper = new Swiper('.swiper', {
      spaceBetween: 30,
      effect: "cards",
      slidesPerView: "auto",
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
      preventClicks: false,
      preventClicksPropagation: false
    });
  }

  navigate(event) {
    window.location = event.currentTarget.querySelector('.swiper-slide-visible > a').href
  }
}
