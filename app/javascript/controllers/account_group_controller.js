import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['dialog'];

  dialogOpen() {
    this.dialogTarget.showModal();
  }

  dialogClose() {
    this.dialogTarget.close();
  }
}
