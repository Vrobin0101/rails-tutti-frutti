import { Controller } from "@hotwired/stimulus"
import Swiper from "swiper"
// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log("swiper")
    var swiper = new Swiper(".mySwiper", {
      slidesPerView: "auto",
      spaceBetween: 30,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
    });
    console.log(swiper)
  }
}
