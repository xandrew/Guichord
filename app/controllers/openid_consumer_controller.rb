require 'openid'
require 'openid/extensions/ax'
require 'openid/extensions/sreg'
require 'openid/store/filesystem'

class OpenidConsumerController < ApplicationController
  def index
    # render an openid form
  end

  def start
    begin
      oidreq = consumer.begin('https://www.google.com/accounts/o8/id')
    rescue OpenID::OpenIDError => e
      flash[:error] = "Discovery failed for #{identifier}: #{e}"
      redirect_to :action => 'index'
      return
    end

    axreq = OpenID::AX::FetchRequest.new
    email_attr = OpenID::AX::AttrInfo.new('http://axschema.org/contact/email',
                                          'email',
                                          true)
    axreq.add(email_attr)
    oidreq.add_extension(axreq)

    return_to = url_for :action => 'complete', :only_path => false
    realm = root_url
    
    redirect_to oidreq.redirect_url(realm, return_to)
  end

  def complete
    # FIXME - url_for some action is not necessarily the current URL.
    current_url = url_for(:action => 'complete', :only_path => false)
    parameters = params.reject{|k,v|request.path_parameters[k.to_sym]}
    oidresp = consumer.complete(parameters, current_url)
    case oidresp.status
    when OpenID::Consumer::FAILURE
      if oidresp.display_identifier
        flash[:error] = ("Verification of #{oidresp.display_identifier}"\
                         " failed: #{oidresp.message}")
      else
        flash[:error] = "Verification failed: #{oidresp.message}"
      end
    when OpenID::Consumer::SUCCESS
      flash[:success] = ("Verification of #{oidresp.display_identifier}"\
                         " succeeded.")
      aix_resp = OpenID::AX::FetchResponse.from_success_response(oidresp)
      flash[:alma] = "AIX resp: #{aix_resp['http://axschema.org/contact/email']}"

    when OpenID::Consumer::SETUP_NEEDED
      flash[:alert] = "Immediate request failed - Setup Needed"
    when OpenID::Consumer::CANCEL
      flash[:alert] = "OpenID transaction cancelled."
    else
    end
    redirect_to :action => 'index'
  end

  def consumer
    if @consumer.nil?
      dir = Pathname.new(RAILS_ROOT).join('db').join('cstore')
      store = OpenID::Store::Filesystem.new(dir)
      @consumer = OpenID::Consumer.new(session, store)
    end
    return @consumer
  end
end
