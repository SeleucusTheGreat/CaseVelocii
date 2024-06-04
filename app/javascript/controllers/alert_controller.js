import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

export default class extends Controller {
  static targets = ["alert", "notice"];

  connect() {
    console.log("connected to alerts");
    if (this.hasNoticeTarget) {
      this.fadeIn(this.noticeTarget);
      this.fadeOut(this.noticeTarget);
    }
    if (this.hasAlertTarget) {
      this.fadeIn(this.alertTarget);
      this.fadeOut(this.alertTarget);
    }
    
  }


  fadeIn(element) {
    if (element) {
      
        enter(element);
        console.log("element fadedIn"); 
    } else {
      console.log("no element");
    }
  }

  fadeOut(element) {
    if (element) {
      setTimeout(() => {
        leave(element);
        console.log("element fadedOut"); 
      }, 3000); // 3 seconds
    } else {
      console.log("no element");
    }
  }
}