function addAcourse() {
  const activity = document.querySelectorAll(
    'p.ncce-activity-list__item-text-completed');
  Array.prototype.forEach.call(activity, h => {
    let btn = h.querySelector('button');
    let target = h.nextElementSibling;

    btn.onclick = () => {
      let expanded = btn.getAttribute('aria-expanded') === 'true';
      btn.setAttribute('aria-expanded', !expanded);
      target.hidden = expanded;
    }
  });
}

ready(function () {
  addAcourse()
})
