import { Controller } from 'stimulus'

class Admin extends Controller {
  static targets = ['jobParams', 'job', 'time', 'cronExpression', 'submitButton']

  connect() { }

  quickSchedule(e){
    const exp  = e.currentTarget.getAttribute('data-exp')
    const cronExp  = this.cronExpressionTarget
    cronExp.value = exp
    this.checkCron()
  }

  blockField(e) {
    const name = e.currentTarget.dataset.disableBox
    this[name + 'Target'].disabled = !e.currentTarget.checked
  }

  checkCron(e) {
    const cronExp  = this.cronExpressionTarget
    const submitButton  = this.submitButtonTarget
    if (this.isCronValid(cronExp.value)) {
      cronExp.className = 'form-control is-valid'
      submitButton.disabled = false
    } else {
      cronExp.className = 'form-control is-invalid'
      submitButton.disabled = true
    }
  }

   isCronValid(freq) {
    var cronRegex = new RegExp(/^(\*\/\d{1,2}|\d{1,2}|\*)\s(\*|\d{1,2}|\*\/\d{1,2})\s(\*|\*\/\d{1,2}|\d{1,2})\s(\*|\*\/\d{1,2}|\d{1,2})\s(\*|\*\/\d|\d)\s?$/g)
    return cronRegex.test(freq)
  }
}

export default  Admin;