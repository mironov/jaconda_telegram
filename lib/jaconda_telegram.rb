require 'jaconda_telegram/version'
require 'rest_client'

module JacondaTelegram
  class Api
    ENDPOINT = 'https://jaconda.im/api/v1/endpoint'
    @@token = nil
    def initialize(token)
      @@token = token
    end

    def list_groups
      begin
        result = RestClient.get "#{ENDPOINT}/groups", { params: { token: @@token } }
      rescue Exception => e
        parse_exception e
      end
      parse_result result.body
    end

    def get_group(id)
      begin
        result = RestClient.get "#{ENDPOINT}/groups", { params: { token: @@token, id: id } }
      rescue Exception => e
        parse_exception e
      end
      parse_result result.body
    end

    def send_message(group_id, text)
      begin
        result = RestClient.post "#{ENDPOINT}/groups/#{group_id}/messages", { token: @@token, text: text }
      rescue Exception => e
        parse_exception e
      end
      parse_result result.body
    end

    def send_media(group_id, file_path)
      begin
        result = RestClient.post "#{ENDPOINT}/groups/#{group_id}/media", { token: @@token, file:  File.new(file_path, 'rb') }
      rescue Exception => e
        parse_exception e
      end
      parse_result result.body
    end

    protected

    def parse_exception(e)
      if e.message.eql?('401 Unauthorized')
        fail 'Invalid Token!'
      else
        fail 'Jaconda is unreachable!'
      end
    end

    def parse_result(data)
      begin
        json_result = JSON.parse data
      rescue
        fail 'Expected JSON got some crap'
      end
      return json_result
    end
  end
end
