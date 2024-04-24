document.addEventListener('DOMContentLoaded', () => {
  const radioButton = document.getElementById('confirmable_radio_button');
  if (!radioButton){ return false;}
  radioButton.addEventListener('change', function() {
    if(this.checked) {
      window.confirm('『返送済』に変更後、『更新する』を押すと発送完了メールが自動で送信されます。')
    }
  });
});