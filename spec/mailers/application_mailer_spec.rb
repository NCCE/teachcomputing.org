require 'rails_helper'

class TestMailer < ApplicationMailer
  def test_email(record_sent: false)
    mail(to: 'test@example.com', subject: 'Test Email', record_sent_mail: record_sent, mailer_type: 'test', body: 'Test')
  end
end

RSpec.describe ApplicationMailer do
  let!(:user) { create(:user, email: 'test@example.com') }

  describe '.mail' do
    context 'when record_sent_email is false' do
      it 'does not record email being sent' do
        expect { TestMailer.test_email.deliver_now }
          .not_to change(SentEmail, :count)
      end

      it 'queus email to be sent' do
        expect { TestMailer.test_email.deliver_now }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'when record_sent_email is true' do
      it 'records email being sent' do
        expect { TestMailer.test_email(record_sent: true).deliver_now }
          .to change(SentEmail, :count).by(1)
      end

      it 'queus email to be sent' do
        expect { TestMailer.test_email(record_sent: true).deliver_now }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      context 'when recording email errors' do
        before do
          create(:sent_email, mailer_type: 'test', subject: 'Test Email', user: user)
          allow(Raven).to receive(:capture_message)
        end

        it 'does not raise error' do
          expect { TestMailer.test_email(record_sent: true).deliver_now }
            .not_to raise_error
        end

        it 'logs error to sentry' do
          TestMailer.test_email(record_sent: true).deliver_now
          expect(Raven)
            .to have_received(:capture_message)
            .with('Error recording email sending: Validation failed: User has already been taken')
        end

        it 'does not queue email' do
          expect { TestMailer.test_email(record_sent: true).deliver_now }
            .to change { ActionMailer::Base.deliveries.count }.by(0)
        end
      end
    end
  end
end
