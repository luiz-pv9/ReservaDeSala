module ScheduleHelper
  def headers
    ['Horário', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta']
  end

  def horarios
    (6..23).to_a
  end

  # Used to format date in the table at root_path
  def horario_format(hora)
    hora = hora.to_s
    if hora.size == 1
      hora = "0" + hora
    end
    "#{hora}:00"
  end

  def has_reservation(reservations, day_index, time_start)
    reservations.find do |res|
      if res.day_index == day_index && res.time_start == time_start
        return res
      end
    end
    nil
  end
end