import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["card"];

  connect() {
    console.log("connected to cards");

    this.cardTarget.addEventListener("mouseover", this.changeShadow.bind(this, "shadow"));
    this.cardTarget.addEventListener("mouseleave", this.changeShadow.bind(this, "shadow-sm"));
  }

  changeShadow(shadow) {
    this.cardTarget.classList.remove("shadow", "shadow-sm");
    this.cardTarget.classList.add(shadow);
  }

  explore(event) {
    const url = this.element.dataset.url;
    window.location.href = url;
  }
}
