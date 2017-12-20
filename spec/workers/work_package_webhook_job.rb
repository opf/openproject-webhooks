#-- encoding: UTF-8
#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2017 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

describe WorkPackageWebhookJob, type: :model, webmock: true do
  let(:title) { "Some workpackage subject" }
  let(:work_package) { FactoryGirl.create :work_package, subject: title }

  let(:secret) { nil }
  let(:webhook) { FactoryGirl.create :webhook, url: "http://example.net/test/42", secret: secret }

  let(:user) { FactoryGirl.create :admin }

  before do
    User.current = user
  end

  describe "triggering a work package update" do
    let(:event) { "work_package:updated" }
    let(:job) { WorkPackageWebhookJob.new webhook.id, work_package.journals.last.id, event }

    let(:response_code) { 200 }
    let(:response_body) { "hook called" }
    let(:response_headers) do
      { content_type: "text/plain", x_spec: "foobar" }
    end

    let(:stub) do
      stub_request(:post, "example.net/test/42")
        .with(
          body: hash_including(
            "action" => event,
            "work_package" => hash_including(
              "_type" => "WorkPackage",
              "subject" => title
            )
          )
        )
        .to_return(
          status: response_code,
          body: response_body,
          headers: response_headers
        )
    end

    before do
      stub
      job.perform
    end

    it "calls the webhook url" do
      expect(stub).to have_been_requested
    end

    it "creates a log for the call" do
      log = Webhooks::Log.last

      expect(log.webhook).to eq webhook
      expect(log.url).to eq webhook.url
      expect(log.response_code).to eq response_code
      expect(log.response_body).to eq response_body
      expect(log.response_headers).to eq response_headers
    end
  end
end
