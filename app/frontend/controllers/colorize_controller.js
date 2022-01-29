import { Controller } from '@hotwired/stimulus'

export class ColorizeController extends Controller {
  static targets = ['source']
  static values = { colors: Object }

  call () {
    this.sourceTargets.forEach(ele => {
      if (ele.checked) {
        this.element.style.borderColor = this.colorsValue[ele.dataset.categoryName]
      }
    })
  }
}
