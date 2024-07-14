import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

export default class extends Controller {
  static targets = ["alert", "notice"];

  connect() {
    console.log("Connected to alerts controller");
    console.log("Notice target:", this.hasNoticeTarget);
    console.log("Alert target:", this.hasAlertTarget);

    if (this.hasNoticeTarget) {
      this.fadeIn(this.noticeTarget);
    }

    if (this.hasAlertTarget) {
      this.fadeIn(this.alertTarget);
    }
  }

  fadeIn(element) {
    if (element) {
      console.log("Fading in element:", element);
      enter(element).then(() => {
        console.log("Element faded in");
        this.fadeOut(element);
      });
    } else {
      console.log("No element to fade in");
    }
  }

  fadeOut(element) {
    if (element) {
      console.log("Setting timeout to fade out element");
      setTimeout(() => {
        console.log("Fading out element:", element);
        leave(element).then(() => {
          console.log("Element faded out");
        });
      }, 3000); // 3 seconds
    } else {
      console.log("No element to fade out");
    }
  }
}