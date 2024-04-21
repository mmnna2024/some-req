document.addEventListener('DOMContentLoaded', () => {
  const radio_button = document.getElementById('confirmable_radio_button');
  radio_button.addEventListener('change', function() {
    if(this.checked) {
      window.confirm('『返送済』に変更後、『更新する』を押すと発送完了メールが自動で送信されます。')
    }
  });
});