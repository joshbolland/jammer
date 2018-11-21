import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!

flatpickr(".datepicker", {
  altInput: true,
})

flatpickr(".timepicker", {
  enableTime: true,
  noCalendar: true,
  dateFormat: "H:i",
  time_24hr: true

})
