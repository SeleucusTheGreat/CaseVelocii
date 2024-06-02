import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }


  static targets = ["card"]

  connect() {
    this.cardTarget.addEventListener("mouseover",this.changeShadow.bind(this,"shadow"));
    this.cardTarget.addEventListener("mouseleave", this.changeShadow.bind(this, "shadow-sm"));
  }

  changeShadow(shadow) {
    this.cardTarget.classList.remove("shadow", "shadow-sm");
    this.cardTarget.classList.add(shadow);
  }
}
