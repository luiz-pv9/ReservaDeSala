$(function() {
  $('a.reservation-link').click(function(e) {
    var id = $(this).attr('id'),
      dayIndex = id.split(/\_/)[0],
      timeStart = id.split(/\_/)[1];

    var $this = $(this);
    $.ajax({
      url: '/toggle_register.json',
      type: 'get',
      data: {'day_index': dayIndex, 'time_start': timeStart},
      success: function(res) {
        console.log(res);
        if(res.register == 'ok') {
          $this.html('Excluir');
          $this.parent().find('span').html('Reservado para ' + res.username);
        } else if(res.unregister) {
          $this.html('Disponível');
          $this.parent().find('span').html('');
        }
      }
    });
    e.preventDefault();
    return false;
  });
});