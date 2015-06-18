require 'ruboto/widget'
require 'ruboto/util/toast'
# require 'open-uri'
require 'json'
# require 'forecast_io'

ruboto_import_widgets :Button, :LinearLayout, :TextView

# http://xkcd.com/378/

class PointyActivity
  def onCreate(bundle)
    super
    set_title 'Pointy!'

    self.content_view =
        linear_layout :orientation => :vertical do
          @text_view = text_view :text => '', :id => 42,
                                 :layout => {:width => :match_parent},
                                 :gravity => :center, :text_size => 48.0
          button :text => 'Should I water my Cactus?',
                 :layout => {:width => :match_parent},
                 :id => 43, :on_click_listener => proc { rain_arizona }
        end
  rescue Exception
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private

  def get_location(cactus_type=nil)
     # get longitude latitude of cactus
     # get location of cactus type
     if cactus_type == nil
         long = '-111.0000'
         lat = '31.8500'
         return lat, long
     end
  end

  def rain_arizona
    #   ForecastIO.configure do |configuration|
    #       configuration.api_key = ENV['FORECAST_IO_API_KEY']
    #   end
    api_key =
      lat, long = get_location
    #   # get forcast of  long, lat
    #   forecast = ForecastIO.forecast(long, lat)
    # if forecast.currently.precipProbability > 0
    response = open('https://api.forecast.io/forecast/APIKEY/lat,long')
    responseHash = JSON.parse(respeonse.read)
    precipProbability = responseHash['currently']['precipProbability']

      if  precipProbability > 0
          @text_view.text = """Its raining in Arizona.
                              You shouldr water your Cactus."""
      else
          @text_view.text = """It's not raining in Arizona.
                              Don't water your cactus today!"""
      end
  end

end
