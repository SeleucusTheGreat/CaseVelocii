import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
  

  connect() {
    console.log("connected to modal");
    this.showSignUp();
  }

  showLogIn() {
    const myModalElement= document.getElementById('UserModal');
    const myModal = new bootstrap.Modal(myModalElement);
    myModal.show();
  }

  showSignUp () {
    console.log("imma bout to show the signupform")
    const myModalElement= document.getElementById('SignUpModal');
    const myModal = new bootstrap.Modal(myModalElement);
    myModal.show();
  }

}