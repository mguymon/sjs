require 'spec_helper'

require 'sjs/simple_stream'

describe Sjs::SimpleStream do
  describe '#stream' do
    let(:stream) do
      [
        '{',
          '"test": 123,',
          '"split_',
          'line": true',
        '}'
      ]
    end

    let(:result) do
      stream.map { |line| subject.stream(line) }
      subject.flush!
    end

    it 'should convert multiple lines into entities' do
      expect(result).to eql([{ 'test' => 123, 'split_line' => true }])
    end

    context 'with a callback' do
      let(:result) { [] }

      before do
        subject.apply_callback do |entities|
          result << entities
        end
        stream.each { |line| subject.stream(line) }
        subject.flush!
      end

      it 'should convert multiple lines into entities' do
        expect(result).to eql([{ 'test' => 123, 'split_line' => true }])
      end
    end
  end

  describe '#reset!' do
    context 'with some bad json' do
      let(:bad_json) { "{cabbage, knicks, it hasn't got a beck!}" }

      it 'will reset the stream buffer' do
        subject.stream(bad_json)
        expect { subject.flush! }.to raise_error described_class::StreamError
        subject.reset!
        expect(subject.stream('')).to be
      end
    end
  end
end
