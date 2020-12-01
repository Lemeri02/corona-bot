# frozen_string_literal: true

class Messenger
  def self.format_message(covid_data)
    statistics = covid_data.statistics
    country = covid_data.country
    date = covid_data.date

    message(statistics, country, date)
  end

  def self.title(country)
    if country.nil?
      'Статистика глобальная'
    else
      "Статистика для #{country}"
    end
  end

  def self.message(statistics, country, date)
    message_title = title(country)

    return if statistics.nil?

    <<~DATA
      #{message_title}
      Новые случаи: #{statistics['NewConfirmed']}
      Всего заболело: #{statistics['TotalConfirmed']}
      Новые смерти: #{statistics['NewDeaths']}
      Всего умерло: #{statistics['TotalDeaths']}
      Выздоровели: #{statistics['NewRecovered']}
      Всего выздоровели: #{statistics['TotalRecovered']}
      Данные на #{date} (UTC)
    DATA
  end
end
