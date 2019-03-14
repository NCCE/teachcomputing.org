function addAcourse() {
  const activity = document.querySelectorAll(
    'p.ncce-activity-list__item-text-completed');
  Array.prototype.forEach.call(activity, h => {
    let button = h.querySelector('button');
    let target = h.nextElementSibling;

    button.onclick = () => {
      let expanded = button.getAttribute('aria-expanded') === 'true';
      button.setAttribute('aria-expanded', !expanded);
      target.hidden = expanded;
    }
  });
}

ready(function () {
  addAcourse()
})
