import { Controller } from 'stimulus'

class Admin extends Controller {
  static targets = [ 'status', 'frequency', 'frequencyType', 'createJob', 'time', 'jobParams', 'job', 'time', 'atCheckBox']
  static baseUrl = ''

  constructor(...args) {
    super(...args)
    this.ranges = {
      minute: this.range(1, 59),
      hour: this.range(1, 23),
      days: this.range(1, 31),
      month: this.rangeForMonth(),
      daysw: this.rangeForDaysOfWeek(),
    }
  }

  connect() { }

  blockTime(e) {
    this.timeTarget.disabled = !e.target.checked
  }

  range(start, end) {
    return Array.from({ length: end }, (v, i) => { return { value: i + start, displayValue: i + start + '' } });
  }

  rangeForDaysOfWeek() {
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'].map((item, index) => { return { value: index, displayValue: item } })
  }

  rangeForMonth() {
    return ['Jan', 'Feb',
            'Mar', 'Apr',
            'May', 'Jun',
            'Jul', 'Aug',
            'Sep', 'Oct', 'Nov', 'Dec'].map((item, index) => { return { value: index, displayValue: item } })
  }

  changeFrequency(e) {
    const selectedIndex = e.target.selectedIndex
    const selectedValue = e.target[selectedIndex].value
    const selectBox = this.frequencyTarget
    selectBox.innerHTML = ''
    this.ranges[selectedValue].forEach(item => {
      const opt = document.createElement('option');
      opt.value = item.value;
      opt.innerHTML = item.displayValue;
      selectBox.appendChild(opt);
    })
  }
}

export default  Admin;