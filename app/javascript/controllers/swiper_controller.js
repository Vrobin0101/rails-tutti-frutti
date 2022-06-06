import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper/bundle';

export default class extends Controller {
  connect() {
    console.log("Hello from swiper");
    const swiper = new Swiper('.swiper', {
      spaceBetween: 30,
      slidesPerView: "auto",
      autoplay: {
        delay: 6000,
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });

  }
}
